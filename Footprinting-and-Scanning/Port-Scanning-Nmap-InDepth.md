---
title: Port Scanning with Nmap – In Depth
tags: [eJPT, PortScanning, Nmap, SYNScan, TCPConnect, UDPScan]
created: 2026-04-01
source: Notion
---

# Port Scanning with Nmap – In Depth

**Related:** [[Port-Scanning-Nmap]] | [[Transport-Layer-TCP-UDP]] | [[Service-Version-OS-Detection]] | [[Firewall-Detection-IDS-Evasion]] | [[00-INDEX]]

---

## Overview

Port scanning is the natural next step after host discovery — once you know which hosts are alive, you need to identify what ports are open and what services are running on them. This builds the picture needed for vulnerability assessment and exploitation.

---

## Default Nmap Port Scan

Running `nmap <target>` without options:
- As root: runs a **SYN scan** (`-sS`)
- As non-root: runs a **TCP Connect scan** (`-sT`)
- Scans **1,000 most commonly used TCP ports** by default

```bash
nmap <target-ip>
```

---

## Key Options

### Skip Host Discovery (`-Pn`)
```bash
nmap -Pn <target-ip>
```
- Skips the host-alive check and goes straight to port scanning
- Essential for Windows targets that block discovery probes

### Fast Scan (`-F`)
```bash
nmap -Pn -F <target-ip>
```
Scans **100** most commonly used ports.

### Specific Ports (`-p`)
```bash
nmap -Pn -p 80 <target-ip>               # Single port
nmap -Pn -p 80,445,3389 <target-ip>      # Multiple ports
nmap -Pn -p 1-100 <target-ip>            # Range
nmap -Pn -p- <target-ip>                 # All 65,535 ports
nmap -Pn -p- -T4 <target-ip>             # All ports, faster
```

> **Best practice:** Always scan the entire TCP port range (`-p-`) — services are often found on non-standard ports.

---

## SYN Scan (Stealth Scan) — `-sS`

The **preferred and default** port scanning technique when running as root.

**How it works:**
1. Nmap sends a **SYN** packet
2. If **open** → target responds with **SYN-ACK** → Nmap sends **RST** (terminates before full handshake)
3. If **closed** → target responds with **RST**
4. If **no response** → port is likely **filtered** (firewall dropping packets)

```bash
nmap -Pn -sS -F <target-ip>
```

**Why it's preferred:**
- Does **not complete** the 3-way handshake → avoids TCP session log entries
- Stealthier against IDS/IPS
- Faster

> Also known as: **stealth scan**, **half-open scan**

---

## TCP Connect Scan — `-sT`

Default when running **without root privileges**.

```bash
nmap -Pn -sT -F <target-ip>
```

**How it works:** Completes full 3-way handshake, then sends RST-ACK to tear down.

**Disadvantages:** Loud — completes the TCP handshake, easily logged by the OS and IDS.

---

## Interpreting Port States

| State | Meaning |
|---|---|
| `open` | Port is accepting connections |
| `closed` | Port is reachable but no service listening (no firewall) |
| `filtered` | No response — likely blocked by a firewall → [[Firewall-Detection-IDS-Evasion]] |

> If ports show `filtered` on a Windows target, this indicates **Windows Firewall** is active. On a system without a firewall, closed ports show as `closed`.

---

## UDP Scan — `-sU`

```bash
nmap -Pn -sU -p 53,137,138,139 <target-ip>
```

- Much slower than TCP scanning
- Common UDP ports: 53 (DNS), 137-139 (NetBIOS)
- Results often show `open|filtered` due to firewalls dropping UDP responses

---

## Workflow Summary

```bash
# 1. Fast initial scan
nmap -Pn -F <target-ip>

# 2. Full TCP port scan (comprehensive)
nmap -Pn -sS -p- -T4 <target-ip>

# 3. UDP scan on key ports
nmap -Pn -sU -p 53,137,138,139 <target-ip>
```

---

## Key Takeaways

- The **service column** in default scans is an educated guess — use `-sV` to confirm → [[Service-Version-OS-Detection]]
- SYN scan (`-sS`) = preferred: stealthy, fast, doesn't complete handshake
- TCP Connect scan (`-sT`) = use when you don't have root
- `filtered` = firewall; `closed` = no firewall, no service
- Always scan full port range with `-p-`
