---
title: Active Information Gathering
tags: [eJPT, ActiveRecon, PentestMethodology, Nmap, NetworkMapping]
created: 2026-04-01
source: Notion
---

# Active Information Gathering

**Related:** [[Active-vs-Passive-Recon]] | [[Network-Mapping]] | [[Host-Discovery-Techniques]] | [[Port-Scanning-Nmap]] | [[Service-Version-OS-Detection]] | [[00-INDEX]]

---

## Overview

**Active information gathering** involves directly interacting with target systems and networks to collect data and identify potential vulnerabilities — in contrast to [[Active-vs-Passive-Recon|passive reconnaissance]].

---

## Penetration Testing Methodology — Big Picture

Active information gathering sits within the broader pentest lifecycle:

```
1. Information Gathering (Passive + Active)
        ↓
2. Enumeration
        ↓
3. Vulnerability Analysis & Threat Modeling
        ↓
4. Exploitation
        ↓
5. Post-Exploitation
   - Local enumeration
   - Privilege escalation
   - Credential/hash harvesting
   - Persistence
   - Detection evasion
   - Lateral movement / pivoting
        ↓
6. Reporting & Cleanup
```

> The process is **cyclical** — after lateral movement to a new system, you repeat post-exploitation phases on that system.

---

## Passive vs. Active Information Gathering

| | Passive | Active |
|---|---|---|
| **Interaction with target** | None — uses public sources only | Direct interaction (scanning, probing) |
| **Techniques** | WHOIS, DNS lookups, Google Dorks, Shodan | Port scanning, host discovery, service/OS fingerprinting |
| **Risk of detection** | Low | Higher — traffic reaches the target |

---

## Active Information Gathering — Key Activities

### 1. Network Mapping → [[Network-Mapping]]
- Understanding the **topology** of a target network
- Identifying active hosts, potential subnets, and network structure

### 2. Host Discovery → [[Host-Discovery-Techniques]]
- Determining which IP addresses have **live systems** on the network
- Tools: Nmap (`-sn` ping scan, ICMP echo, ARP)

### 3. Port Scanning → [[Port-Scanning-Nmap]] | [[Port-Scanning-Nmap-InDepth]]
- Identifying **open TCP/UDP ports** on each active host

### 4. Service Detection → [[Service-Version-OS-Detection]]
- Identifying **what service is running** on each open port
- Tools: Nmap (`-sV` version detection)

### 5. OS Fingerprinting → [[Service-Version-OS-Detection]]
- Determining the **OS** running on each active host
- Tools: Nmap (`-O` OS detection)

---

## What Comes After Active Info Gathering

### Enumeration (Next Course)
- Takes the open ports/services discovered here
- Extracts **additional useful information** from those services
- Examples: SMB enumeration, SNMP enumeration, SSH banner grabbing, HTTP enumeration → [[Introduction-to-Enumeration]]

### Vulnerability Analysis & Threat Modeling
- Uses enumeration results to identify **misconfigurations and CVEs**
- Find the **lowest hanging fruit** — easiest path to exploitation

---

## Key Takeaways

- Active info gathering = **directly interacting** with the target (scanning/probing)
- The phase follows passive recon and feeds enumeration, exploitation, and post-exploitation
- Primary activities: **network mapping → host discovery → port scanning → service/OS detection**
- All of this is done primarily with **Nmap**
- The quality of your scan determines the quality of everything that follows
