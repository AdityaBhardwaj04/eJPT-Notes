---
title: Web Server Enumeration
tags: [eJPT, Enumeration, HTTP, Apache, Metasploit, DirectoryBruteForce, WebServer]
created: 2026-04-06
source: Notion
---

# Web Server Enumeration

**Related:** [[Introduction-to-Enumeration]] | [[Port-Scanning-Auxiliary-Modules]] | [[MySQL-Enumeration]] | [[NSE]] | [[00-INDEX]]

---

## Overview

Web servers run on **port 80 (HTTP)** and **port 443 (HTTPS)**. Apache is one of the most common web servers. Metasploit provides a comprehensive set of HTTP auxiliary modules to enumerate version, headers, hidden directories, files, protected paths, and usernames.

---

## What is Web Server Enumeration?

- **Ports:** 80 TCP (HTTP), 443 TCP (HTTPS)
- Targets the web application layer — the most exposed attack surface
- Goals:
  - Identify the web server software and version
  - Discover hidden directories and files
  - Find protected resources (HTTP auth)
  - Identify valid usernames
  - Locate misconfigurations (robots.txt, directory listing)

---

## Metasploit HTTP Auxiliary Modules

### 1. HTTP Version Detection

```bash
use auxiliary/scanner/http/http_version
set RHOSTS <target-ip>
run
```

- Identifies the web server software and version
- Lab result: **Apache 2.4.18 on Ubuntu**
- Version → search for Apache CVEs: `search Apache 2.4`

### 2. HTTP Header Analysis

```bash
use auxiliary/scanner/http/http_header
set RHOSTS <target-ip>
run
```

- Sends HTTP HEAD/GET requests and displays response headers
- Reveals: server software, content-type, X-Powered-By, security headers (or lack thereof)
- Headers can confirm the web framework (PHP, ASP.NET) and version

### 3. robots.txt Scanner

```bash
use auxiliary/scanner/http/robots_txt
set RHOSTS <target-ip>
run
```

- Fetches and parses `/robots.txt`
- `Disallow` entries reveal directories the server operator wants hidden
- Lab result: **Disallow: /data** and **Disallow: /secure**

> Disallowed paths are not protected — they are just hidden from search engines. They are often the most interesting directories.

### 4. Directory Scanner (Brute Force)

```bash
use auxiliary/scanner/http/dir_scanner
set RHOSTS <target-ip>
run
```

- Brute forces common directory names against the web server
- Lab result: **/secure / /data / /downloads / /web_dev / /webmail / /webdb**
- Comprehensive — finds directories not listed in robots.txt

### 5. Files Directory Scanner

```bash
use auxiliary/scanner/http/files_dir
set RHOSTS <target-ip>
run
```

- Brute forces common file names within discovered directories
- Lab result: **code.c / index.html / test.php**
- Useful after dir_scanner has identified target directories

### 6. HTTP Login Brute Force

```bash
use auxiliary/scanner/http/http_login
set RHOSTS <target-ip>
set AUTH_URI /secure
set USER_FILE /usr/share/metasploit-framework/data/wordlists/name_list.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run
```

- Brute forces HTTP Basic Authentication on a protected path
- `AUTH_URI` — the path requiring authentication (found via robots.txt or dir_scanner)
- Lab: targeted `/secure` discovered from robots.txt

### 7. Apache UserDir Enumeration

```bash
use auxiliary/scanner/http/apache_userdir_enum
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
run
```

- Exploits Apache's `UserDir` module — checks if `~username` paths exist
- Tests URLs like `http://<target>/~root`, `http://<target>/~admin`
- Lab result: found **rooty** user
- Valid usernames → feed into SSH/FTP brute force

---

## HTTPS Targets

For HTTPS (port 443), set `SSL true` and adjust the port:

```bash
set RHOSTS <target-ip>
set SSL true
set RPORT 443
run
```

---

## Interacting with the Web Server

### curl — Your Browser on the Command Line

```bash
# GET request (view page content)
curl http://<target-ip>/

# View headers only
curl -I http://<target-ip>/

# Follow redirects
curl -L http://<target-ip>/

# Send POST data (login form)
curl -X POST http://<target-ip>/login.php -d "username=admin&password=password"

# Send with cookie
curl -b "PHPSESSID=abc123" http://<target-ip>/dashboard.php

# Basic HTTP auth
curl -u admin:password http://<target-ip>/secure/

# Save response to a file
curl http://<target-ip>/config.php -o config.php

# HTTPS (ignore cert errors)
curl -k https://<target-ip>/
```

### gobuster — Fast Directory & File Brute Forcing

```bash
# Directory brute force
gobuster dir -u http://<target-ip> -w /usr/share/wordlists/dirb/common.txt

# Include file extensions
gobuster dir -u http://<target-ip> -w /usr/share/wordlists/dirb/common.txt -x php,txt,html,bak

# Follow redirects, show status codes
gobuster dir -u http://<target-ip> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php -r

# HTTPS target
gobuster dir -u https://<target-ip> -w /usr/share/wordlists/dirb/common.txt -k
```

### nikto — Web Vulnerability Scanner

```bash
# Basic scan
nikto -h http://<target-ip>

# Specific port
nikto -h <target-ip> -p 8080

# Output to file
nikto -h http://<target-ip> -o nikto_report.txt
```

Nikto checks for:
- Outdated server software
- Default files and credentials
- Dangerous HTTP methods (PUT, DELETE)
- Misconfigurations (directory listing, server-status)
- Known CVEs for the detected version

### Accessing Discovered Paths

After enumerating directories, browse them directly:

```bash
curl http://<target-ip>/data/
curl http://<target-ip>/secure/
curl http://<target-ip>/admin/config.php
```

### Downloading Files from the Web Server

```bash
wget http://<target-ip>/backup.zip
wget -r http://<target-ip>/data/       # Recursive download of entire directory
```

---

## Full Lab Workflow

```bash
service postgresql start
msfconsole
workspace add WEB_ENUM

setg RHOSTS <target-ip>

# 1. Version detection
use auxiliary/scanner/http/http_version
run
# Result: Apache 2.4.18, Ubuntu

# 2. Header analysis
use auxiliary/scanner/http/http_header
run
# Result: server header, content-type

# 3. robots.txt
use auxiliary/scanner/http/robots_txt
run
# Result: Disallow: /data, Disallow: /secure

# 4. Directory brute force
use auxiliary/scanner/http/dir_scanner
run
# Result: /secure, /data, /downloads, /web_dev, /webmail, /webdb

# 5. File enumeration
use auxiliary/scanner/http/files_dir
run
# Result: code.c, index.html, test.php

# 6. Brute force protected path
use auxiliary/scanner/http/http_login
set AUTH_URI /secure
set USER_FILE /usr/share/metasploit-framework/data/wordlists/name_list.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run

# 7. Apache user enumeration
use auxiliary/scanner/http/apache_userdir_enum
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
run
# Result: rooty

# 8. Manual verification
exit
curl http://<target-ip>/data/
curl http://<target-ip>/robots.txt
```

---

## Searching for Modules

```bash
search type:auxiliary name:http
search Apache 2.4    # Find exploits for the identified version
```

---

## Key Takeaways

- **robots.txt** often reveals the most sensitive paths — always check it first
- **dir_scanner** finds paths beyond robots.txt — use both
- **apache_userdir_enum** turns Apache's UserDir feature into a username oracle
- Discovered usernames from web enumeration → credential attacks on SSH, FTP, SMB
- `setg RHOSTS` is especially useful in web enumeration — many modules, same target
- This completes the core service enumeration modules — see [[00-INDEX]] for full vault navigation
