---
title: Google Dorks (Google Hacking)
tags: [eJPT, Reconnaissance, GoogleDorks, OSINT, Passive]
created: 2026-03-30
source: Notion
---

# Google Dorks (Google Hacking)

**Related:** [[Subdomain-Enumeration]] | [[Website-Recon]] | [[Active-vs-Passive-Recon]] | [[00-INDEX]]

---

## What are Google Dorks?

**Google Dorks** (also called Google Hacking) are advanced search operators used to find specific information about a target that is indexed by Google. Used by pentesters for passive OSINT.

---

## Core Search Operators

| Operator | Usage | Example |
|---|---|---|
| `site:` | Limit results to a domain | `site:ine.com` |
| `inurl:` | Match text in the URL | `site:ine.com inurl:admin` |
| `intitle:` | Match text in page title | `intitle:"index of"` |
| `filetype:` | Filter by file extension | `site:ine.com filetype:pdf` |
| `cache:` | Show Google's cached version | `cache:ine.com` |
| `*` (wildcard) | Match any subdomain | `site:*.ine.com` |

---

## Subdomain Enumeration via Google

```
site:*.ine.com
```

- Shows subdomains indexed by Google
- Equivalent to what [[Subdomain-Enumeration]] does automatically
- Combine with `intitle:` or `inurl:` to narrow results

```
site:*.ine.com intitle:admin
site:*.ine.com inurl:forum
```

---

## File Discovery

```
site:ine.com filetype:pdf
site:ine.com filetype:xlsx
site:ine.com filetype:docx
```

- Find publicly exposed documents (reports, diagrams, spreadsheets)
- Also works with: `zip`, `txt`, `csv`, `xml`

---

## Sensitive File Exposure Examples

```
inurl:passwd.txt
intitle:password.txt
```

- Locates sites that have accidentally exposed password files publicly

```
intitle:"index of"
```

- Finds servers with **directory listing enabled**
- Exposes file/folder structure to anyone searching Google

---

## Cached & Historical Versions

```bash
cache:ine.com    # Google's cached version
```

- **Wayback Machine** (`web.archive.org`): stores historical snapshots
- Useful for finding info that was on a site years ago but has since been removed
- Real-world use: finding email addresses, old credentials, or removed pages

---

## Google Hacking Database (GHDB)

**URL:** `exploit-db.com/google-hacking-database`  
**Maintained by:** Offensive Security (creators of Kali Linux)

- Database of pre-built Google Dorks organized by category
- Categories include: files with juicy info, login portals, exposed configs, vulnerable servers
- Filter by CMS (e.g., WordPress-specific dorks)

**Useful WordPress dork:**
```
site:<target> filetype:txt wp-config
```
Finds exposed WordPress config backups — which contain MySQL credentials.

---

## Key Takeaways

- Google Dorks are **fully passive** — you're querying Google, not the target
- `site:*.target.com` enumerates subdomains indexed by Google
- `intitle:"index of"` finds directory listing vulnerabilities
- Use the **GHDB** for pre-built dorks targeting specific CMS or file types
- Wayback Machine reveals historical site content that may contain sensitive data
- Google rate-limits excessive queries — vary your searches or use a VPN
