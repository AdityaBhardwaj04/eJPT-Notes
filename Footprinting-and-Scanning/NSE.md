---
title: Nmap Scripting Engine (NSE)
tags: [eJPT, Nmap, NSE, Enumeration, ServiceDetection]
created: 2026-04-01
source: Notion
---

# Nmap Scripting Engine (NSE)

**Related:** [[Service-Version-OS-Detection]] | [[Port-Scanning-Nmap]] | [[Firewall-Detection-IDS-Evasion]] | [[Introduction-to-Enumeration]] | [[00-INDEX]]

---

## Overview

The **Nmap Scripting Engine (NSE)** extends Nmap's capabilities by allowing scripts to automate tasks like enumeration, vulnerability detection, brute forcing, and exploitation. It bridges the gap between port scanning and full enumeration.

---

## What is NSE?

- NSE scripts are written in **Lua**
- Scripts have the `.nse` extension
- Located at: `/usr/share/nmap/scripts/`
- Prepackaged with Nmap — community-verified and approved

```bash
ls /usr/share/nmap/scripts/
ls /usr/share/nmap/scripts/ | grep ftp    # Filter by service
```

---

## Script Categories

| Category | Purpose |
|---|---|
| `auth` | Authentication and credential-related scripts |
| `broadcast` | Discover hosts via broadcast/multicast |
| `brute` | Brute force password/credential attacks |
| `default` | Safe, useful scripts — run automatically with `-sC` |
| `discovery` | Information gathering and enumeration |
| `exploit` | Scripts that actively exploit vulnerabilities |
| `safe` | Non-intrusive, safe to run |

> During **active info gathering / enumeration**, stick to `default` and `safe` categories. Avoid `exploit` and `brute` until the exploitation phase.

---

## Running NSE

### Default Script Scan (`-sC`)
```bash
nmap -Pn -sS -sC -p- -T4 <target-ip>
```

### Combined scan (aggressive)
```bash
nmap -Pn -sS -A -p- -T4 <target-ip>
```
`-A` = `-sV` + `-O` + `-sC` + `--traceroute`

### Run a specific script
```bash
nmap --script=mongodb-info <target-ip>
nmap --script=memcached-info <target-ip>
```

### Run multiple scripts
```bash
nmap --script=memcached-info,ftp-anon <target-ip>
```

### Run all scripts matching a pattern (wildcard)
```bash
nmap --script=ftp* <target-ip>      # All FTP scripts
nmap --script=http* <target-ip>     # All HTTP scripts
```

### Limit to a specific port
```bash
nmap --script=mongodb-info -p 6421 <target-ip>
```

### Get help / check script category
```bash
nmap --script-help=mongodb-databases
```

---

## Lab Example — Identifying OS via NSE

Standard `-O` was inconclusive. The `mongodb-databases` script returned:

```
mongodb-databases:
  hostInfo:
    os: Linux
    dist: Ubuntu 14.04
    kernel: 2.6.32
    arch: x86_64
```

This conclusively identified the **Linux distribution and kernel version** — something `-O` couldn't do — because MongoDB exposed system info in its default responses.

> **Key insight:** Misconfigured or verbose services often leak OS/distribution info. NSE exploits this without any active exploitation.

---

## Other Useful Scripts

### Memcached Info
```bash
nmap --script=memcached-info <target-ip>
```
- Not in `default` category — must run explicitly
- Returns: PID, server time, architecture, connection count, **auth status**
- No auth = potential access vector

### FTP Anonymous Login
```bash
nmap --script=ftp-anon -p <ftp-port> <target-ip>
```
Also relevant to: [[FTP-Enumeration]]

---

## Workflow Summary

```bash
# Full comprehensive scan
nmap -Pn -sS -A -p- -T4 <target-ip>

# Targeted scripts after port identification
nmap --script=mongodb-info -p 6421 <target-ip>
nmap --script=memcached-info -p 41288 <target-ip>
nmap --script=ftp-anon -p 55413 <target-ip>

# Check if a script is safe before running
nmap --script-help=<script-name>
```

---

## Key Takeaways

- NSE is covered in depth in the **Enumeration course** → [[Introduction-to-Enumeration]]
- The `default` category is the safe starting point — non-intrusive, runs automatically when services match
- Misconfigured services leak OS/distribution info — NSE exploits this via `default` scripts
- Info gathered here feeds directly into vulnerability analysis and exploitation
