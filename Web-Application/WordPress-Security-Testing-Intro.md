---
title: WordPress Security Testing Intro
tags: [eJPT, WebApp, WordPress, CMS, WPScan, Plugins, BruteForce, AttackVectors]
created: 2026-06-21
source: Transcripts
---

# WordPress Security Testing Intro

**Related:** [[CMS-Security-Testing]] | [[Exploiting-WordPress]] | [[File-and-Directory-Brute-Force]] | [[00-INDEX]]

---

## What is WordPress?

WordPress is the most popular Content Management System (CMS) on the internet:
- **Open source** — source code is publicly available for review, modification, and community contribution
- **Modular** — extended through third-party plugins and themes; users can install hundreds of add-ons
- **PHP-based** — runs on PHP with a MySQL/MariaDB database backend (typically LAMP stack)
- **User-friendly** — provides non-technical users with an intuitive content management interface

---

## Why WordPress is a High-Value Target

**Market share = highest attack volume.** Same principle as Windows in OS security:

- WordPress powers **~40%+ of all websites** on the internet
- Legacy versions are common — many sites never update their core, plugins, or themes
- Its prevalence means:
  - More attacker tooling exists specifically for WordPress (WPScan, Metasploit modules, public exploits)
  - CVEs for WordPress plugins are frequently disclosed — large public vulnerability database
  - Bug bounty programs often include WordPress sites due to the volume of vulnerabilities

---

## WordPress Architecture (Security-Relevant)

```
Browser → Apache/Nginx Web Server → WordPress Core (PHP) → MySQL Database
                                    ↕
                              Plugins / Themes
```

- **WordPress core** = the CMS itself; updated frequently by the WordPress team
- **Plugins** = third-party PHP code that extends functionality (e.g., contact forms, sliders, SEO tools)
- **Themes** = templates controlling the appearance; also PHP code, also potentially vulnerable
- **wp-admin** = the administration panel (`/wp-admin/` or `/wp-login.php`)
- **wp-content/uploads** = file upload directory — target for web shell uploads

---

## Common WordPress Attack Vectors

| Attack Vector | Description |
|---|---|
| **Vulnerable plugins** | Most common source of WordPress vulnerabilities — often unmaintained or infrequently patched by developers |
| **Vulnerable themes** | Same issue as plugins — third-party PHP code with potential SQLi, XSS, or file upload vulns |
| **Brute force** | WordPress login page (`/wp-login.php`) is publicly accessible by default — attackers enumerate usernames then brute force passwords |
| **SQL injection** | WordPress and plugins use MySQL — inadequate input validation in plugin code leads to SQLi |
| **Cross-Site Scripting (XSS)** | Stored or reflected XSS in comment forms, plugin input fields, custom fields |
| **CSRF** | Attacker tricks an authenticated admin into performing unauthorized actions |
| **Misconfigurations** | Default admin username (`admin`), directory listing on `/wp-content/uploads/`, XML-RPC enabled |

> **Plugin equation:** Every activated plugin adds PHP code to the application. One vulnerable plugin with a public exploit = compromised WordPress site, regardless of how secure the core is.

---

## WordPress Pen Testing Methodology

### Phase 1 — Information Gathering & Enumeration

```
1. Port scan and service enumeration (nmap -sV)
2. Identify WordPress version (WPScan, page source, /wp-login.php, generator meta tag)
3. Enumerate installed plugins and their versions
4. Enumerate installed themes and their versions
5. File and directory enumeration (GoBuster targeting WordPress-specific paths)
6. Enumerate valid usernames
```

### Phase 2 — Vulnerability Scanning

```
1. Run WPScan to identify known vulnerabilities in:
   - WordPress core (by version)
   - All identified plugins (by name and version)
   - All identified themes (by name and version)
2. Check robots.txt, /wp-content/uploads/ for directory listing
3. Check if XML-RPC is enabled (/xmlrpc.php) — enables faster brute forcing
```

### Phase 3 — Authentication Testing

```
1. Username enumeration via WPScan (-e u) or manually (?author=1 parameter)
2. Brute force the login (WPScan -U <user> -P <wordlist>)
3. Check for 2FA — if enabled, brute force will not work without bypass
4. Test session management for fixation or weak token vulnerabilities
```

### Phase 4 — Exploitation

```
Based on what was found:
- Log in with valid credentials found via brute force
- Exploit CVE in vulnerable plugin/theme version
- Upload web shell via theme editor (Appearance → Theme Editor → functions.php) if admin access obtained
- Exploit file upload vulnerability in plugin
```

### Phase 5 — Post-Exploitation

```
- Create a rogue admin user (for persistent access)
- Upload a PHP web shell to /wp-content/uploads/
- Dump the WordPress database (wp_users table = hashed passwords)
- Exfiltrate configuration files (wp-config.php contains database credentials in plaintext)
```

---

## Important WordPress-Specific Paths

| Path | Purpose |
|---|---|
| `/wp-login.php` | WordPress login page — target for brute force |
| `/wp-admin/` | Admin dashboard — restricted to authenticated admins |
| `/wp-content/plugins/` | Installed plugins directory |
| `/wp-content/themes/` | Installed themes directory |
| `/wp-content/uploads/` | File upload directory — check for directory listing; target for web shell upload |
| `/wp-config.php` | Contains database credentials (never directly accessible, but often found in backups) |
| `/xmlrpc.php` | XML-RPC API — if enabled, allows faster brute force attacks |
| `/robots.txt` | May reveal paths the developer wants hidden |
| `/?author=1` | Enumerate usernames via author ID bruteforcing |

---

## Key Takeaways

- WordPress is the most targeted CMS due to its **~40%+ market share** — more targets = more attacks = more tooling
- The #1 attack surface: **third-party plugins and themes** — a single unmaintained plugin with a known CVE can compromise the entire site
- WordPress pen test starts with **WPScan** for automated enumeration of version, plugins, themes, and users
- **Brute force** is highly viable — login page is public, default username is `admin`, XML-RPC amplifies speed
- **wp-config.php** contains database credentials in plaintext — a key target in any WordPress compromise
- See [[Exploiting-WordPress]] for the practical step-by-step exploitation walkthrough
