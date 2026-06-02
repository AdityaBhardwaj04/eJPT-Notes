---
title: Footprinting & Scanning – Course Introduction
tags: [eJPT, ActiveRecon, Nmap, Methodology]
created: 2026-04-01
source: Notion
---

# Footprinting & Scanning – Course Introduction

**Related:** [[Active-Information-Gathering]] | [[Networking-Fundamentals-OSI]] | [[Network-Mapping]] | [[00-INDEX]]

---

## Course Overview

This course covers **active information gathering** — specifically targeting IP addresses and networks — building on the passive information gathering covered in the previous course.

- **Previous course:** Passive information gathering ([[WHOIS-Enumeration]], [[DNS-Reconnaissance]], [[Google-Dorks]], etc.)
- **This course:** Active information gathering via network mapping, host discovery, port scanning, OS/service detection
- **Next course:** Enumeration (extracting useful data from open services)

---

## Topics Covered

1. **Networking Fundamentals** – OSI model, network layer (IP, ICMP), transport layer (TCP, UDP) → [[Networking-Fundamentals-OSI]] | [[Transport-Layer-TCP-UDP]]
2. **Host Discovery** – Identifying active systems using Nmap → [[Host-Discovery-Techniques]]
3. **Port Scanning** – Identifying open TCP/UDP ports → [[Port-Scanning-Nmap]] | [[Port-Scanning-Nmap-InDepth]]
4. **OS & Service Fingerprinting** – Determining OS and services on each host → [[Service-Version-OS-Detection]]
5. **Nmap Scripting Engine (NSE)** – Scripts for additional enumeration → [[NSE]]
6. **Firewall Detection & Evasion** – Detecting stateful firewalls, fragmentation evasion → [[Firewall-Detection-IDS-Evasion]]
7. **Scan Timing & Performance** – Tuning Nmap speed → [[Optimizing-Nmap-Scans]]
8. **Output & Verbosity** – Exporting results for reporting and Metasploit → [[Nmap-Output-Formats]]

---

## Primary Tool: Nmap

All active scanning in this course is performed with **Nmap**.

### Why Nmap?
- Industry-standard tool used by pen testers, red teamers, defenders, and network engineers
- Extensively documented and battle-tested
- Understanding Nmap sets the foundation for using other tools (Rustscan, Masscan, etc.)

### Other Notable Tools (mentioned for context)
- **Rustscan** – Fast port scanner built on top of Nmap
- **Masscan** – High-speed port scanner
- **Metasploit** – Post-exploitation framework; can import Nmap XML output

---

## Prerequisites

- Basic familiarity with Windows and Linux CLI
- Knowledge of common TCP/UDP ports:

| Port | Protocol | Service |
|---|---|---|
| 22 | TCP | SSH |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |
| 445 | TCP | SMB (common on Windows) |

---

## Learning Objectives

By the end of this course, you will be able to:
1. Understand the importance of **network mapping and port scanning** in a pentest
2. Have a fundamental understanding of the **OSI model** and TCP/UDP
3. **Map networks and discover hosts** using Nmap
4. **Identify open ports** and the services running on them
5. Perform **OS and service fingerprinting** with Nmap
6. **Detect and evade firewalls** using packet fragmentation
7. **Tune Nmap scan timing** for different network environments
8. Be proficient in Nmap for the active information gathering phase

---

## Key Takeaway

> The goal of this course is to make you proficient with **Nmap** for active information gathering: host discovery, port scanning, OS/service detection, and basic firewall evasion — all essential skills for the eJPT certification.
