---
title: Transport Layer (OSI Layer 4) – TCP & UDP
tags: [eJPT, Networking, TCP, UDP, Ports, ThreeWayHandshake]
created: 2026-04-01
source: Notion
---

# Transport Layer (OSI Layer 4) – TCP & UDP

**Related:** [[Networking-Fundamentals-OSI]] | [[Port-Scanning-Nmap]] | [[Port-Scanning-Nmap-InDepth]] | [[Firewall-Detection-IDS-Evasion]] | [[00-INDEX]]

---

## Overview

The **Transport Layer (Layer 4)** of the OSI model:
- Facilitates **end-to-end communication** between two devices
- Handles **error detection, flow control, and segmentation** of data
- Operates on top of the Network Layer (IP)
- Primary protocols: **TCP** and **UDP**

Understanding this layer is critical for pen testers because:
- Most services run on TCP or UDP ports
- Nmap operates at this layer to discover open ports
- TCP flags are the basis of many Nmap scan types (SYN scan, ACK scan, FIN scan, etc.)

---

## TCP vs UDP — Quick Comparison

| Feature | TCP | UDP |
|---|---|---|
| Connection | Connection-oriented (3-way handshake) | Connectionless |
| Reliability | Reliable — guarantees delivery and order | Unreliable — no guarantee |
| Retransmission | Yes — retransmits lost segments | No |
| Header Size | Larger (higher overhead) | Smaller (lower overhead) |
| Speed | Slower (due to handshake and acks) | Faster |
| Use Cases | Web (HTTP/HTTPS), email, FTP, SSH | DNS, DHCP, VoIP, streaming, gaming |

---

## TCP (Transmission Control Protocol)

### Characteristics
- **Connection-oriented** — must establish a connection before any data transfer
- **Reliable** — uses acknowledgements (ACKs) and retransmission of lost/corrupted segments
- **Ordered data transfer** — segments are reordered if they arrive out of sequence

### TCP Three-Way Handshake

Before any data can be sent, TCP requires a **three-step handshake**:

```
Client                          Server
  |  ---- SYN (seq=0) ------->  |   Step 1: Client sends SYN
  |  <-- SYN-ACK (seq=0,ack=1)  |   Step 2: Server responds SYN-ACK
  |  ---- ACK (ack=1) ------->  |   Step 3: Client sends ACK → connection established
  |                              |
  |  ===== DATA TRANSFER ====>  |
```

| Step | Flags Set | Description |
|---|---|---|
| SYN | `SYN=1, ACK=0, FIN=0` | Client initiates connection; includes Initial Sequence Number (ISN) |
| SYN-ACK | `SYN=1, ACK=1, FIN=0` | Server acknowledges + sends its own ISN |
| ACK | `SYN=0, ACK=1, FIN=0` | Client confirms → TCP session established |

### TCP Control Flags

| Flag | Name | Purpose |
|---|---|---|
| **SYN** | Synchronize | Initiates a connection |
| **ACK** | Acknowledge | Acknowledges received data |
| **FIN** | Finish | Initiates connection termination |
| **RST** | Reset | Abruptly resets/terminates a connection |
| **PSH** | Push | Tells receiver to pass data to application immediately |
| **URG** | Urgent | Marks data as urgent |

> For pen testing: **SYN, ACK, FIN, RST** are the most important flags. Different Nmap scan types manipulate these flags to probe how a target responds.

### TCP Port Ranges

| Range | Name | Description | Examples |
|---|---|---|---|
| **0 – 1023** | Well-Known Ports | Reserved for standardized services (IANA) | 22 SSH, 80 HTTP, 443 HTTPS, 21 FTP, 25 SMTP |
| **1024 – 49151** | Registered Ports | Assigned by IANA to vendors/applications | 3389 RDP, 3306 MySQL, 8080 HTTP-alt, 27017 MongoDB |
| **49152 – 65535** | Dynamic/Private | Ephemeral ports used by clients | Randomly assigned client-side source ports |

> Max port number in TCP/IP: **65,535**

---

## UDP (User Datagram Protocol)

### Characteristics
- **Connectionless** — no handshake, no session, no state
- **Unreliable** — no guaranteed delivery, no retransmission
- **Faster and lower overhead** — smaller header, no handshake delay
- **Stateless** — each UDP datagram is independent; no sequence tracking

### Common UDP Protocols

| Protocol | Port | Use |
|---|---|---|
| DNS | 53 | Domain name resolution |
| DHCP | 67/68 | Dynamic IP assignment |
| SNMP | 161 | Network monitoring |
| VoIP/SIP | 5060 | Voice over IP |

---

## Viewing TCP Connections

```bash
# Linux
netstat -atp    # All TCP connections with process names and PIDs

# Windows
netstat -ao     # All TCP connections with Process IDs
```

**States to know:**
- `ESTABLISHED` — active connection
- `TIME_WAIT` — connection termination has been requested but not yet closed

---

## Relevance to Nmap Scan Types

| Nmap Scan Type | Flags Sent | Why |
|---|---|---|
| **SYN Scan** (`-sS`) | SYN only | Doesn't complete handshake — "half-open" — stealthier |
| **Connect Scan** (`-sT`) | Full 3-way handshake | Completes TCP connection — less stealthy |
| **ACK Scan** (`-sA`) | ACK only | Used to map firewall rules |
| **FIN/NULL/Xmas Scans** | FIN / none / FIN+URG+PSH | Probe how targets respond to unusual flag combinations |

Understanding TCP flags = understanding why Nmap behaves the way it does → [[Port-Scanning-Nmap-InDepth]]

---

## Key Takeaways

- **TCP** = reliable, connection-oriented, ordered — 3-way handshake (SYN → SYN-ACK → ACK)
- **UDP** = fast, connectionless, unreliable — used for DNS, DHCP, VoIP, streaming
- **TCP flags** (SYN, ACK, FIN, RST) are the foundation of Nmap scan types
- Port range: 0–65535; well-known ports are 0–1023
- Use `netstat -atp` (Linux) or `netstat -ao` (Windows) to view active TCP connections
