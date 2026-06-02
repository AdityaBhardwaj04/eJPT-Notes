---
title: FTP Enumeration
tags: [eJPT, Enumeration, FTP, Metasploit, BruteForce]
created: 2026-04-06
source: Notion
---

# FTP Enumeration

**Related:** [[Introduction-to-Enumeration]] | [[Port-Scanning-Auxiliary-Modules]] | [[SMB-Enumeration]] | [[NSE]] | [[00-INDEX]]

---

## Overview

FTP (File Transfer Protocol) runs on **port 21 TCP** and is used to transfer files between a client and server. Metasploit provides several auxiliary modules to enumerate FTP services.

---

## What is FTP?

- **Port:** 21 (TCP)
- Used to transfer files between a server and client(s)
- Commonly used to upload/download files to/from a web server directory
- Authenticates via **username and password**
- Once authenticated, you can upload or download files from the configured directory

---

## Metasploit FTP Auxiliary Modules

### 1. Port Scan (Verify FTP is Running)

```bash
use auxiliary/scanner/portscan/tcp
set RHOSTS <target-ip>
set PORTS 21
run
```

### 2. FTP Version Scanner

```bash
use auxiliary/scanner/ftp/ftp_version
set RHOSTS <target-ip>
run
```

- Detects the exact FTP service version (e.g., **ProFTPD 1.3.5a**)
- Version info → search for CVEs: `search ProFTPD`

### 3. FTP Brute Force (Login Scanner)

```bash
use auxiliary/scanner/ftp/ftp_login
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run
```

- Successful credentials highlighted in green
- Lab result: **sysadmin : 654321**

> **Warning:** Brute forcing can temporarily overload the FTP service. Wait a few seconds before reconnecting.

### 4. FTP Anonymous Login Check

```bash
use auxiliary/scanner/ftp/anonymous
set RHOSTS <target-ip>
run
```

- Checks for anonymous login (no credentials required)
- Lab result: anonymous login **not permitted**

---

## Full Lab Workflow

```bash
service postgresql start
msfconsole
workspace add FTP_ENUM

# 1. Confirm port 21 is open
use auxiliary/scanner/portscan/tcp
set RHOSTS <target-ip>
set PORTS 21
run

# 2. Version scan
use auxiliary/scanner/ftp/ftp_version
set RHOSTS <target-ip>
run
# Result: ProFTPD 1.3.5a

# 3. Brute force
use auxiliary/scanner/ftp/ftp_login
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run
# Result: sysadmin:654321

# 4. Anonymous check
use auxiliary/scanner/ftp/anonymous
set RHOSTS <target-ip>
run

# 5. Log in manually
exit
ftp <target-ip>
# Username: sysadmin / Password: 654321
ls
get secret.txt
bye
```

---

## Interacting with FTP

Once you have credentials (or anonymous access), connect using the `ftp` client:

```bash
ftp <target-ip>
# Name: sysadmin
# Password: 654321
```

### Essential FTP Commands

| Command | Description |
|---------|-------------|
| `ls` | List files/directories |
| `cd <dir>` | Change directory |
| `pwd` | Print current directory |
| `get <file>` | Download a single file |
| `mget <pattern>` | Download multiple files (e.g., `mget *.txt`) |
| `put <file>` | Upload a single file |
| `mput <pattern>` | Upload multiple files |
| `binary` | Switch to binary transfer mode (required for non-text files) |
| `ascii` | Switch to ASCII transfer mode (default, for text files) |
| `mkdir <dir>` | Create a directory |
| `delete <file>` | Delete a file |
| `bye` / `quit` | Exit the session |

### Useful Tips

```bash
# Check if you can upload a file (write access = potential webshell)
ftp <target-ip>
ftp> put shell.php

# Download everything in a directory
ftp> mget *

# Always switch to binary mode before downloading executables or archives
ftp> binary
ftp> get backup.zip
```

> If you have write access to a web-accessible FTP directory, you can upload a **PHP/ASP webshell** and trigger it via the browser — instant RCE.

---

## Searching for Modules

```bash
search type:auxiliary name:ftp
search ProFTPD    # Find exploits for the identified version
```

---

## Key Takeaways

- Always **version-scan first** — version info drives vulnerability identification
- **Brute force** is effective when no credentials are known
- **Anonymous login** check is quick and can expose data without any credentials
- Found credentials may expose sensitive files or entire web server directories
- Next topic: **SMB Enumeration** → [[SMB-Enumeration]]
