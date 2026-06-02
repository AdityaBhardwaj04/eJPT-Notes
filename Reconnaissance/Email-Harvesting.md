---
title: Email Harvesting with theHarvester
tags: [eJPT, Reconnaissance, OSINT, Passive, EmailHarvesting]
created: 2026-03-30
source: Notion
---

# Email Harvesting with theHarvester

**Related:** [[Active-vs-Passive-Recon]] | [[Subdomain-Enumeration]] | [[Leaked-Password-Databases]] | [[DNS-Reconnaissance]] | [[00-INDEX]]

---

## What is Email Harvesting?

The process of collecting email addresses associated with a target domain from publicly available sources. Harvested emails can be used for:
- **Phishing / spear-phishing** attacks
- **Password spray** attacks (combined with breached password databases → [[Leaked-Password-Databases]])
- **OSINT** to map employees and org structure

---

## Tool — theHarvester

Pre-installed on Kali Linux. Collects emails, subdomains, IPs, ASNs, and URLs from multiple public sources.

> **Note:** The tool was renamed — use `theHarvester` (capital H). The old `theharvester` command is deprecated on Kali.

### Install / verify
```bash
# Install (if not present)
sudo apt install theharvester

# Invoke current version
theHarvester --help
```

---

## Basic Usage

```bash
theHarvester -d <domain> -b <source>
```

| Flag | Description |
|---|---|
| `-d` | Target domain or company name |
| `-b` | Data source(s) to query |
| `-l` | Limit results (default: 500) |
| `-f` | Save output to file (HTML + XML) |
| `-v` | Virtual host resolution |
| `-r` | DNS resolve discovered subdomains |
| `-n` | Perform reverse DNS lookup |
| `-c` | DNS brute force |
| `-s` | Use Shodan to query discovered hosts (active) |

---

## Available Sources (no API key required)

```bash
# Search with a single source
theHarvester -d ine.com -b bing

# Search with multiple sources (comma-separated)
theHarvester -d ine.com -b bing,yahoo,duckduckgo,baidu

# Use all available sources
theHarvester -d ine.com -b all
```

**Commonly used free sources:**
- `bing` — Microsoft search engine
- `baidu` — Chinese search engine
- `duckduckgo` — Privacy-focused search engine
- `yahoo` — Yahoo search
- `brave` — Brave search engine
- `urlscan` — URL scanning database
- `crtsh` — Certificate Transparency logs (great for subdomains)
- `rapiddns` — DNS database
- `otx` — AlienVault OTX threat intelligence

**Sources requiring API keys:**
- `hunter` — Hunter.io (email lookup)
- `intelx` — IntelligenceX
- `virustotal` — VirusTotal
- `netlas` — Shodan/Censys competitor
- `whoisxmlapi` — WHOIS XML API

---

## Example Commands

```bash
# Quick email + subdomain hunt
theHarvester -d ine.com -b bing,yahoo,duckduckgo,baidu

# Broader OSINT with certificate transparency + DNS sources
theHarvester -d ine.com -b crtsh,rapiddns,urlscan,otx

# Save results to file
theHarvester -d ine.com -b bing,crtsh -f results

# Search by organization name
theHarvester -d "Company Name" -b bing,yahoo

# Practice target (permitted)
theHarvester -d zonetransfer.me -b bing,crtsh,rapiddns,urlscan
```

---

## Output Fields

| Field | Description |
|---|---|
| **Emails found** | Email addresses tied to the domain |
| **Hosts found** | Subdomains discovered |
| **IPs found** | IP addresses associated with hosts |
| **Interesting URLs** | Notable URLs found during enumeration |
| **ASNs** | Autonomous System Numbers (network ownership) |

---

## Key Takeaways

- `theHarvester` (capital H) is the current Kali invocation
- Use `-b all` for maximum coverage; narrow down with specific sources to reduce noise
- `crtsh` and `rapiddns` are highly effective for subdomain discovery without API keys
- Combine harvested emails with **HaveIBeenPwned** → [[Leaked-Password-Databases]] to check for breached credentials
- Data sources marked as requiring API keys offer free-tier keys (worth getting)
