---
title: Web Application Technologies
tags: [eJPT, WebApp, HTML, CSS, JavaScript, PHP, Apache, MySQL, SSL, TLS, API, CDN]
created: 2026-06-21
source: Transcripts
---

# Web Application Technologies

**Related:** [[Web-Application-Architecture]] | [[Introduction-to-HTTP]] | [[Introduction-to-Web-Application-Security]] | [[00-INDEX]]

---

## Overview

Knowing the specific technologies that make up a web application is essential for pen testing. The technology stack determines:
- What **file extensions** to look for during enumeration (`.php`, `.py`, `.jsp`)
- What **vulnerabilities** apply (PHP-specific SQLi vs Python-specific issues)
- What **attack surface** exists on both client and server sides

---

## Client-Side Technologies

These run **in the browser** on the user's device.

### HTML — HyperText Markup Language
The foundation of all web pages. Defines the **structure and layout** of content. Every web application starts with an HTML file (typically `index.html`). Everything else builds on it.

### CSS — Cascading Style Sheets
Controls the **visual presentation** — colors, fonts, layout, spacing. Define a style once and apply it consistently across the entire site.

### JavaScript
A **scripting language** that makes web pages interactive. Handles user events (button clicks, form submission), dynamic content changes, and client-side validation.

- **Runs in the browser** — users and attackers can view, modify, and inject it
- Primary language for XSS attacks — injected malicious JS runs in other users' browsers
- Also used in the browser's JavaScript engine to interact with the server

### Cookies and Local Storage
Client-side mechanisms for storing data in the browser:
- **Cookies** — small data pieces set by the web server (via `Set-Cookie` response header) and sent back with every request. Used for session tracking and authentication
- **Local Storage** — browser-side key-value store. No automatic transmission with requests unlike cookies

> Cookies are the primary mechanism for session management. After login, the server issues a cookie; the browser sends it with every subsequent request so the server knows who you are.

---

## Server-Side Technologies

These run **on the web server**.

### Web Server
Receives HTTP requests from browsers, serves static files, and routes dynamic requests to the application server.

| Technology | Notes |
|---|---|
| **Apache** | Most common, open source, runs on Linux |
| **Nginx** | High-performance, widely used as reverse proxy |
| **Microsoft IIS** | Windows-based web server |

### Application Server
Executes the web application's **business logic**. Processes user requests, queries databases, generates dynamic content. Think of it as the CMS core (e.g., WordPress core is the application server layer).

### Database Server
Stores and manages the web application's **persistent data** — user credentials, content, configurations.

| Technology | Type |
|---|---|
| **MySQL / MariaDB** | Relational (most common with PHP) |
| **PostgreSQL** | Relational (advanced features) |
| **MSSQL** | Microsoft relational database |
| **Oracle** | Enterprise relational database |

> Identifying the database type is important — it affects SQLi syntax and exploitation approach.

### Server-Side Scripting Languages
The programming language the web application was **developed in**. Critical to identify during enumeration.

| Language | File Extension | Common Use |
|---|---|---|
| **PHP** | `.php` | Most common for web apps (WordPress, Joomla) |
| **Python** | `.py` | Modern web apps (Django, Flask) |
| **Java** | `.jsp`, `.java` | Enterprise applications |
| **Ruby** | `.rb` | Ruby on Rails applications |

> The file extension reveals the server-side language. If you see `.php` files, the backend is PHP. This shapes the entire attack approach.

---

## Data Interchange Technologies

How different components of a web application communicate with each other and external services.

| Technology | Purpose |
|---|---|
| **JSON** | Lightweight data format; standard for REST API responses and AJAX requests |
| **XML** | Structured data format; used in SOAP web services and configuration files |
| **REST API** | Uses HTTP methods (GET/POST/PUT/DELETE) for data exchange — most common modern API style |
| **SOAP** | XML-based protocol for structured web service communication |

---

## Security Technologies

| Technology | Purpose |
|---|---|
| **Authentication** | Verifies who a user is — typically managed via cookies/session tokens after login |
| **Authorization** | Controls what an authenticated user can access based on their role/permissions |
| **SSL/TLS** | Encrypts HTTP communication → HTTPS. Prevents credential theft via traffic interception |

> **SSL** = Secure Sockets Layer (older). **TLS** = Transport Layer Security (modern). Both are used to mean the same thing in practice. An SSL/TLS certificate installed on the web server enables HTTPS.

---

## External / Third-Party Technologies

| Technology | Purpose | Security Note |
|---|---|---|
| **CDN (Content Delivery Network)** | Distributes static assets (images, CSS, JS) across geographically distributed servers to improve load speed. Example: Cloudflare | CDN-protected sites may hide the real server IP |
| **Third-Party Libraries & Frameworks** | Speed up development — e.g., Bootstrap, jQuery, React | Vulnerable library versions introduce vulnerabilities into otherwise secure apps — supply chain attack surface |
| **Plugins / Extensions** | Extend CMS functionality (e.g., WordPress plugins) | Most common source of vulnerabilities in CMSs — often unmaintained by developers |

---

## Identifying the Technology Stack (Enumeration)

During a web application pen test, identifying the technology stack is one of the first objectives:

1. **File extensions** in URLs → reveals server-side language (`.php`, `.aspx`, `.jsp`)
2. **Response headers** (especially `Server` and `X-Powered-By`) → reveals web server and language version
3. **Cookie names** (`PHPSESSID` = PHP, `JSESSIONID` = Java)
4. **Error messages** → often reveal stack info if not suppressed
5. **Tools**: Nikto, Wappalyzer, Burp Suite passive scan, WhatWeb

---

## Key Takeaways

- Client-side: **HTML** (structure), **CSS** (style), **JavaScript** (interactivity) — runs in the browser
- Server-side: **PHP/Python/Java/Ruby** — runs on the server; interacts with databases
- **File extensions reveal the server-side language** — critical for targeting attacks correctly
- **Web server** (Apache/Nginx/IIS) hosts the app; **database server** (MySQL/PostgreSQL) stores data
- **Cookies** are set by the server and used to track authenticated sessions — primary target for session hijacking
- **SSL/TLS** encrypts HTTP traffic (→ HTTPS) but does not protect against web app vulnerabilities like XSS or SQLi
- Third-party plugins and libraries expand functionality but significantly increase the attack surface
