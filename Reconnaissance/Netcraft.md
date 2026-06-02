---
title: Website Footprinting with Netcraft
tags: [eJPT, Reconnaissance, Netcraft, Passive]
created: 2026-03-30
source: Notion
---

# Website Footprinting with Netcraft

**Related:** [[Website-Recon]] | [[WHOIS-Enumeration]] | [[DNS-Reconnaissance]] | [[WAF-Detection-wafw00f]] | [[00-INDEX]]

---

## What is Netcraft?

Netcraft is a **free online service** (`netcraft.com`) that aggregates and displays information about a target domain in one place. It collates data that would otherwise require multiple manual checks.

**Access:** Services → Internet Data Mining → enter target domain

---

## Information Provided by Netcraft

### Background
- Site title and description
- Site rank
- Date the site was first seen
- Primary language

### Network / Infrastructure
- IP address of the web server
- Name servers (reveals CDN/proxy, e.g., Cloudflare) → [[WAF-Detection-wafw00f]]
- Domain registrar → [[WHOIS-Enumeration]]
- Reverse DNS lookup result
- IP delegation details (organization owning the IP block)
- IPv4 and IPv6 info

### SSL/TLS Certificate
- Certificate issuer (e.g., Cloudflare, Let's Encrypt, Starfield)
- Validity period (issued/expiry dates)
- Certificate transparency logs
- **Vulnerability checks** — POODLE (SSLv3), Heartbleed

### Hosting History
- Previous hosting providers
- Timeline of IP/hosting changes
- Useful for finding infrastructure that was previously exposed

### Web Trackers
- Analytics tools in use (e.g., Google Analytics, WordPress Analytics)

### Site Technology
- **Server-side:** PHP version, web server software, proxy/WAF
- **Client-side:** JavaScript frameworks (jQuery, etc.)
- **CMS detection:** WordPress, Drupal, etc.
- **Advertising networks:** AdSense, etc.
- **Scripting frameworks:** jQuery, Google Hosted Libraries

---

## Why Use Netcraft vs. Manual Checks?

| Method | Netcraft |
|---|---|
| Requires multiple separate tools | Single consolidated view |
| Manual correlation | Auto-organizes by category |
| Command line / browser extension | Browser-based, no install needed |

Netcraft is especially useful when **time is limited** — it replicates WHOIS + DNS + tech fingerprinting in one lookup.

---

## Example Findings

From a WordPress site behind Cloudflare:
- Name server org → Cloudflare (proxy confirmed)
- PHP/7.4.29 running on server
- WordPress CMS detected
- MySQL/MariaDB implied (WordPress requires a DB)
- SSL cert issued by Cloudflare, valid period shown
- Google Analytics tracker active

---

## Key Takeaways

- Netcraft is a **one-stop passive recon tool** for website infrastructure
- Always check the **SSL/TLS section** — expired certs or weak configs are pentesting targets
- **Hosting history** can reveal previously exposed IPs before a CDN was added
- **Site technology** section confirms CMS, languages, and frameworks for later exploitation
- Netcraft is passive — no interaction with the target server
