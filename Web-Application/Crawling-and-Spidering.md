---
title: Crawling and Spidering
tags: [eJPT, WebApp, BurpSuite, OWASPZAP, Crawling, Spidering, SiteMap, Passive, Active]
created: 2026-06-21
source: Transcripts
---

# Crawling and Spidering

**Related:** [[File-and-Directory-Brute-Force]] | [[Web-Server-Scanning-with-Nikto]] | [[HTTP-Basics-Lab]] | [[00-INDEX]]

---

## Crawling vs Spidering

Two related but distinct techniques for mapping the structure of a web application:

| Technique | Type | How it Works | Tool |
|---|---|---|---|
| **Crawling** | **Passive** | You manually browse the website (clicking links, submitting forms, logging in) while a web proxy records everything in a site map | Burp Suite Community |
| **Spidering** | **Active** | Automated tool starts from a seed URL, discovers all hyperlinks on each page, then recursively follows and discovers links from those pages — no manual browsing required | OWASP ZAP |

> **Passive** = limited to what is publicly visible on the front end. **Active** = can discover resources not linked in any page visible to the user, making it more thorough but also louder.

---

## Passive Crawling with Burp Suite

Burp Suite's proxy passively builds a site map as you browse. No spider needed — just normal browsing with the proxy enabled.

### Setup

1. In Firefox: enable **FoxyProxy → Burp Suite profile** (routes browser traffic to `localhost:8080`)
2. Launch Burp Suite → Temporary Project → Start
3. Go to `Proxy` tab → **set Intercept to OFF** (you want to browse freely, not be stopped at each request)

### Browsing to Build the Site Map

Navigate the target web app normally:
- Click every visible link
- Try logging in (even with test credentials)
- Submit forms
- Navigate to all sections of the site

### Viewing the Site Map

In Burp Suite: `Target` → `Site Map`

As you browse, Burp automatically populates the site map with:
- All directories and files discovered via your clicks
- GET requests (page loads) and POST requests (form submissions)
- Hidden pages discovered through navigation (e.g., `setup-database.php`, `hintspagerapper.php`, `documentation/`)

> Burp Suite Community edition provides the **passive crawler** (site map from browsing). The **active spider** (automated link discovery) is only available in Burp Pro.

---

## Active Spidering with OWASP ZAP

OWASP ZAP's spider automates what crawling does manually — and goes further by discovering content not linked anywhere on the front end.

### Key Advantage Over Passive Crawling

A spider can find **resources with no incoming hyperlinks** — files that exist on the server but are never linked from any page. For example:
- `/passwords/accounts.txt` (a plaintext credential file)
- `/config.inc` (database configuration)
- `/phpmyadmin/` (database management interface)

These would never appear during passive crawling because no page links to them.

### Setup

1. In Firefox: ensure **FoxyProxy → Burp Suite profile** is enabled (port 8080 — same port ZAP uses)
2. Navigate to the target site once to register it in ZAP's site list
3. Launch OWASP ZAP → leave it open

### Running the Spider

```
Tools → Spider → select target URL (HTTP version, not HTTPS) → enable Recurse → Start Scan
```

Options:
- **Max Depth** → 0 = unlimited (follows all discovered links to any depth)
- **Max Children** → 0 = unlimited
- Reduce these values to slow down the spider and reduce noise if needed

### Understanding the Output — Color Coding

- **Red entries** = external hyperlinks (e.g., YouTube.com, external sites)
- **Green entries** = internal links and resources on the target server — these are what you want

### Exporting Results

ZAP allows you to export the discovered URLs as a **CSV file** for reference during manual testing.

---

## What to Look For in the Site Map

After crawling or spidering, investigate:

| Discovery | Why It Matters |
|---|---|
| `/uploads/` or `/files/` | May allow file upload — test for dangerous method support (OPTIONS → PUT) |
| `/admin/` or `/dashboard/` | Admin panel — target for brute force or authentication bypass |
| `/config.inc`, `.env`, `config.php` | May contain hardcoded database credentials |
| `/passwords/accounts.txt` | Credential exposure — obvious critical finding |
| `/phpmyadmin/` | Direct database access — test for default/weak credentials |
| `/setup-database.php` | Installation or setup script — sometimes executable even post-install |
| Backup files (`.bak`, `.old`, `.zip`) | May contain source code, credentials, or configuration data |

---

## Stack Identification from ZAP Findings

ZAP's spidering often reveals information about the underlying infrastructure:
- PHP files (`.php`) → PHP backend
- `/phpmyadmin/` directory → MySQL database management (confirms LAMP stack)
- Apache version banner in 404 error pages → web server version

---

## Crawling + Spidering + Brute Forcing

These three techniques complement each other:

```
Passive Crawling (Burp)    → What's publicly linked (quick baseline)
Active Spidering (ZAP)     → What's discoverable via link following (deeper)
Directory Brute Force (GoBuster) → What's hidden with no links at all (widest coverage)
```

In a real assessment, run all three in sequence for maximum coverage.

---

## Key Takeaways

- **Crawling** (passive) = manual browsing + Burp records the site map — limited to publicly visible content
- **Spidering** (active) = automated recursive link discovery — finds content with no visible links
- Burp Suite Community only supports **passive crawling** — active spider requires Burp Pro
- **OWASP ZAP** spider is free and open-source — equivalent to Burp Pro's spider functionality
- **Red links** in ZAP = external; **Green links** = internal resources on the target
- Key discoveries: credential files, config files, admin panels, upload directories, database interfaces
- Always combine crawling + spidering + directory brute force for complete web application coverage
