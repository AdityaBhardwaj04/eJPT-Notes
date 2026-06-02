---
title: Firewall Detection & IDS Evasion with Nmap
tags: [eJPT, Nmap, FirewallDetection, IDSEvasion, Spoofing, Fragmentation]
created: 2026-04-04
source: Notion
---

# Firewall Detection & IDS Evasion with Nmap

**Related:** [[Port-Scanning-Nmap-InDepth]] | [[Optimizing-Nmap-Scans]] | [[WAF-Detection-wafw00f]] | [[NSE]] | [[00-INDEX]]

---

## Overview

Understanding whether a firewall or IDS is present — and how to work around it — is critical for a realistic penetration test. This note covers:

- Detecting firewalls using the ACK scan (`-sA`)
- IDS evasion via fragmentation, decoys, source port spoofing, TTL manipulation, and padding

---

## Part 1 — Firewall Detection

### ACK Scan (`-sA`)

Sends packets with the **ACK flag** set. Does **not** detect open ports — tells you whether ports are **filtered** (firewall) or **unfiltered** (no firewall).

```bash
nmap -Pn -sA -p 445,3389 <target-ip>
```

| Result | Meaning |
|---|---|
| `unfiltered` | Port is reachable — no stateful firewall blocking ACK packets |
| `filtered` | No response — a stateful firewall is likely present |

> A stateful firewall drops ACK packets that don't belong to an established connection. If Nmap gets no response → firewall present. If it gets RST back → port is unfiltered.

### Detecting Firewalls via Port States

| Port State in Scan | Inference |
|---|---|
| `closed` (RST received) | Port reachable — **no firewall** filtering packets |
| `filtered` (no response) | Packets being dropped — **firewall is active** |

> On Windows targets: if a SYN scan returns `filtered` for non-listening ports, Windows Firewall is active.

```bash
nmap -Pn -sS -F <target-ip>    # Check for filtered vs closed states
```

---

## Part 2 — IDS Evasion Techniques

### 1. Packet Fragmentation (`-f`)

Splits Nmap's TCP packets into small **8-byte IP fragments**. An IDS analyzing individual fragments cannot easily determine the full packet intent.

```bash
nmap -Pn -sS -sV -F -f <target-ip>
```

- Default fragment size: **8 bytes** per fragment
- Fragments are reassembled at the destination before processing
- Fragmentation occurs at the **network (IP) layer**

### 2. Custom MTU (`--mtu <value>`)

Controls **maximum size of each packet fragment** (must be a multiple of 8).

```bash
nmap -Pn -sS -F --mtu 8 <target-ip>     # Smallest fragments, maximum fragmentation
nmap -Pn -sS -F --mtu 32 <target-ip>    # Larger fragments
```

### 3. Decoy IPs (`-D`)

Makes scan traffic **appear to originate from multiple IPs** simultaneously. Real source IP is mixed in with fake (decoy) IPs.

```bash
nmap -Pn -sS -F -D <decoy-ip-1>,<decoy-ip-2> <target-ip>

# Example — use gateway IPs as decoys
nmap -Pn -sS -F -D 10.10.23.1,10.10.23.2 <target-ip>
```

- Decoy IPs should be **live hosts** on the same network (otherwise suspicious)
- Use the **gateway IP** as a decoy — traffic from the router is plausible
- Responses always come back to **your real IP**, not the decoys

### 4. Data Length Padding (`--data-length <bytes>`)

Appends **random data** to sent packets — confuses signature-based IDS that match on specific packet sizes.

```bash
nmap -Pn -sS -F --data-length 200 <target-ip>
```

### 5. Source Port Spoofing (`-g` / `--source-port`)

Sets the **source port** of outgoing packets to look like legitimate traffic.

```bash
nmap -Pn -sS -F -g 53 <target-ip>     # Packets look like DNS traffic
nmap -Pn -sS -F -g 443 <target-ip>    # Packets look like HTTPS
```

### 6. TTL Manipulation (`--ttl <value>`)

Sets a custom **Time-To-Live** value — helps avoid IDS rules that trigger on TTL anomalies.

```bash
nmap -Pn -sS -F --ttl 64 <target-ip>
```

### 7. Disable DNS Resolution (`-n`)

Prevents Nmap from performing reverse DNS lookups — reduces noise and avoids detectable DNS queries.

```bash
nmap -Pn -sS -n <target-ip>
```

---

## Combined Evasion Command

```bash
nmap -Pn -sS -sV -F -f --data-length 200 -D <gw-ip-1>,<gw-ip-2> -g 53 --ttl 64 -n <target-ip>
```

| Flag | Purpose |
|---|---|
| `-Pn` | Skip host discovery |
| `-sS` | SYN (stealth) scan |
| `-sV` | Service version detection |
| `-F` | Fast scan (100 ports) |
| `-f` | Fragment packets into 8-byte chunks |
| `--data-length 200` | Pad packets with random data |
| `-D <ip1>,<ip2>` | Spoof scan from decoy IPs |
| `-g 53` | Source port = 53 (looks like DNS) |
| `--ttl 64` | Custom TTL |
| `-n` | Disable DNS resolution |

---

## Wireshark Observations

- **Without `-f`:** Full SYN packets visible — IDS can identify scan type from TCP flags
- **With `-f`:** Multiple small IP fragments per packet; `Fragment Offset = 0`, then `8`, etc.
- **With `-D`:** Source IP shows the **decoy IP**, not your real IP
- **With `-g 53`:** Source port shows `53` — traffic resembles DNS

---

## Key Takeaways

- ACK scan (`-sA`) = detects firewall presence, NOT open ports
- `filtered` state = firewall active; `closed` state = no firewall
- `-f` fragments packets at the IP layer — harder for IDS to inspect
- `-D` decoy IPs make attribution harder — use live hosts as decoys
- `-g 53` makes packets look like DNS traffic — can bypass loose firewall rules
- Always add `-n` in real engagements to reduce noise and scan time
