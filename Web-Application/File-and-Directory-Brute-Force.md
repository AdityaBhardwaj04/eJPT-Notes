---
title: File and Directory Brute Force
tags: [eJPT, WebApp, GoBuster, DirectoryBrute, Enumeration, WordList, ContentDiscovery]
created: 2026-06-21
source: Transcripts
---

# File and Directory Brute Force

**Related:** [[Web-Server-Scanning-with-Nikto]] | [[Crawling-and-Spidering]] | [[HTTP-Basics-Lab]] | [[00-INDEX]]

---

## What is File and Directory Brute Forcing?

Also called **content discovery** or **directory enumeration**. A technique used to discover hidden, unlinked, or unadvertised files, directories, and endpoints on a web server.

Web applications only show you what the developer chose to link. Behind the scenes there may be:
- **Admin panels** (`/admin`, `/dashboard`, `/administrator`)
- **Backup files** (`.bak`, `.old`, `.zip`, `.tar.gz`)
- **Development endpoints** (`/dev`, `/test`, `/staging`, `/beta`)
- **API routes** not referenced in the front end
- **Configuration or debug files** (`config.php`, `.env`, `debug.log`)
- **Upload directories** (`/uploads`, `/files`)

---

## How It Works

1. Tool sends **HTTP GET requests** for every entry in a wordlist (e.g., `admin`, `login`, `backup`)
2. Analyzes the **HTTP response status codes**:
   - `200 OK` → resource exists and is accessible
   - `301/302` → resource exists, but redirects to another location
   - `403 Forbidden` → resource exists, but access is denied
   - `404 Not Found` → resource does not exist (or is hidden)
3. Reports resources that return positive responses

---

## Why Perform It

- **Expand attack surface** — discover functionality that wasn't intended to be public
- **Find sensitive entry points** — admin portals, internal tools, upload directories, APIs
- **Identify misconfigurations** — exposed backups, source files, forgotten dev scripts
- **Enable further attacks** — a discovered `/uploads` directory might allow file upload exploitation; a found `/admin` might be brute-forced for credentials

> In real-world pen tests, directory enumeration frequently acts as a **pivot point** — one discovered endpoint often unlocks multiple exploitation paths.

---

## GoBuster — The Tool

GoBuster is the **de facto standard** for file and directory brute forcing — faster than DirBuster due to its Go-based multi-threaded architecture.

**Modes:**
- `dir` — directory and file enumeration (most common for web app testing)
- `dns` — DNS subdomain enumeration
- `vhost` — virtual host enumeration

---

## Step 1 — Basic Directory Brute Force

```bash
# Basic scan with the DirBuster common wordlist
gobuster dir -u http://demo.ine.local -w /usr/share/wordlists/dirbuster/directory-list-common.txt
```

**Flags:**
- `dir` → use directory/file enumeration mode
- `-u` → target URL
- `-w` → wordlist path

---

## Step 2 — Filtering Results

```bash
# Blacklist (exclude) 403 and 404 responses — only show useful results
gobuster dir -u http://demo.ine.local -w /usr/share/wordlists/dirbuster/directory-list-common.txt -b 403,404
```

This removes noise (forbidden directories, not-found responses) and shows only reachable resources (200, 301, etc.).

---

## Step 3 — Targeting Specific File Extensions

```bash
# Look for files with PHP, XML, and TXT extensions
gobuster dir -u http://demo.ine.local -w /usr/share/wordlists/dirbuster/directory-list-common.txt -b 403,404 -x php,xml,txt

# Follow redirects (suppress 301 redirect clutter in output)
gobuster dir -u http://demo.ine.local -w /usr/share/wordlists/dirbuster/directory-list-common.txt -b 403,404 -x php,xml,txt -r
```

**Flags:**
- `-x` → search for files with specific extensions
- `-r` → follow HTTP redirects (treats 301/302 as the final destination)

---

## Step 4 — Enumerate a Specific Directory

Once you find an interesting directory (e.g., `/data`), target it directly:

```bash
# Enumerate files within the /data directory
gobuster dir -u http://demo.ine.local/data -w /usr/share/wordlists/dirbuster/directory-list-common.txt -b 403,404 -x php,xml,txt
```

This can reveal files like `accounts.xml` — which in a real engagement might contain plaintext credentials.

---

## Step 5 — Threading Control

```bash
# Control number of threads (default: 10)
gobuster dir -u http://demo.ine.local -w /usr/share/wordlists/dirbuster/directory-list-common.txt -t 5
```

- Higher threads = faster but **noisier** (more detectable by WAF/IDS)
- Lower threads = slower but stealthier

---

## Wordlist Selection

The success of brute forcing **depends heavily on the wordlist used**.

| Wordlist | Use Case |
|---|---|
| `/usr/share/wordlists/dirbuster/directory-list-common.txt` | General-purpose common directories and files |
| `/usr/share/seclists/Discovery/Web-Content/Apache.txt` | Apache-specific directories |
| `/usr/share/seclists/Discovery/Web-Content/WordPress.fuzz.txt` | WordPress-specific endpoints |
| `/usr/share/seclists/Discovery/Web-Content/common.txt` | General common web content |

> **SecLists** is the go-to wordlist collection for targeted web app testing. Available on GitHub — search "SecLists Daniel Miessler." Use technology-specific wordlists when you know the target's stack.

---

## Key Takeaways

- File/directory brute forcing discovers **hidden or unadvertised resources** that are not linked in the web app's UI
- Works by sending GET requests for every entry in a wordlist and analyzing response codes
- **200** = accessible; **301/302** = redirect (resource exists); **403** = exists but forbidden; **404** = not found
- GoBuster `dir` mode is the standard tool — fast, multi-threaded, flexible
- Key flags: `-u` (URL), `-w` (wordlist), `-b` (blacklist status codes), `-x` (file extensions), `-r` (follow redirects), `-t` (threads)
- **Wordlist choice matters** — use technology-specific lists from SecLists for more targeted results
- Always check discovered `/uploads` or `/data` directories — they may contain sensitive files or allow file uploads
