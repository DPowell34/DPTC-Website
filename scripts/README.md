# Deploying dpowelltc.com

**dpowelltc.com is served from the Ohio box's `/var/www/html` (DPTC‑Server 1, `i-088a1050030cac14d`, us‑east‑2) — not GitHub Pages.** This repo is the source of truth; a `git push` alone does **not** update the live site. You also have to tell the box to pull and publish. These scripts do both in one command.

## One command

```bash
scripts/deploy.ps1        # Windows PowerShell
scripts/deploy.sh         # git-bash / WSL / Linux / macOS
```

What it does:
1. `git push origin HEAD:main` (skip with `-NoPush` / `--no-push`)
2. Triggers the box (via AWS SSM) to run `/opt/deploy-dpowelltc.sh`, which:
   - pulls `main` into `/opt/dpowelltc-src`
   - backs up the current live docroot to `/root/deploy-backups/www-<timestamp>.tgz` (keeps the last 10)
   - copies the site into `/var/www/html`, **excluding** `.git`, `.github`, `scripts/`, `build/`, `.gitignore` (repo tooling + internal docs are never served publicly)
3. Prints the deployed commit and verifies the live URL.

No nginx reload is needed — nginx serves the files directly.

## Requirements

The AWS CLI, configured with an identity allowed to `ssm:SendCommand` on the instance
(`i-088a1050030cac14d`, region `us-east-2`). Verify with:

```bash
aws sts get-caller-identity
```

## Rollback

Backups are on the box at `/root/deploy-backups/`. To restore the previous version:

```bash
# on the box (via SSM):
tar xzf /root/deploy-backups/www-<timestamp>.tgz -C /var/www/html
```

## TLS / vhost (for reference)

Served by the `dptc-nginx` container via `/opt/docker-stack/nginx/conf.d/dptc.conf`
(HTTP→HTTPS redirect + `listen 443 ssl`, `try_files $uri $uri.html $uri/` for extensionless URLs).
Cert `/etc/letsencrypt/live/dpowelltc.com/` covers `dpowelltc.com` + `www.dpowelltc.com`
(LE account `20b4…`; auto‑renews). Config changes there **do** need `docker exec dptc-nginx nginx -s reload`.
