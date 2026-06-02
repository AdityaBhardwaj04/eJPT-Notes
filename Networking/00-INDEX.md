---
title: Networking Fundamentals — Index
tags: [eJPT, Networking, OSI, TCP, UDP, Index, Hub]
created: 2026-04-06
source: Notion
---

# Networking Fundamentals

**Related:** [[00-INDEX]] | [[Footprinting-and-Scanning/00-INDEX]]

---

## Overview

Foundational networking knowledge required before starting active scanning and enumeration. Understanding how packets travel, how TCP/UDP behave, and how ports work is essential context for interpreting Nmap output and understanding attack techniques.

---

## Notes in This Section

| Note | Topic |
|---|---|
| [[Networking-Fundamentals-OSI]] | 7-layer OSI model, packet structure (header + payload), encapsulation |
| [[Transport-Layer-TCP-UDP]] | TCP vs UDP comparison, 3-way handshake, TCP flags, port ranges, Nmap scan type mapping |

---

## Key Concepts

| Concept | Where Used |
|---|---|
| OSI Layer 3 (Network) | IP routing, host discovery |
| OSI Layer 4 (Transport) | Port scanning, TCP/UDP distinction |
| TCP 3-way handshake | Understanding SYN vs TCP Connect scans |
| TCP flags (SYN/ACK/RST/FIN) | Nmap scan types, firewall evasion |
| Port ranges (0-1023, 1024-49151, 49152-65535) | Interpreting scan results |
