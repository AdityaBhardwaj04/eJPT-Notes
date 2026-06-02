---
title: WAF Detection with wafw00f
tags: [eJPT, Reconnaissance, WAF, Tools]
created: 2026-03-30
source: Notion
---

# WAF Detection with wafw00f

**Related:** [[Website-Recon]] | [[DNS-Reconnaissance]] | [[Firewall-Detection-IDS-Evasion]] | [[00-INDEX]]

---

## What is a WAF?

A **Web Application Firewall (WAF)** sits in front of a web server and filters/monitors HTTP traffic. It can:
- Block malicious requests
- Mask the real server IP (when combined with a CDN like Cloudflare)
- Make active reconnaissance more difficult (filtered responses)

Identifying a WAF early helps you **plan your approach** for later pentest phases → [[Firewall-Detection-IDS-Evasion]]

---

## Tool — wafw00f

Pre-installed on Kali Linux.

**How it works:** Sends a normal HTTP request, then analyzes the response headers and behavior to fingerprint the WAF.

### List all detectable WAFs
```bash
wafw00f -l
```

Supports detection of: Cloudflare, Akamai, Barracuda, BitNinja, ModSecurity, F5 BIG-IP, and many more.

---

## Basic Usage

```bash
wafw00f <target>
```

**Examples:**
```bash
wafw00f hackasploit.org
wafw00f https://hackasploit.org
wafw00f zonetransfer.me
```

Protocol prefix (`https://`) is optional — output is the same either way.

### Test against all known WAF signatures
```bash
wafw00f -a <target>
```

- `-a` runs all checks, not just the first match
- More thorough — can reveal secondary/layered WAFs
- Takes slightly longer

---

## Interpreting Results

| Output | Meaning |
|---|---|
| `site is behind Cloudflare` | CDN + WAF in use; real server IP is hidden |
| `site is not behind a WAF` | Direct connection possible; IP from DNS recon likely real |
| `site seems to be behind a WAF` (with `-a`) | Indirect evidence — confirm during active recon |

**Example outputs:**
```
[+] hackasploit.org is behind Cloudflare (Cloudflare Inc.)
[+] zonetransfer.me - No WAF detected
[+] hackatube.net is behind LiteSpeed (LiteSpeed Technologies)
```

---

## Why This Matters

- If a site is behind Cloudflare: the IP from `host`/`nslookup` is **not the real server IP**
- If no WAF is detected: the IP from DNS recon is likely the **actual web server IP**
- WAF detection informs **active recon strategy** — different WAFs require different bypass techniques → [[Firewall-Detection-IDS-Evasion]]

---

## Key Takeaways

- `wafw00f` is pre-installed on Kali — no setup required
- Run it early in recon to confirm whether a CDN/WAF masks the real server
- Use `-a` flag for a thorough check across all known WAF signatures
- WAF identification is important context for **later exploitation phases**
- `zonetransfer.me` has no WAF — IP from DNS recon is the real server
