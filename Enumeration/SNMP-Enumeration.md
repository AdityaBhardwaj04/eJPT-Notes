---
title: SNMP Enumeration
tags: [eJPT, Enumeration, SNMP, UDP, NetworkDevices, CommunityStrings]
created: 2026-06-02
source: Transcripts
---

# SNMP Enumeration

**Related:** [[Network-Mapping]] | [[Host-Discovery-Techniques]] | [[00-INDEX]]

---

## What is SNMP?

**SNMP (Simple Network Management Protocol)** is widely used for monitoring and managing network devices (routers, printers, servers). Three key components:

| Component | Role |
|---|---|
| **SNMP Manager** | System that queries and interacts with SNMP agents |
| **SNMP Agent** | Software on devices that responds to SNMP queries |
| **MIB (Management Info Base)** | Hierarchical DB defining data available via SNMP — each item has a unique OID |

### SNMP Versions

| Version | Notes |
|---|---|
| SNMPv1 | Earliest — uses community strings (passwords) for auth |
| SNMPv2c | Improved, supports bulk transfers — still uses community strings |
| SNMPv3 | Encryption + message integrity + user-based authentication |

### Ports

| Port | Protocol | Use |
|---|---|---|
| 161 | UDP | SNMP queries |
| 162 | UDP | SNMP traps (notifications) |

---

## Enumeration Goals

1. Identify SNMP-enabled devices (UDP port 161 open)
2. Find community strings (essentially passwords)
3. Enumerate system info: OS, software, services, network interfaces, users

---

## Step 1 — Discover SNMP-Enabled Hosts

```bash
# UDP scan for port 161
nmap -sU -p 161 <target>

# Service version detection
nmap -sU -sV -p 161 <target>
```

---

## Step 2 — Brute Force Community Strings

```bash
# Using Nmap NSE script (uses built-in wordlist at /usr/share/nmap/nselib/data/snmp-communities.lst)
nmap -sU -p 161 --script snmp-brute <target>
# → Finds community strings: public, private, secret
```

---

## Step 3 — Extract Data with SNMPwalk

```bash
# Basic SNMPwalk (verbose, hard to read)
snmpwalk -v1 -c public <target>

# Better: run all Nmap SNMP scripts and save to file
nmap -sU -p 161 --script snmp* <target> -oN snmp_info.txt
cat snmp_info.txt
```

**What Nmap SNMP scripts enumerate:**
- Installed software
- Network interfaces + IP addresses
- Routing tables
- Running services / processes
- **User accounts** (very useful — found administrator + admin in demo)

---

## Step 4 — Leverage Enumerated Data

```bash
# Use discovered usernames for brute force via SMB/RDP
hydra -l administrator -P /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt \
  <target> smb

# Or target SSH, RDP, WinRM depending on open ports
```

---

## Key Takeaways

- SNMP uses **UDP 161** — include `-sU` in Nmap or it won't be scanned
- Community strings are like passwords — "public" and "private" are common defaults
- SNMP can leak **user accounts** — invaluable for brute force attacks
- Nmap's `snmp*` wildcard script is the easiest way to dump everything at once
- SNMPv3 uses real auth/encryption; SNMPv1/v2c are trivially bypassed with community strings
