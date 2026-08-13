# DPTC On-Site SEO / Visibility Audit — 2026-07-29

Audit + plan only. Nothing deployed. Every fix below is written so it can be
implemented on David's approval. Live pages fetched via curl; repo files at
`DPTC-Website/`. Repo was synced (`git pull --rebase`, already up to date).

Pages reviewed: `/` `/missed-call-audit` `/hvac-missed-calls`
`/plumbing-missed-calls` `/mechanics-missed-calls` `/accountants-missed-calls`
`/how-we-work` `/privacy` `/cybersecurity-audit-orlando` plus the
`pool-service-missed-calls` redirect stub, `sitemap.xml`, `robots.txt`.

---

## What's already solid (leave alone)
- **Canonical host + redirects:** apex `dpowelltc.com` 301s to `www`, matching
  canonicals and sitemap. Consistent.
- **Titles:** all 9 pages 54–60 chars, unique, keyword-targeted, `| DPTC` brand
  suffix. Good.
- **One H1 per page**, all unique and descriptive.
- **Phone NAP is clean:** `(407) 269-1580` / `407.269.1580` / `tel:+14072691580`
  / schema `+1-407-269-1580` on every page. No trace of the old `674-9203`.
- **Image alt text:** every `<img>` sampled has an `alt` attribute.
- **Viewport** present and correct on all pages (mobile-ready).
- **Analytics:** GTM + GA4 on all 9 indexable pages.
- **Structured data (funnel pages):** homepage carries a rich
  ProfessionalService/LocalBusiness graph (address locality/region, geo, hours,
  areaServed cities, AggregateRating, 3 Reviews, FAQPage, Service/Offer catalog).
  Trade + cyber pages each carry Service + FAQPage + BreadcrumbList. Strong.
- **robots.txt** allows all + points to the (www) sitemap. Correct.
- **CSS/JS is inline** per page — no render-blocking external stylesheet; only
  Google Fonts is external (with preconnect). Lean.

---

## HIGHEST-IMPACT FIXES (ranked)

### 1. Nav/footer trade list is stale — omits Mechanics & Accountants, advertises dead "Pool"  ★ biggest win
Every page's top nav, mobile menu, and footer lists **Pool / HVAC / Plumbing**.
Two problems:
- **Mechanics and Accountants pages are near-orphans** — they are NOT in any
  nav or footer; each is reachable only from a single homepage link. New,
  indexable, real pages getting almost no internal link equity.
- **"Pool" points to `pool-service-missed-calls`**, which is a `noindex, follow`
  redirect stub that bounces straight back to `/missed-call-audit`. So the
  audit page links "Pool" → a noindex page → back to itself (a crawl loop), and
  link equity is poured into a page that can't rank.

Confirmed link targets to the stub:
- `missed-call-audit.html` lines **269** (desktop nav), **287** (mobile nav),
  **443** (footer)
- `cybersecurity-audit-orlando.html` line **481** (footer, labeled
  "Missed-Call Text-Back")

**Exact change (apply to nav, mobile nav, and footer on *every* page that has the
trade list — index, missed-call-audit, all four trade pages, cyber, how-we-work,
privacy):** replace the Pool `<li>` and add the two missing trades. In
`missed-call-audit.html` the desktop-nav block becomes:
```html
<li><a href="index.html">Home</a></li>
<li><a href="hvac-missed-calls">HVAC</a></li>
<li><a href="plumbing-missed-calls">Plumbing</a></li>
<li><a href="mechanics-missed-calls">Auto Repair</a></li>
<li><a href="accountants-missed-calls">Accounting</a></li>
<li><a href="index.html#contact">Contact</a></li>
```
Mirror the same list in the mobile menu (lines ~286–290) and footer (lines
~442–445), and in the `cybersecurity-audit-orlando.html` footer (line 481),
relabeling the stub link to the real trades or to `missed-call-audit`.
- **Decision for David:** is Pool still an offered trade? If yes → build a real
  `pool-missed-calls` page (mirror the HVAC template) and point these links
  there. If no → drop Pool from nav/footer entirely (recommended, since the
  stub is noindex). Do NOT keep linking nav/footer to a noindex redirect.

### 2. Two OG share images are broken (404 / 503)  ★ easy, visible
Both newest trade pages reference OG cards that don't exist in the repo, so
social/text-message shares render a broken image:
- `https://www.dpowelltc.com/og/mechanics-missed-calls.png` → **503**
- `https://www.dpowelltc.com/og/accountants-missed-calls.png` → **404**
`og/` contains cards for index, missed-call-audit, hvac, plumbing, cyber (all
200) and an **unused** `pool-service-missed-calls.png`. **Fix:** generate
`og/mechanics-missed-calls.png` and `og/accountants-missed-calls.png` at
1200×630 in the same template as the others and commit them to `og/`. (The
`<meta property="og:image">` tags already point at the right filenames — only
the image files are missing.)

### 3. Cybersecurity page is a near dead-end and doesn't reach the funnel
`cybersecurity-audit-orlando.html` in-body links only to `#coverage/#how/#faq`,
its own URL, and the pool stub in the footer. It does **not** link to
`/missed-call-audit` (the funnel front door) or to any trade page, and its only
"home" path is the logo. **Fix:** add a contextual internal link in the body
(e.g. a closing "Also serving home-services trades →" line) pointing to
`/missed-call-audit`, and fix the footer per Fix #1. This both feeds the funnel
and passes equity from a keyword-strong page ("Cybersecurity Audit Orlando").

### 4. `/missed-call-audit` doesn't list Mechanics or Accountants
The funnel hub page cross-links only HVAC and Plumbing (plus the dead Pool). It
never links to the mechanics or accountants pages. **Fix:** covered by Fix #1's
nav/footer update; additionally add the two trades to any in-body "who this is
for / choose your trade" section on the audit page so both directions of the
silo are linked.

### 5. Internal "home" links use `index.html` while canonical is `/`
Every subpage links home via `href="index.html"` (5 instances per page).
`https://www.dpowelltc.com/index.html` returns **200** (not a redirect) while the
declared canonical is `/` — so both URLs resolve, a mild duplicate-URL signal
and a break from the site's extensionless convention. **Fix:** change subpage
home links from `href="index.html"` → `href="/"` and `href="index.html#contact"`
→ `href="/#contact"` sitewide. Low effort, sitewide, done alongside Fix #1.

### 6. Over-long meta descriptions (SERP truncation)
Under ~155 chars is ideal. Currently long enough to truncate:
- `how-we-work` — **216 chars** (trim hardest)
- `mechanics-missed-calls` — **195**
- `cybersecurity-audit-orlando` — **175**
- `accountants-missed-calls` — **173**
(Homepage 136, audit 154, hvac 151, plumbing 150, privacy 125 are fine.)
**Fix:** tighten each of the four to ~150–155 chars, keeping the lead keyword +
"Orlando, FL." Keep §8 voice (specific, no hype).

### 7. `how-we-work` & `privacy` use the 1.9 MB logo as their OG image
Both set `og:image` / `twitter:image` to `dptc-logo.png` — a **1.9 MB**,
1448×1086 file (wrong ratio for social, and heavy). **Fix:** create proper
1200×630 cards (`og/how-we-work.png`, `og/privacy.png`) in the shared template
and repoint the tags. Minor, but fixes ugly/oversized share previews.

### 8. Thin structured data on `how-we-work`; none on `privacy`
`how-we-work` carries only a minimal `WebPage` node (no BreadcrumbList);
`privacy` has no JSON-LD and no `twitter:card`. **Fix (optional, low):** add a
`BreadcrumbList` to `how-we-work` (Home › How We Work) to match the trade pages,
and add `twitter:card = summary_large_image` to `privacy`. Privacy needs no rich
schema otherwise.

### 9. Repo/asset hygiene (page-speed + cleanliness)
- Root **`styles.css` (1.9 MB) is actually a mislabeled PNG** (identical bytes to
  `dptc-logo.png`) and is **not referenced by any page** — dead weight in the
  repo. Recommend removing it.
- `css/styles.css` (37 KB) and `js/main.js` (2.5 KB) are **not referenced** by any
  page (all styling/JS is inline). Harmless but dead; safe to delete.
- `og/pool-service-missed-calls.png` is unused (pool page is noindex). Remove if
  Pool is retired (Fix #1).
None of these are render-blocking today, but clearing them keeps the repo honest.

### 10. LocalBusiness address — no street/postal code (optional)
Homepage schema has `addressLocality` (Orlando) + `addressRegion` (FL) + geo, but
no `streetAddress` or `postalCode`. Acceptable for a service-area business; if
David is comfortable, adding a `postalCode` strengthens the local signal. **Do
not fabricate a street address** — only add real, verified data.

---

## Sitemap / robots — status
- `sitemap.xml` lists all 9 indexable pages with sane lastmod/priority and
  correctly **excludes** the noindex pool stub. Good.
- After Fix #2/#7 (new pages/images) no sitemap change is needed unless a real
  Pool page is built — then add it.
- robots.txt: correct.

## §8 voice note (not an SEO fix, flag for David)
Trade H1s/descriptions lean on "your competitor just booked" / "stop losing
jobs to voicemail." These are specific and factual-adjacent, but "competitor"
framing is a close cousin of the banned "stop funding your competitors" line.
Not changing anything — flagging in case David wants to soften on the next pass.

---

## Suggested implementation order (all pending David's approval)
1. Fix #1 (nav/footer trade list + retire/repoint Pool) — sitewide, biggest gain
2. Fix #2 (build the two missing OG cards)
3. Fixes #3 + #4 (funnel internal links: cyber → audit; audit → mechanics/accountants)
4. Fix #5 (home links → `/`) — bundle with #1
5. Fix #6 (trim 4 meta descriptions)
6. Fixes #7–#10 (OG cards for how-we-work/privacy, breadcrumb, hygiene, postal code)
