#!/usr/bin/env bash
# DPTC one-command deploy (git-bash / WSL / Linux / macOS).
#
# dpowelltc.com is served from the Ohio box's /var/www/html, not GitHub Pages.
# This pushes your local commits to GitHub main, tells the box to pull + publish,
# then prints the result.
#
# Usage:
#   scripts/deploy.sh            # push, then deploy
#   scripts/deploy.sh --no-push  # deploy whatever is already on main
set -euo pipefail

INSTANCE=i-088a1050030cac14d
REGION=us-east-2
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "${1:-}" != "--no-push" ]; then
  echo "-> pushing local commits to origin/main"
  git -C "$REPO_ROOT" push origin HEAD:main
fi

echo "-> triggering box deploy (SSM)"
# MSYS_NO_PATHCONV is set ONLY on this call so Git-Bash (Windows) doesn't rewrite the
# /opt/... path into C:\...; setting it globally would break git's own path handling.
CMD=$(MSYS_NO_PATHCONV=1 aws ssm send-command \
  --instance-ids "$INSTANCE" --region "$REGION" \
  --document-name AWS-RunShellScript \
  --parameters commands=/opt/deploy-dpowelltc.sh \
  --query 'Command.CommandId' --output text)

while :; do
  sleep 3
  S=$(aws ssm get-command-invocation --command-id "$CMD" --instance-id "$INSTANCE" --region "$REGION" --query 'Status' --output text)
  case "$S" in Pending|InProgress) ;; *) break ;; esac
done

aws ssm get-command-invocation --command-id "$CMD" --instance-id "$INSTANCE" --region "$REGION" --query 'StandardOutputContent' --output text
if [ "$S" != "Success" ]; then
  echo "DEPLOY FAILED: $S"
  aws ssm get-command-invocation --command-id "$CMD" --instance-id "$INSTANCE" --region "$REGION" --query 'StandardErrorContent' --output text
  exit 1
fi
echo "Done."
