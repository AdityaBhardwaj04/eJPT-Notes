---
title: Introduction to Enumeration
tags: [Enumeration, ServiceEnumeration, ActiveRecon, PentestMethodology, eJPT]
created: 2026-04-04
source: Notion
---

# Introduction to Enumeration

**Related:** [[Enumeration-Course-Introduction]] | [[Port-Scanning-Nmap]] | [[NSE]] | [[Active-Information-Gathering]] | [[00-INDEX]]

---

## Overview

Enumeration follows host discovery and port scanning. Where port scanning tells you *what ports are open and what services are running*, enumeration asks: **what more can we learn about those services?**

---

## What is Enumeration?

Service enumeration = gathering **additional, more specific and detailed information** about hosts and the services running on them.

### What we already know after port scanning:
- Which hosts are live on the network
- Which ports are open on each host
- What services are running on those ports

### What enumeration adds:
- **Account names / usernames** on a service
- **Shared resources** (e.g. SMB shares)
- **Service banners and version details**
- **Misconfigurations** that could be exploited
- **Potential attack vectors** leading into the exploitation phase

> Think of it as: now that we know *what's open*, let's find out *as much as possible* about each of those services.

---

## Enumeration in the Pentesting Methodology

```
Passive Recon
    ↓
Active Recon (Host Discovery → Port Scanning) → [[Port-Scanning-Nmap]]
    ↓
Enumeration  ← We are here
    ↓
Exploitation
```

The intelligence gathered here directly informs which exploitation techniques or modules to attempt.

---

## Protocol-Specific Approach

Unlike port scanning (broadly applied), enumeration requires a **targeted, protocol-specific approach**:

| Service | Port | What to Enumerate |
|---|---|---|
| SMB | 445 | Shares, users, OS version, null sessions → [[SMB-Enumeration]] |
| RDP | 3389 | Valid usernames, NLA enforcement |
| FTP | 21 | Anonymous login, directory listing → [[FTP-Enumeration]] |
| SSH | 22 | Banner, supported auth methods → [[SSH-Enumeration]] |
| SMTP | 25 | Valid usernames via VRFY/EXPN → [[SMTP-Enumeration]] |
| HTTP | 80/443 | Web server version, directories, apps → [[Web-Server-Enumeration]] |
| MySQL | 3306 | Databases, users, version → [[MySQL-Enumeration]] |

---

## Key Takeaways

- Enumeration is **active** — it generates network traffic and may trigger IDS/IPS
- It is **not** just running service version detection — it actively queries and probes individual services
- The goal is intelligence useful for **exploitation**: credentials, shares, misconfigs, version-specific vulnerabilities
- Tools used vary per protocol — Nmap NSE scripts are the primary tool, alongside dedicated utilities
