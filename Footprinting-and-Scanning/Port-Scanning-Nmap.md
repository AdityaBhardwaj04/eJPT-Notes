---
title: Port Scanning with Nmap
tags: [eJPT, ActiveRecon, Nmap, PortScanning, Scanning]
created: 2026-03-30
source: Notion
---

# Port Scanning with Nmap

**Related:** [[Host-Discovery-Techniques]] | [[Port-Scanning-Nmap-InDepth]] | [[Service-Version-OS-Detection]] | [[NSE]] | [[Nmap-Output-Formats]] | [[Transport-Layer-TCP-UDP]] | [[00-INDEX]]

---

## Overview

After identifying live hosts, port scanning determines which **TCP/UDP ports are open** and what **services/versions** are running on them. This is the primary enumeration step before exploitation.

---

## Default Nmap Scan

```bash
nmap <target-ip>
```

- Performs a **SYN scan** on the **1,000 most commonly used TCP ports**
- Does NOT scan all 65,535 ports
- Does NOT detect service versions

**Issue with Windows targets:** Windows blocks ICMP by default → Nmap reports "host seems down."

**Fix — skip host discovery:**
```bash
nmap -Pn <target-ip>
```

---

## Port Specification

```bash
# Single port
nmap -Pn -p 80 <target-ip>

# Multiple specific ports
nmap -Pn -p 80,443,445,3389 <target-ip>

# Port range
nmap -Pn -p 1-10000 <target-ip>

# ALL 65,535 TCP ports
nmap -Pn -p- <target-ip>

# Fast scan — 100 most common ports
nmap -Pn -F <target-ip>
```

---

## Scan Types

### TCP SYN Scan (default, requires root) — Recommended
```bash
sudo nmap -sS <target-ip>
```
- Default when run as root
- Stealthier — doesn't complete the TCP handshake → [[Transport-Layer-TCP-UDP]]
- Faster than connect scan

### TCP Connect Scan (no root needed)
```bash
nmap -sT <target-ip>
```
- Completes full TCP handshake
- More visible in logs

### UDP Port Scan
```bash
sudo nmap -sU <target-ip>
```
- Slower than TCP scans
- Important — services like DNS (53), SNMP (161), DHCP (67/68) run on UDP

---

## Service & Version Detection

```bash
nmap -Pn -sV <target-ip>
nmap -Pn -F -sV <target-ip>    # Fast + version
```

Adds a **VERSION** column. Example:
```
80/tcp   open  http    HttpFileServer 2.3
445/tcp  open  smb     Windows Server 2008 R2 - 2012
3389/tcp open  rdp     Microsoft Terminal Services
```

Version info is critical — allows you to search for **CVEs** against specific software versions.

---

## Operating System Detection

```bash
sudo nmap -Pn -O <target-ip>
```

- Guesses the OS based on open port responses and service banners
- Not always accurate — gives a range (e.g., "Windows Server 2008 R2 to 2012")
- Requires at least one open and one closed port for best accuracy

---

## Default Script Scan (NSE)

```bash
nmap -Pn -sC <target-ip>
```

Runs **Nmap's default scripts** against open ports → [[NSE]]

---

## Aggressive Scan

```bash
sudo nmap -Pn -A <target-ip>
```

Equivalent to: `-sV -O -sC` (version detection + OS detection + default scripts)

---

## Timing Templates

| Template | Name | Use Case |
|---|---|---|
| `-T0` | Paranoid | IDS evasion (very slow) |
| `-T1` | Sneaky | IDS evasion |
| `-T2` | Polite | Reduced bandwidth |
| `-T3` | Normal | Default |
| `-T4` | Aggressive | Fast — reliable networks |
| `-T5` | Insane | Fastest — may drop packets |

```bash
sudo nmap -Pn -T4 -sV <target-ip>    # Fast aggressive
sudo nmap -Pn -T1 <target-ip>         # Stealthy
```

> **Warning:** `-T5` can cause packet loss or crash switches/routers on production networks.

---

## Saving Scan Output

```bash
nmap -Pn -sV <target-ip> -oN scan_results.txt    # Normal text
nmap -Pn -sV <target-ip> -oX scan_results.xml    # XML (for Metasploit)
nmap -Pn -sV <target-ip> -oA scan_results        # All formats
```

→ See [[Nmap-Output-Formats]] for full details.

---

## Common Port Reference

| Port | Protocol | Service |
|---|---|---|
| 21 | TCP | FTP |
| 22 | TCP | SSH |
| 23 | TCP | Telnet |
| 25 | TCP | SMTP |
| 53 | TCP/UDP | DNS |
| 80 | TCP | HTTP |
| 135 | TCP | MSRPC |
| 139 | TCP | NetBIOS |
| 443 | TCP | HTTPS |
| 445 | TCP | SMB |
| 3306 | TCP | MySQL |
| 3389 | TCP | RDP |
| 8080 | TCP | HTTP Proxy / Alt HTTP |

---

## Recommended Workflow

```bash
# 1. Identify your subnet
ip a

# 2. Host discovery
sudo nmap -sn 192.168.1.0/24

# 3. Fast scan on a discovered target
sudo nmap -Pn -F <target-ip>

# 4. Full TCP scan with service versions
sudo nmap -Pn -p- -sV <target-ip> -oN full_scan.txt

# 5. Aggressive scan
sudo nmap -Pn -A -T4 <target-ip> -oA aggressive_scan
```

---

## Key Takeaways

- Use `-Pn` on Windows targets to skip ICMP checks
- `-p-` scans all 65,535 TCP ports; `-F` scans only top 100
- `-sV` reveals service versions — essential for vulnerability research
- `-sC` runs default NSE scripts — extra enumeration for free
- `-A` = `-sV -O -sC` combined
- Always save output with `-oN` or `-oA`
- `-oX` XML output can be imported directly into Metasploit → [[Importing-Nmap-into-Metasploit]]
