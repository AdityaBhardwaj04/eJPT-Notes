---
title: Service Version & OS Detection with Nmap
tags: [eJPT, Nmap, ServiceDetection, OSDetection, VersionScan]
created: 2026-04-01
source: Notion
---

# Service Version & OS Detection with Nmap

**Related:** [[Port-Scanning-Nmap-InDepth]] | [[NSE]] | [[Nmap-Output-Formats]] | [[00-INDEX]]

---

## Overview

After finding open ports, the next step is identifying **what services** are running and **what OS** the target is using. This is critical for vulnerability assessment — knowing exact service versions lets you search for CVEs and misconfigurations.

---

## Lab Workflow

In a live lab where the target IP isn't given:

```bash
# Step 1: Find your network range
ifconfig eth1         # Check IP and netmask
ip a                  # Alternative

# Step 2: Host discovery
nmap -sn <subnet>/24  # e.g., nmap -sn 192.168.1.0/24

# Step 3: Full port scan
nmap -Pn -sS -p- -T4 <target-ip>
```

> **Lesson:** Always scan the full TCP port range. Default 1,000 ports may miss open services on unusual ports.

---

## Service Version Detection — `-sV`

Actively probes open ports to identify the **exact service and version**:

```bash
nmap -Pn -sS -sV -p- -T4 <target-ip>
```

Output adds a "VERSION" column:
```
PORT      STATE SERVICE   VERSION
6421/tcp  open  mongodb   MongoDB 2.6.10
41288/tcp open  memcache  Memcached
55413/tcp open  ftp       vsftpd 3.0.3
```

### Version Intensity

Controls how aggressively Nmap probes for version info (0–9, default ~7):

```bash
nmap -sV --version-intensity 8 <target-ip>
```

Higher intensity = more accurate but slower.

---

## OS Detection — `-O`

Attempts to identify the target's operating system via TCP/IP fingerprinting:

```bash
nmap -Pn -sS -O <target-ip>
```

### Aggressive OS Guessing

When Nmap can't conclusively identify the OS, force a best-guess:

```bash
nmap -Pn -sS -O --osscan-guess <target-ip>
```

- Reports **kernel versions** for Linux (e.g., `Linux 2.6.32` at 96%)
- For Windows, will report version and build (e.g., `Windows Server 2012 R2`)

> Combining `-sV` with `-O` improves OS detection accuracy — service versions provide additional fingerprinting context.

---

## Combined Scan

```bash
nmap -Pn -sS -sV -O -p- -T4 <target-ip>

# Shorthand (aggressive)
nmap -Pn -sS -A -p- -T4 <target-ip>
```

`-A` enables: OS detection + version scanning + default script scan + traceroute

---

## Example Findings (Lab)

Non-standard ports discovered from full port scan:

| Port | Service | Version |
|---|---|---|
| 6421/tcp | MongoDB | 2.6.10 |
| 41288/tcp | Memcached | — |
| 55413/tcp | vsftpd (FTP) | 3.0.3 |

- OS detection via `-O` was inconclusive
- Resolved using **NSE** — [[NSE]] (MongoDB script leaked OS/kernel info)

---

## Key Takeaways

- `-sV` = service version detection — always include this
- `-O` = OS detection via TCP/IP fingerprinting — not always conclusive
- `-A` = combines `-sV -O -sC` — the go-to aggressive scan flag
- If OS detection fails, use [[NSE]] — services often leak OS/distribution info
- All version info feeds directly into CVE/exploit research for the exploitation phase
