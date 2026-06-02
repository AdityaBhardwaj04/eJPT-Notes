---
title: Network Mapping
tags: [eJPT, NetworkMapping, ActiveRecon, Nmap, HostDiscovery]
created: 2026-04-01
source: Notion
---

# Network Mapping

**Related:** [[Active-Information-Gathering]] | [[Host-Discovery-Techniques]] | [[Port-Scanning-Nmap]] | [[Service-Version-OS-Detection]] | [[00-INDEX]]

---

## Overview

**Network mapping** is the overarching process in active information gathering that encompasses:
- Host discovery
- Port scanning
- Service version detection
- OS fingerprinting
- Network topology mapping

It is the **first major task** after passive recon — you start blind with only an IP range and build a complete picture of the target network.

---

## What Is Network Mapping?

Network mapping in penetration testing = **discovering and identifying all devices, hosts, and network infrastructure elements within a target network**.

### Real-World Scenario

A company gives you an IP block: `200.200.0.0/16`
- A `/16` subnet = up to **65,536 possible hosts**
- In a **black-box pen test**, you know nothing about:
  - How many systems are online
  - Whether it's Windows/Linux/mixed
  - If there's a domain controller, DMZ, firewall, IDS, etc.
- Your first job: determine which of those 65,536 IPs are **actually assigned and online**

### Goal

By the end of network mapping you should have:
- A list of all active/live hosts and their IP addresses
- Open ports on each host
- Services running on those ports
- Operating systems of each host
- A basic network topology (routers, switches, firewalls, subnets)

---

## Objectives of Network Mapping

| Objective | Description |
|---|---|
| **Live Host Discovery** | Identify which IPs have active devices on the network |
| **Open Ports & Services** | Determine open ports and what service runs on each |
| **Network Topology Mapping** | Map routers, switches, firewalls, and network layout |
| **OS Fingerprinting** | Identify the OS on each host to tailor attack strategies |
| **Service Version Detection** | Find specific versions of services (ties into CVE/vuln research) |
| **Security Measure Identification** | Detect firewalls, IDS/IPS to plan stealth approach → [[Firewall-Detection-IDS-Evasion]] |

> If you know the target is an Active Directory environment, you shift focus to Windows/AD-specific attacks. Knowing the OS matters.

---

## Primary Tool: Nmap

**Nmap** (Network Mapper) — open-source network scanning tool, industry standard.

| Feature | Description |
|---|---|
| **Host Discovery** | Identifies live hosts using ICMP, ARP, TCP, or UDP probes |
| **Port Scanning** | Discovers open TCP/UDP ports |
| **Service Version Detection** | Identifies the specific version of services on open ports |
| **OS Fingerprinting** | Identifies the OS based on scan characteristics |
| **NSE (Scripting Engine)** | Extensible scripts for additional enumeration and vuln detection → [[NSE]] |

> The name **Nmap literally stands for "Network Mapper"** — it was built for exactly this purpose.

---

## How Network Mapping Feeds the Rest of the Pentest

```
Network Mapping
    ↓
Active hosts + open ports + services + OS
    ↓
Enumeration (extract info from services) → [[Introduction-to-Enumeration]]
    ↓
Vulnerability Analysis & Threat Modeling
    ↓
Exploitation
```

---

## Key Takeaways

- Network mapping = the **process umbrella** that includes host discovery, port scanning, service/OS detection
- Start with an IP range, end with a **complete topology of the target network**
- Black-box pen tests require you to build this picture from scratch
- **Nmap** is the primary tool used throughout this process
- Identifying security measures (firewalls, IDS) during mapping helps you adjust scan techniques and timing
