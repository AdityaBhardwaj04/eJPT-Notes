---
title: Website Reconnaissance & Footprinting
tags: [eJPT, Reconnaissance, WebRecon, Passive]
created: 2026-03-30
source: Notion
---

# Website Reconnaissance & Footprinting

**Related:** [[Active-vs-Passive-Recon]] | [[WHOIS-Enumeration]] | [[Netcraft]] | [[WAF-Detection-wafw00f]] | [[DNS-Reconnaissance]] | [[00-INDEX]]

---

## What is Website Footprinting?

Footprinting = passive recon focused on extracting important information about a specific target website.

**Information to collect:**
- IP address of the web server
- Hidden directories (not indexed by search engines)
- Names, email addresses, phone numbers, physical addresses
- Web technologies (CMS, frameworks, server-side languages)

---

## Step 1 — Resolve the IP Address

```bash
host <target-domain>
```

**Example:**
```bash
host hackasploit.org
```

- Returns IPv4/IPv6 addresses and mail server (MX record)
- If you see **multiple IPs**, the site is likely behind a **proxy/WAF** (e.g., Cloudflare) → see [[WAF-Detection-wafw00f]]
- The `host` command is a DNS lookup utility

---

## Step 2 — Check robots.txt

```
https://<target>/robots.txt
```

- Tells search engine crawlers which directories **not** to index
- Pentesters read it to discover **hidden/sensitive directories**
- Example finding: `Disallow: /wp-admin` → site is running **WordPress**

---

## Step 3 — Check sitemap.xml

```
https://<target>/sitemap.xml
```

- Structured XML file that helps search engines index the site
- Reveals: posts, pages, categories, authors
- Can expose **pages not linked on the front end**

---

## Step 4 — Browser Technology Profilers

### BuiltWith (Firefox/Chrome extension)
- Identifies CMS, plugins, JavaScript frameworks, CDNs, analytics tools
- Shows subdomains associated with the domain
- Best free option for quick tech fingerprinting

### Wappalyzer (Firefox/Chrome extension)
- Similar to BuiltWith — identifies web technologies
- May require sign-in for full results

---

## Step 5 — whatweb (CLI tool)

```bash
whatweb <target-domain>
```

- Pre-installed on Kali Linux
- Returns: web frameworks, PHP version, WordPress detection, HTTP headers
- Useful alternative to browser extensions

**Example output shows:**
- HTTP redirects (proxy info)
- jQuery version, PHP version (`PHP/7.4.29`)
- CMS detection (WordPress)

---

## Step 6 — Download Website for Offline Analysis

```bash
sudo apt install webhttrack
```

- **HTTrack** / **WebHTTrack**: website copier that downloads full site locally
- Useful for source code analysis
- May fail if site is behind Cloudflare or other proxies

---

## Key Takeaways

- `robots.txt` and `sitemap.xml` are goldmines — always check them first
- Browser extensions (BuiltWith, Wappalyzer) quickly reveal the tech stack
- `whatweb` is a free CLI alternative to browser profilers
- If multiple IPs are returned for a domain → likely behind a CDN/WAF → [[WAF-Detection-wafw00f]]
- Website footprinting stays **passive** — no active scanning of the target
