---
title: Footprinting & Scanning — Index
tags: [eJPT, Footprinting, Scanning, Nmap, Index, Hub]
created: 2026-04-06
source: Notion
---

# Footprinting & Scanning

**Related:** [[00-INDEX]] | [[Reconnaissance/00-INDEX]] | [[Enumeration/00-INDEX]]

---

## Overview

Footprinting and scanning is the active phase that follows passive reconnaissance. The goal is to map the network, discover live hosts, identify open ports, detect running services, and fingerprint operating systems.

```
Passive Recon
    ↓
Active Recon ← This section
    │
    ├── Host Discovery
    ├── Port Scanning
    ├── Service/OS Detection
    └── Output & Integration
    ↓
Enumeration
```

---

## Notes in This Section

| Note | Topic |
|---|---|
| [[Course-Introduction]] | Course roadmap, prerequisites port table, learning objectives |
| [[Active-Information-Gathering]] | Pentest methodology, passive vs active distinction |
| [[Network-Mapping]] | /16 subnet scenario, objectives, Nmap feature overview |
| [[Host-Discovery-Techniques]] | 6 techniques comparison, Nmap host discovery flags |
| [[Port-Scanning-Nmap]] | Core Nmap usage — -Pn, port specs, scan types, -sV, -O, timing, output |
| [[Port-Scanning-Nmap-InDepth]] | SYN vs TCP Connect mechanics, port states, UDP scanning |
| [[Service-Version-OS-Detection]] | -sV intensity levels, -O flags, non-standard port lab example |
| [[NSE]] | Script categories, -sC, specific/wildcard/multi scripts, MongoDB example |
| [[Optimizing-Nmap-Scans]] | Timing templates, --scan-delay, --host-timeout with benchmarks |
| [[Nmap-Output-Formats]] | -oN/-oX/-oG/-oA, --reason, db_import workflow |
| [[Firewall-Detection-IDS-Evasion]] | ACK scan, fragmentation, MTU, decoys, source port, combined evasion |
| [[Course-Conclusion]] | Learning objectives review, transition to Enumeration |

---

## Nmap Quick Reference

```bash
# Host discovery
nmap -sn <subnet>/24

# Basic scan (skip ping for Windows)
nmap -Pn <target>

# Service + OS detection
nmap -Pn -sV -O <target>

# Full enumeration
nmap -Pn -sV -O -sC -A <target>

# Save for Metasploit
nmap -Pn -sV -O -oX output.xml <target>

# Stealth SYN scan
nmap -sS <target>
```

---

## Key Tools

| Tool | Purpose |
|---|---|
| `nmap` | Port scanning, service detection, OS fingerprinting, NSE scripts |
| `db_nmap` | Nmap inside Metasploit — results auto-saved to workspace |
| `db_import` | Import Nmap XML into Metasploit workspace |
