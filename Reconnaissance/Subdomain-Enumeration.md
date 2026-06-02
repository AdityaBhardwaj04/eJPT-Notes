---
title: Subdomain Enumeration with Sublist3r
tags: [eJPT, Reconnaissance, Subdomains, Passive, Tools]
created: 2026-03-30
source: Notion
---

# Subdomain Enumeration with Sublist3r

**Related:** [[DNS-Reconnaissance]] | [[Google-Dorks]] | [[Website-Recon]] | [[Active-vs-Passive-Recon]] | [[00-INDEX]]

---

## What is Subdomain Enumeration?

Identifying subdomains associated with a target domain. Subdomains can expose:
- Admin panels
- Staging/dev environments
- Internal services accidentally exposed to the internet
- APIs and portals not linked from the main site

**Passive enumeration** = using search engines and public databases (no direct contact with the target).

---

## Tool — Sublist3r

A Python tool that uses OSINT (search engines + public DBs) to enumerate subdomains passively.

**Author:** Ahmed Abul-Ela  
**Sources used:** Google, Yahoo, Bing, Baidu, Ask, Netcraft, VirusTotal, ThreatCrowd, DNSDumpster, ReverseDNS

> Note: Sublist3r also supports brute-force (`-b` flag) — that is **active recon**, not covered here.

### Install (Kali)
```bash
sudo apt install sublist3r
```

---

## Basic Usage

```bash
sublist3r -d <domain>
```

**Example:**
```bash
sublist3r -d hackasploit.org
sublist3r -d ine.com
```

### Specify search engines
```bash
sublist3r -d <domain> -e google,yahoo
```

### Save results to file
```bash
sublist3r -d <domain> -o results.txt
```

---

## Common Issues & Fixes

| Problem | Cause | Fix |
|---|---|---|
| Google blocks requests | Rate limiting / CAPTCHA triggered | Switch to Yahoo or use VPN |
| No results returned | Search engine blocking | Remove `-e` flag to use all engines |
| VirusTotal errors | API rate limiting | Ignore — other sources still run |

**Rate limiting note:** Sublist3r sends many requests to Google. Google may CAPTCHA you. Use a VPN or switch engines.

```bash
# Use all engines (no -e flag)
sublist3r -d ine.com

# Limit threads to reduce requests
sublist3r -d ine.com -t 10
```

---

## What Sublist3r Is Doing

It automates what you'd do manually with [[Google-Dorks]]:
```
site:*.ine.com
```
...across multiple search engines simultaneously.

**It finds subdomains that have been indexed** by search engines — not a brute-force scan.

---

## Example Results (ine.com)

Running `sublist3r -d ine.com` returns subdomains like:
- `courses.ine.com`
- `community.ine.com`
- `my.ine.com`
- `shop.ine.com`
- (and others not visible on the main website)

---

## Key Takeaways

- Sublist3r is passive — it uses search engines, not direct DNS probing
- Use `-o` to save results for documentation
- If Google blocks you, use Yahoo (`-e yahoo`) or a VPN
- Running without `-e` uses all available sources for best coverage
- Brute-force (`-b`) is available but is **active recon** — use only when authorized
