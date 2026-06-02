---
title: Ping Sweeps
tags: [eJPT, FootprintingScanning, HostDiscovery, ICMP, Ping, Nmap]
created: 2026-06-02
source: transcript
---

# Ping Sweeps

**Related:** [[Host-Discovery-Techniques]] | [[Port-Scanning-Nmap]] | [[Course-Introduction]] | [[00-INDEX]]

---

## What is a Ping Sweep?

A **ping sweep** is a network scanning technique that sends **ICMP echo requests** to a range of IP addresses to determine which hosts are live (online/reachable).

Used during the **host discovery** phase of a penetration test to map which systems are active before targeted scanning.

---

## How ICMP Ping Works

| Message | ICMP Type | Code | Meaning |
|---------|-----------|------|---------|
| Echo Request | 8 | 0 | "Are you there?" |
| Echo Reply | 0 | 0 | "Yes, I'm here." |

**No response** = host offline, unreachable, or blocking ICMP.

---

## Critical Limitation: Windows Blocks ICMP

> Windows systems block ICMP echo requests **by default**.

If you rely solely on ping sweeps, you will miss Windows hosts and incorrectly conclude they are offline. Always follow up with Nmap port scans using `-Pn` (skip host discovery) on suspect ranges.

---

## Tools

### 1. `ping` (built-in, all OS)

```bash
# Single host
ping <ip>

# Limit count (Linux: -c, Windows: -n)
ping -c 5 <ip>

# Broadcast scan (crude subnet sweep)
ping -b -c 1 192.168.1.0
```

### 2. `fping` — Efficient Multi-host Ping Sweep

```bash
# Sweep an entire subnet
fping -ag 192.168.1.0/24 2>/dev/null

# Single host
fping <ip>
```

| Flag | Meaning |
|------|---------|
| `-a` | Show **alive** hosts only |
| `-A` | Show alive hosts by IP address |
| `-g` | Generate target list from CIDR notation |
| `-S <ip>` | Spoof source IP (stealth) |

Pipe stderr to `/dev/null` to suppress unreachable messages and get a clean list of live hosts.

### 3. `nmap` — ICMP Ping Sweep

```bash
# ICMP sweep (may miss Windows hosts)
nmap -sn 192.168.1.0/24

# Skip host discovery entirely (treat all as alive — better for Windows targets)
nmap -Pn <target_ip>
```

---

## Practical Lab Commands

```bash
# 1. Identify your interface and subnet
ifconfig eth1

# 2. fping sweep of the subnet
fping -ag 192.168.1.0/24 2>/dev/null
# Output: only live IPs

# 3. Verify a specific IP (with wireshark to confirm ICMP traffic)
ping -c 5 <target_ip>

# 4. If no response, test with nmap -Pn (bypass host discovery)
nmap -Pn <target_ip>
# If ports show up -> host is alive but blocking ICMP
```

---

## Wireshark Verification

To confirm ICMP packets are being sent:

```bash
wireshark eth1 &    # or double-click ethernet1 in GUI
# Run ping, observe ICMP echo request (type 8, code 0) in capture
# No echo reply = host offline or blocking
```

---

## Key Takeaways

- Ping sweeps use **ICMP type 8 (echo request)** → expect **type 0 (echo reply)** from live hosts
- **Windows blocks ICMP by default** — a non-response doesn't mean the host is down
- Use `fping -ag <subnet>` for fast and clean subnet sweeps
- Always confirm with `nmap -Pn` if ping sweep shows no results
- Ping sweeps are a starting point — follow up with [[Port-Scanning-Nmap]] for complete discovery
- Next topic: [[Host-Discovery-Techniques]]
