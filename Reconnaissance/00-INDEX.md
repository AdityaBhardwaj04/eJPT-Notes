---
title: Reconnaissance — Index
tags: [eJPT, Reconnaissance, PassiveRecon, Index, Hub]
created: 2026-04-06
source: Notion
---

# Reconnaissance

**Related:** [[00-INDEX]] | [[Footprinting-and-Scanning/00-INDEX]] | [[Enumeration/00-INDEX]]

---

## Overview

Reconnaissance is the first phase of the pentest methodology. The goal is to gather as much information as possible about the target **without directly interacting with their systems** (passive) or with minimal/controlled interaction (active).

```
Passive Recon  ← This section
    ↓
Active Recon (Host Discovery → Port Scanning)
    ↓
Enumeration
    ↓
Exploitation
```

---

## Notes in This Section

| Note | Topic |
|---|---|
| [[Active-vs-Passive-Recon]] | Core distinction, when to use each, 4-step strategy |
| [[Target-Scoping]] | LOE, ROE, in/out of scope, domain/IP/app-based scoping |
| [[Website-Recon]] | host command, robots.txt, sitemap.xml, BuiltWith, Wappalyzer, whatweb |
| [[WHOIS-Enumeration]] | whois on domains and IPs, privacy protection |
| [[Netcraft]] | SSL/TLS cert info, hosting history, site technology fingerprinting |
| [[DNS-Reconnaissance]] | DNS record types, dnsrecon CLI, DNSdumpster web tool |
| [[WAF-Detection-wafw00f]] | wafw00f flags, results interpretation, WAF fingerprinting |
| [[Subdomain-Enumeration]] | sublist3r flags, rate limiting, passive vs active subdomain discovery |
| [[Google-Dorks]] | Dork operators table, GHDB, Wayback Machine |
| [[Email-Harvesting]] | theHarvester flags, sources, crtsh, rapiddns |
| [[Leaked-Password-Databases]] | HIBP manual + API, k-anonymity endpoint |

---

## Key Tools

| Tool | Purpose |
|---|---|
| `whois` | Domain/IP registration data |
| `host` | DNS lookups |
| `dnsrecon` | Comprehensive DNS enumeration |
| `wafw00f` | WAF detection |
| `sublist3r` | Subdomain enumeration |
| `theHarvester` | Email/username/subdomain harvesting |
| Netcraft | Passive web technology fingerprinting |
| DNSdumpster | Visual DNS mapping |
| Google Dorks | Search engine intelligence gathering |
| HIBP | Leaked credential checking |
