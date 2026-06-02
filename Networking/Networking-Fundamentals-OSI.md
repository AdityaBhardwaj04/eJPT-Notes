---
title: Networking Fundamentals & OSI Model
tags: [eJPT, Networking, OSIModel, Protocols]
created: 2026-04-01
source: Notion
---

# Networking Fundamentals & OSI Model

**Related:** [[Transport-Layer-TCP-UDP]] | [[Port-Scanning-Nmap]] | [[Host-Discovery-Techniques]] | [[00-INDEX]]

---

## Why This Matters for Pen Testers

Understanding networking fundamentals is essential for effectively performing port scanning and host discovery. Tools like Nmap operate at these layers, so knowing how they work makes you a better operator.

---

## Network Protocols

- **Hosts** = any system on a network (laptops, routers, IoT devices, mobile devices, etc.)
- Hosts communicate via **network protocols** — standardized rules ensuring different hardware/software/OS combinations can talk to each other
- Information is transmitted as **packets** — streams of bits running as electrical signals over physical media (Ethernet, Wi-Fi)

### Packet Structure

Every packet (regardless of protocol) has two parts:

| Part | Purpose |
|---|---|
| **Header** | Protocol-specific metadata (source/destination address, port, TTL, flags, etc.) |
| **Payload** | The actual data being sent (file content, message, etc.) |

- The **header** tells the receiving host how to process the packet
- Different protocols have different header structures (IP header ≠ TCP header)

---

## The OSI Model

**OSI** = Open Systems Interconnection — a conceptual framework that standardizes network communication into **7 abstraction layers**.

Developed by ISO to ensure interoperability across diverse hardware and software.

### The 7 Layers (Bottom to Top)

| Layer | Name | Description | Examples |
|---|---|---|---|
| 1 | **Physical** | Physical connection and transmission medium | Ethernet cables, USB, coaxial, fiber, hubs |
| 2 | **Data Link** | Framing, MAC addressing, error detection at local level | Ethernet frames, switches, MAC addresses |
| 3 | **Network** | Logical addressing, routing, forwarding packets across networks | IP, ICMP, IPSec |
| 4 | **Transport** | End-to-end communication, flow control, segmentation | TCP, UDP |
| 5 | **Session** | Manages sessions/connections between applications | APIs, NetBIOS, RPC |
| 6 | **Presentation** | Data format translation, encryption, compression | SSL/TLS, JPEG, GIF, SSH, IMAP |
| 7 | **Application** | Network services to end users / applications | HTTP, FTP, DNS, SSH, IRC |

### Key Points
- Each layer **builds on the one below it** — the transport layer cannot work without the network layer, etc.
- This is called **encapsulation** — each layer wraps the layer above it inside its own packet/frame
- The OSI model is a **reference model**, not a strict blueprint — used to understand and design network architectures

### Layers Most Relevant to Pen Testing
- **Layer 3 (Network):** IP — logical addressing, routing
- **Layer 4 (Transport):** TCP/UDP — end-to-end communication, ports → [[Transport-Layer-TCP-UDP]]

---

## Encapsulation in Practice

When you browse to google.com, a request cascades through all 7 layers:

```
Application (HTTP request)
    → Presentation (TLS encryption)
        → Session (session management)
            → Transport (TCP segment with port numbers)
                → Network (IP packet with source/destination IP)
                    → Data Link (Ethernet frame with MAC addresses)
                        → Physical (electrical signals on the wire)
```

This can be visualized with **Wireshark** — each captured packet shows all encapsulated layers.

---

## Key Takeaways

- Network protocols exist to standardize communication between heterogeneous systems
- All network data is transmitted as **packets** with a **header + payload** structure
- The **OSI model** gives you a framework to understand what happens at each layer
- As a pen tester, focus especially on **Layers 3 and 4** — this is where Nmap operates → [[Port-Scanning-Nmap]]
