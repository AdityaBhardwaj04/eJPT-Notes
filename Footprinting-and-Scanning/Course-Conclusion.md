---
title: Footprinting & Scanning – Course Conclusion
tags: [eJPT, FootprintingAndScanning, CourseConclusion, Nmap, NetworkMapping]
created: 2026-04-04
source: Notion
---

# Footprinting & Scanning – Course Conclusion

**Related:** [[Course-Introduction]] | [[Active-Information-Gathering]] | [[Network-Mapping]] | [[Enumeration-Course-Introduction]] | [[00-INDEX]]

---

## Overview

Conclusion of the **Footprinting & Scanning** course. Revisits all learning objectives before the eJPT certification exam. The next course in the roadmap is **Enumeration**.

---

## Learning Objectives — Report Card

### 1. Network Mapping & Port Scanning
- Full process: host discovery → port scanning → service & version detection → [[Network-Mapping]]
- Advanced topics: fragmentation, decoys, IDS evasion, built sequentially

### 2. OSI Model, TCP & UDP
- OSI model, Network layer (IP, ICMP) + Transport layer (TCP, UDP) → [[Networking-Fundamentals-OSI]] | [[Transport-Layer-TCP-UDP]]
- ICMP: relevant mainly for host discovery (ping sweeps)

### 3. Host Discovery with Nmap
- ICMP ping sweeps, SYN ping, ACK ping → [[Host-Discovery-Techniques]]

### 4. Identify Open Ports & Services
- Port scanning: specific ports, ranges, full TCP range, UDP → [[Port-Scanning-Nmap]] | [[Port-Scanning-Nmap-InDepth]]
- Service version detection + NSE → [[Service-Version-OS-Detection]] | [[NSE]]

### 5. OS & Service Fingerprinting
- OS detection via `-O` flag
- NSE used to enrich OS and service identification → [[NSE]]

### 6. Firewall Detection & IDS Evasion
- ACK scan (`-sA`) for detecting firewalls
- Fragmentation, MTU, decoys, source port spoofing, TTL → [[Firewall-Detection-IDS-Evasion]]

### 7. Scan Timing & Performance
- Timing templates `-T0` to `-T5`
- `--scan-delay`, `--host-timeout` → [[Optimizing-Nmap-Scans]]

### 8. Output Formats & Metasploit Integration
- `-oN`, `-oX`, `-oG`, `-oA`
- `db_import` and `db_nmap` in Metasploit → [[Nmap-Output-Formats]] | [[Importing-Nmap-into-Metasploit]]

---

## What's Next

The next course is **Enumeration** → [[Enumeration-Course-Introduction]]

Instead of just identifying open ports and services, the Enumeration course extracts **what information can be pulled from those services** — account names, shares, misconfigurations — to feed into the exploitation phase.
