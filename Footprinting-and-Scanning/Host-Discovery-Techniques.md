---
title: Host Discovery Techniques
tags: [eJPT, HostDiscovery, Nmap, ICMP, ARP, TCP, PingSweep]
created: 2026-04-01
source: Notion
---

# Host Discovery Techniques

**Related:** [[Network-Mapping]] | [[Port-Scanning-Nmap]] | [[Networking-Fundamentals-OSI]] | [[Transport-Layer-TCP-UDP]] | [[00-INDEX]]

---

## Overview

Host discovery is the **first step in network mapping** — before you can scan ports or fingerprint services, you need to know which hosts are actually alive on the network.

The choice of technique depends on:
- Network characteristics (local vs. remote)
- Stealth requirements
- Security devices in place (firewalls, IDS) → [[Firewall-Detection-IDS-Evasion]]
- Goals of the penetration test

> There is no one-size-fits-all technique — effective host discovery often requires combining multiple methods.

---

## Host Discovery Techniques

### 1. ICMP Ping Sweep (Ping Scan)
- Sends **ICMP Echo Requests** to each IP in a range
- If a host is alive, it responds with an **ICMP Echo Reply**

**Pros:** Widely supported, fast and simple  
**Cons:** **Windows Firewall blocks ICMP by default** — Windows hosts online may appear dead

> Relying only on ping sweeps will cause you to **miss Windows hosts** with the firewall enabled.

---

### 2. ARP Scanning
- Sends **ARP requests** to identify hosts on a **local network**
- Only works within the **same broadcast domain** (same local network/subnet)

**Pros:** Very reliable on local networks — ARP cannot be blocked by host firewalls  
**Cons:** Does **not work across routed networks** — local only

**Use case:** Internal network pen tests where you are connected to the same LAN as the targets.

---

### 3. TCP SYN Ping (Half-Open / Stealth Scan)
- Sends a **TCP SYN packet** to a specific port (commonly port 80)
- If the host is alive → responds with **SYN-ACK**
- Nmap then sends **RST** — does NOT complete the 3-way handshake

**Pros:** Stealthier than ICMP, may bypass firewalls  
**Cons:** Some hosts may not respond to SYN on the default probed port

> In Nmap this is the `-PS` option for host discovery.

---

### 4. UDP Ping
- Sends **UDP packets** to a specific port to check if a host is alive
- Useful for hosts that don't respond to ICMP or TCP probes

**Pros:** Can discover hosts that block ICMP and TCP  
**Cons:** Slower — UDP responses are less predictable

---

### 5. TCP ACK Ping
- Sends a **TCP packet with only the ACK flag set** to a specific port
- If a **TCP RST** is received → host is alive
- **Use case:** Bypassing stateless firewalls that allow established TCP traffic

---

## Technique Comparison

| Technique | Protocol | Requires Local Access | Stealthiness | Blocked by Windows FW |
|---|---|---|---|---|
| ICMP Ping Sweep | ICMP | No | Low | Yes (by default) |
| ARP Scan | ARP | Yes (same subnet) | Medium | No |
| TCP SYN Ping | TCP | No | High | Sometimes |
| UDP Ping | UDP | No | Medium | Varies |
| TCP ACK Ping | TCP | No | Medium | Varies |

---

## Nmap Host Discovery Options

| Nmap Flag | Technique |
|---|---|
| `-sn` | Ping scan (no port scan) — host discovery only |
| `-PE` | ICMP echo request |
| `-PS[port]` | TCP SYN ping (default port 80) |
| `-PA[port]` | TCP ACK ping |
| `-PU[port]` | UDP ping |
| `-PR` | ARP ping (auto-used on local networks) |

```bash
# Basic ping sweep over a subnet
nmap -sn 192.168.1.0/24

# Combine SYN + ICMP for better coverage
nmap -sn -PE -PS80,443 192.168.1.0/24
```

---

## Key Takeaways

- Host discovery = identifying **which IPs have live hosts** before doing anything else
- **ICMP ping sweep** is unreliable against Windows hosts with default firewall settings
- **ARP scanning** is the most reliable on local networks
- **TCP SYN ping** is stealthier and works across routed networks
- Nmap supports all techniques and allows combining them
- The right technique depends on the **network, OS, firewall config, and stealth requirements**
