---
title: WHOIS Enumeration
tags: [eJPT, Reconnaissance, WHOIS, Passive]
created: 2026-03-30
source: Notion
---

# WHOIS Enumeration

**Related:** [[Website-Recon]] | [[DNS-Reconnaissance]] | [[Active-vs-Passive-Recon]] | [[00-INDEX]]

---

## What is WHOIS?

WHOIS is a **query/response protocol** used to look up registration details for:
- Domain names
- IP address blocks
- Autonomous systems (AS numbers)

Useful for understanding **who owns a domain** and how it's configured.

---

## WHOIS on a Domain (CLI)

```bash
whois <domain>
```

**Example:**
```bash
whois hackasploit.org
whois zonetransfer.me
```

**Information returned:**
- Domain name and registry ID
- Registrar (e.g., Namecheap, GoDaddy)
- Registrar WHOIS server URL
- Creation date, last updated, expiry date
- Name servers (reveals if Cloudflare is in use)
- DNSSEC status
- Registrant contact info (may be **redacted** for privacy)

---

## WHOIS on an IP Address

```bash
whois <IP address>
```

**Returns:**
- Network range (CIDR)
- Network name (e.g., `CLOUDFLARE-NET`)
- Owning organization + address
- Abuse contact emails

**Use case:** Identify which company/ISP owns the IP block hosting a target.

---

## WHOIS via Web

Sites like **who.is** provide the same data in a browser-friendly format.
- Useful when CLI output is hard to parse
- Some sites show additional context (registrant country, email, etc.)
- Note: some data may be incorrect/anonymized via privacy services

---

## Privacy Protection & What to Look For

- Many registrars (Cloudflare, Namecheap) offer **WHOIS privacy** — personal info is redacted
- If privacy is **not** enabled: may expose owner name, email, address
- Exposed email addresses can be used for **phishing** during a pentest
- Always check name servers — they reveal proxy/WAF usage (e.g., `ns.cloudflare.com`) → [[WAF-Detection-wafw00f]]

---

## Key Takeaways

- WHOIS reveals registrar, registration dates, name servers, and sometimes owner info
- Always run WHOIS on both the **domain** and any identified **IP addresses**
- Name servers in WHOIS output confirm whether a site uses Cloudflare or another proxy
- Privacy protection is common — don't expect personal info to always be available
- WHOIS data is useful intel for social engineering and phishing scenarios in a pentest
