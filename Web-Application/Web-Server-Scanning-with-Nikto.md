---
title: Web Server Scanning with Nikto
tags: [eJPT, WebApp, Nikto, WebServer, Enumeration, LFI, DirectoryListing, InfoDisclosure]
created: 2026-06-21
source: Transcripts
---

# Web Server Scanning with Nikto

**Related:** [[File-and-Directory-Brute-Force]] | [[Crawling-and-Spidering]] | [[Web-App-Security-Testing]] | [[00-INDEX]]

---

## What is Nikto?

Nikto is a popular **open-source web server vulnerability scanner** used by pen testers during web application assessments. It scans the web server for:
- Enumeration of server information (web server type, version, backend language)
- Exposure of sensitive headers and banners
- Vulnerability detection specific to the web server (not the web application)
- Hidden directories and resources (robots.txt, config files, admin panels)

---

## Web Server Vulnerabilities vs Web Application Vulnerabilities

This distinction matters for tool selection:

| Category | Example | Nikto? |
|---|---|---|
| **Web Server Vulnerability** | Directory listing enabled, LFI (Local File Inclusion), exposed server banners, misconfigured headers | ✅ Nikto detects these |
| **Web Application Vulnerability** | XSS, SQLi in the app's code, authentication bypass | ❌ Not Nikto's focus — use Burp Suite, SQLMap, etc. |

> **Local File Inclusion (LFI)** is a web *server* vulnerability, not a web application one — it exists because of how the server handles file references, not the web app's code.

---

## Step 1 — Basic Nikto Scan

```bash
# Basic scan against a domain or IP
nikto -h demo.ine.local

# Same with explicit HTTP
nikto -h http://demo.ine.local
```

### What Nikto Enumerates

From a basic scan output, you get:
- **Web server type and version** (e.g., `Apache/2.4.7`)
- **X-Powered-By header** → reveals backend scripting language (e.g., `PHP/5.5.9`)
- **Cookie information** (e.g., `PHPSESSID` confirms PHP backend)
- **Operating system hints** from package names (e.g., `ubuntu4.29` in PHP version string → Ubuntu)
- **robots.txt** → lists paths the developer wants excluded from search engines (worth checking manually)
- **Directories with indexing enabled** → you can browse file system contents (misconfiguration)
- **Admin panels discovered** (e.g., `/phpmyadmin` found → confirms MySQL + LAMP stack)

---

## Step 2 — Targeted Vulnerability Scan (e.g., LFI)

```bash
# Scan a specific URL for LFI vulnerabilities (tuning level 5 = file disclosure)
nikto -h http://demo.ine.local/index.php?page=arbitrary-file-inclusion.php -Tuning 5

# Same scan but output to an HTML report
nikto -h http://demo.ine.local/index.php?page=arbitrary-file-inclusion.php -Tuning 5 -o nikto.html -Format html
```

**Tuning flag `-Tuning 5`** → specifically tests for file disclosure (LFI) vulnerabilities.

### Example LFI Finding

Nikto may discover something like:
> "PHP NewRocket AddIn is vulnerable to file traversal, allowing an attacker to view any file on the host"

And provide a test link such as: `http://demo.ine.local/index.php?page=../../../../etc/passwd`

If `http://demo.ine.local/index.php?page=../../../../etc/passwd` returns the contents of `/etc/passwd`, the LFI vulnerability is confirmed.

---

## Step 3 — Generating an HTML Report

```bash
# Output results to an HTML file (saved in current directory)
nikto -h demo.ine.local -o nikto.html -Format html

# Open the report
firefox nikto.html
```

The HTML report provides a structured view of:
- Target info (IP, hostname, web server version)
- All enumerated headers
- Discovered vulnerabilities with test links

---

## Key Information Disclosed by Nikto Findings

| Finding | What it Reveals |
|---|---|
| `Server: Apache/2.4.7` | Web server technology + version |
| `X-Powered-By: PHP/5.5.9-1ubuntu4.29` | Backend language (PHP), version, and OS hint (Ubuntu) |
| `Cookie: PHPSESSID` | Confirms PHP backend (Java would show `JSESSIONID`) |
| Directory listing on `/config/` | Misconfigured web server — anyone can browse the directory |
| `/phpmyadmin` found | MySQL/MariaDB database management interface exposed — confirms LAMP stack |
| `robots.txt` found | Reveals paths the developer wanted hidden from search engines |

---

## Practical Example: Identifying the Full Stack

From Nikto output on a typical LAMP server:
- `Server: Apache/2.4.7` → Apache web server
- `X-Powered-By: PHP/5.5.9-1ubuntu4.29` → PHP + Ubuntu (Linux)
- `PHPSESSID` cookie → PHP session management
- `/phpmyadmin` directory found → MySQL database interface

**Conclusion:** Target is running the **LAMP stack** (Linux + Apache + MySQL + PHP)

With this info, you can focus on:
- PHP-specific vulnerabilities and file extensions (`.php`)
- Apache-specific misconfigurations
- MySQL-specific SQLi syntax
- Known vulnerabilities for the specific Apache/PHP version numbers found

---

## Key Takeaways

- Nikto scans **web servers**, not web applications — it finds server-level vulnerabilities and misconfigurations
- **LFI** (Local File Inclusion) is a web server vulnerability that Nikto can detect with `-Tuning 5`
- **Directory indexing** (listing) is a misconfiguration — anyone can browse the directory contents
- **Information disclosure** via `Server` and `X-Powered-By` headers reveals the tech stack — valuable for targeting attacks
- Always use `-o` and `-Format html` for cleaner, shareable output during real assessments
- Nikto should be run **alongside** nmap port scanning for full enumeration — never rely on a single tool
