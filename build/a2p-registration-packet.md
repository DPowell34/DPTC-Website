# A2P 10DLC Registration Packet — DPTC

**For:** KAN-44 (C1 — Start A2P 10DLC registration). **Owner:** David.
**Purpose:** Everything you paste into the Brand + Campaign registration forms, in one place, so the
"~20 minutes of forms" is copy-paste. A2P 10DLC is a **carrier requirement** — it applies to Twilio,
OpenPhone, LeadConnector, or any business-SMS platform (see KAN-84), so this packet is platform-neutral.

> **Provider still undecided (KAN-84).** Register the brand/campaign inside whichever platform you land
> on. The Campaign Registry (TCR) fields below are identical across providers — only the UI wrapper differs.

---

## ⚠️ Fill these before submitting — the only blanks
The rest of the packet is ready to paste as-is. These need your records:

| Field | Value | Notes |
|---|---|---|
| Legal business name | **[FILL]** | Must match IRS/EIN records EXACTLY (a mismatch is the #1 rejection cause) |
| Legal entity type | **[FILL]** | Sole Proprietor / LLC / S-Corp / etc. |
| EIN (Tax ID) | **[FILL]** | Sole-prop with no EIN → register as **Sole Proprietor** brand (different, lighter flow — lower throughput but no EIN needed) |
| Business address | **[FILL]** | Registered business address (Orlando, FL) |
| Business phone | 407.269.1580 | (confirm this is the best callback number) |
| Support email | david.a.powell1@gmail.com | (a support@dpowelltc.com alias reads more legit if easy to add) |
| The 10-digit sending number | **[FILL after purchase]** | The 407 number you buy in-platform |

---

## 1. Brand Registration (the business identity)

| TCR field | Value to enter |
|---|---|
| Legal company name | **[FILL — exact IRS match]** |
| DBA / brand name | David Powell Tech Consulting (DPTC) |
| Entity type | **[FILL]** |
| EIN / Tax ID | **[FILL]** |
| Country of registration | US |
| Business address | **[FILL]** |
| Website | https://dpowelltc.com |
| Vertical / industry | Professional Services (Marketing / IT services) |
| Business contact — name | David Powell |
| Business contact — email | david.a.powell1@gmail.com |
| Business contact — phone | 407.269.1580 |
| Stock symbol / exchange | N/A (private) |

**Tip:** If you have no EIN, the **Sole Proprietor** brand path skips EIN verification. It caps daily
throughput (fine for early client volume) and can be upgraded to a Standard brand later once you have an EIN.

---

## 2. Campaign Registration (what you'll actually send)

| TCR field | Value to enter |
|---|---|
| Use case | **Customer Care** (a.k.a. "Mixed" if the platform requires) — conversational replies + appointment/notification texts |
| Campaign description | *See below — paste verbatim* |
| Sample messages | *See §3 — provide at least 2* |
| Message flow / opt-in description | *See §4 — paste verbatim* |
| Opt-in keywords | START, YES |
| Opt-out keywords | STOP, STOPALL, UNSUBSCRIBE, CANCEL, END, QUIT |
| Help keywords | HELP, INFO |
| Opt-out message | *See §5* |
| Help message | *See §5* |
| Embedded links? | **Yes** (Job Leak Report / booking links) |
| Embedded phone numbers? | **Yes** (our callback number) |
| Age-gated / affiliate / SHAFT content? | No |
| Number pooling? | No (single number to start) |

### Campaign description (paste verbatim)
> David Powell Tech Consulting sends text messages to home-services business owners (pool, HVAC,
> plumbing) who have contacted us. Messages include: (1) an automated reply when a caller reaches
> voicemail so no lead is lost, (2) delivery of a requested "Job Leak Report" from our missed-call
> audit tool, and (3) appointment scheduling and confirmations for free consultations. All recipients
> have either called us directly or explicitly opted in via a checkbox on our website. Every message
> identifies the sender and includes opt-out instructions.

---

## 3. Sample messages (provide these to TCR — must reflect real traffic)

1. **Missed-call text-back (auto-reply):**
   > Hi, it's David Powell Tech Consulting — sorry we missed your call! Reply here and we'll get right
   > back to you, or call 407.269.1580. Reply STOP to opt out, HELP for help.

2. **Audit report delivery:**
   > Thanks for using the DPTC Missed-Call Audit! Here's your free Job Leak Report:
   > https://dpowelltc.com/report/xxxx . Questions? Just reply. Reply STOP to opt out.

3. **Appointment confirmation:**
   > Your free consultation with David Powell Tech Consulting is set for Thu 8/28 at 2:00 PM ET.
   > Reply C to confirm or R to reschedule. Reply STOP to opt out, HELP for help.

*(Every sample includes sender identity + opt-out — carriers reject samples that don't.)*

---

## 4. Opt-in / consent description (paste verbatim)

> Consent is obtained two ways, both documented:
>
> **(a) Website checkbox (express written consent).** On our missed-call audit page
> (dpowelltc.com/missed-call-audit) the visitor checks an unchecked-by-default box that reads:
> *"Text me the report. By checking this box I agree to receive text messages from David Powell Tech
> Consulting at the number provided. Msg & data rates may apply. Msg frequency varies. Reply STOP to
> opt out, HELP for help."* The submission stores the exact consent text and timestamp.
>
> **(b) Inbound caller (conversational).** When a prospective customer calls our business number and
> reaches voicemail, our system replies by text to continue the conversation they initiated. This is
> conversational messaging in direct response to the customer's own inbound contact.
>
> We do not purchase lists, and consent is never shared with third parties. Opt-out is honored
> immediately and permanently.

**Screenshot to attach (if the platform asks for opt-in proof):** the audit page's checkbox with the
consent wording visible. (Live at https://dpowelltc.com/missed-call-audit — scroll to the form.)

---

## 5. Required auto-replies (configure in the platform)

- **HELP:**
  > David Powell Tech Consulting: for help call 407.269.1580 or email david.a.powell1@gmail.com.
  > Msg & data rates may apply. Reply STOP to unsubscribe.
- **STOP (opt-out confirmation):**
  > You're unsubscribed from David Powell Tech Consulting texts and will receive no more messages.
  > Reply START to opt back in.

---

## 6. Timeline & what to log back to KAN-44

- Brand registration: **1–7 business days**
- Campaign vetting: **~10–15 days** (volume-driven, mid-2026)
- A rejection **restarts the clock** — so submit clean the first time (exact legal-name match is the
  usual trip-up).

**When submitted, log on KAN-44:** submission date, brand ID, campaign ID, and platform, so we can
track queue position. That's the "DONE WHEN" on the ticket.

---
*Prepared 2026-08-25 for KAN-44. Consent wording mirrors the live audit page exactly (no invented text).*
