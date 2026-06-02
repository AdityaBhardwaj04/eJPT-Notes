---
title: DNS Reconnaissance
tags: [eJPT, Reconnaissance, DNS, Passive]
created: 2026-03-30
source: Notion
---

# DNS Reconnaissance

**Related:** [[WHOIS-Enumeration]] | [[Subdomain-Enumeration]] | [[WAF-Detection-wafw00f]] | [[Website-Recon]] | [[00-INDEX]]

---

## What is DNS Recon?

DNS reconnaissance is **passive** enumeration of DNS records associated with a domain. The goal is to understand how the target infrastructure is configured.

**Records to look for:**

| Record | Purpose |
|---|---|
| **A** | IPv4 address of the domain |
| **AAAA** | IPv6 address |
| **MX** | Mail server address |
| **NS** | Name servers (reveals CDN/proxy usage) |
| **TXT** | Diagnostic info, SPF records, Google verification |
| **CNAME** | Canonical name / aliasing |

---

## Tool 1 — dnsrecon (CLI)

Pre-installed on Kali Linux.

```bash
dnsrecon -d <domain>
```

**Example:**
```bash
dnsrecon -d hackasploit.org
dnsrecon -d zonetransfer.me
```

**Output includes:**
- NS records (name servers + IPs)
- A records (IPv4)
- AAAA records (IPv6)
- MX records (mail server)
- TXT records (SPF, Google verification)
- DNSSEC status

> **Tip:** If a domain uses Cloudflare, the A record won't reveal the real server IP — but the **MX record** often does, since Cloudflare doesn't proxy mail.

---

## Tool 2 — DNSdumpster (Web, Recommended)

**URL:** `dnsdumpster.com`

Free, browser-based DNS research tool that organizes DNS data visually.

**Features:**
- DNS servers with IPs and owning organizations
- MX records (mail servers — often not behind CDN)
- TXT records
- A records + discovered **subdomains** → [[Subdomain-Enumeration]]
- Clickable actions per record: HTTP headers, zone transfer attempt, MTR trace, passive host search
- **Graphical DNS map** — exportable as PNG or Excel spreadsheet
- Tags checks as passive or active

**Why it's powerful:**
- Reveals subdomains alongside DNS records
- Visual graph shows entire infrastructure hierarchy
- MX records often bypass Cloudflare masking — reveals real mail server

**Example graph structure:**
```
zonetransfer.me
├── NS: nszDM2.dg.ninja (AWS) — IP visible
├── NS: primary NS — IP visible
└── MX: → Google (G Suite confirmed)
    └── A records → OVH hosting
```

---

## Key Observations

- Sites behind Cloudflare: A record shows Cloudflare IP (not real server) → [[WAF-Detection-wafw00f]]
- MX records are usually **not** proxied — can reveal real mail infrastructure
- TXT records often contain Google Site Verification tokens → confirms analytics setup
- Subdomain discovery through DNS is **passive** recon

---

## Key Takeaways

- `dnsrecon` is the go-to CLI tool for DNS enumeration on Kali
- **DNSdumpster** is the preferred tool for organized, visual DNS recon
- MX records can bypass CDN masking and expose real server IPs
- DNS recon is fully **passive** — no direct probing of the target
- Always check TXT records — they reveal third-party services (Google, Stripe, etc.)
