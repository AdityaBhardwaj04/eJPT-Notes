---
title: Port Scanning & Enumeration with Nmap (Metasploit Integration)
tags: [Enumeration, Nmap, Metasploit, PortScanning, ServiceDetection, XMLExport, eJPT]
created: 2026-04-04
source: Notion
---

# Port Scanning & Enumeration with Nmap (Metasploit Integration)

**Related:** [[Port-Scanning-Nmap]] | [[Importing-Nmap-into-Metasploit]] | [[Service-Version-OS-Detection]] | [[Nmap-Output-Formats]] | [[00-INDEX]]

---

## Overview

Using **Nmap for port scanning and enumeration**, then exporting results in XML for import into the **Metasploit framework**. This is the first practical section of the Enumeration course.

---

## Default Nmap Scan

```bash
nmap <target-ip>
```

On Windows targets, this often returns:
```
Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
```

Windows blocks ICMP ping probes by default. Use `-Pn` to skip host discovery:

```bash
nmap -Pn <target-ip>
```

---

## Enumerating Service Versions & OS

```bash
nmap -Pn -sV -O <target-ip>
```

| Flag | Purpose |
|---|---|
| `-Pn` | Skip ping/host discovery |
| `-sV` | Detect service versions on open ports |
| `-O` | Attempt OS fingerprinting |

**Example output on a Windows target:**

| Port | Service | Info |
|---|---|---|
| 80 | HTTP | HTTP File Server (HFS) |
| 135 | MSRPC | Microsoft RPC |
| 139 | NetBIOS | NetBIOS Session Service |
| 445 | SMB | Microsoft SMB (reveals probable OS version) → [[SMB-Enumeration]] |
| 3389 | RDP | Microsoft Terminal Services |

> SMB banners are particularly useful — they often reveal the **probable OS version** even when `-O` can't confirm it definitively.

---

## Exporting Results to XML for Metasploit

```bash
nmap -Pn -sV -O -oX WindowsServer2012.xml <target-ip>
```

- Results still print to terminal as normal
- Verify: `cat WindowsServer2012.xml`

---

## Importing into Metasploit

```bash
service postgresql start
msfconsole
db_import /path/to/WindowsServer2012.xml
hosts
services
```

→ Full workflow covered in [[Importing-Nmap-into-Metasploit]]

---

## Practical Workflow

```bash
# 1. Quick scan to see what's open
nmap -Pn <target-ip>

# 2. Full enumeration with version + OS
nmap -Pn -sV -O <target-ip>

# 3. Save to XML for Metasploit
nmap -Pn -sV -O -oX scan_results.xml <target-ip>

# 4. Import into Metasploit
msfconsole
db_import scan_results.xml
hosts
services
```

---

## Key Takeaways

- `-Pn` is almost always needed for **Windows** targets
- XML export is specifically required for `db_import` — normal/grepable formats won't work
- SMB (445) is a high-value target — often leaks OS version and supports further enumeration → [[SMB-Enumeration]]
- RDP (3389) presence means remote access may be possible with valid credentials
