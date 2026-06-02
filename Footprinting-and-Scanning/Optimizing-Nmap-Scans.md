---
title: Optimizing Nmap Scans – Timing & Performance
tags: [eJPT, Nmap, TimingTemplates, ScanDelay, HostTimeout, IDSEvasion, Performance]
created: 2026-04-04
source: Notion
---

# Optimizing Nmap Scans – Timing & Performance

**Related:** [[Port-Scanning-Nmap-InDepth]] | [[Firewall-Detection-IDS-Evasion]] | [[Nmap-Output-Formats]] | [[00-INDEX]]

---

## Overview

Nmap's timing and performance options control **how fast or slow** scans run, serving two distinct purposes:

1. **Speed up scans** — reduce time on large networks or fast environments
2. **Slow down scans** — evade IDS detection, avoid overwhelming hardware, reduce noise

---

## Timing Templates (`-T0` to `-T5`)

| Template | Nickname | Use Case |
|---|---|---|
| `-T0` | Paranoid | Maximum stealth — IDS evasion, extremely slow |
| `-T1` | Sneaky | IDS evasion — slow, low packet rate |
| `-T2` | Polite | Reduces load on the network |
| `-T3` | Normal | **Default** — used when no `-T` flag is specified |
| `-T4` | Aggressive | Faster scans — assumes a reliable, fast network |
| `-T5` | Insane | Maximum speed — may sacrifice some accuracy |

```bash
nmap -Pn -sS -F -T1 <target-ip>   # Sneaky — slow, stealthy
nmap -Pn -sS -F -T3 <target-ip>   # Normal — default
nmap -Pn -sS -F -T4 <target-ip>   # Aggressive — fast
```

> **General rule:** Use **T4** on fast, reliable networks. Stick with **T3** for balanced accuracy. Use **T1** or lower when evading IDS.

### What it looks like in Wireshark
- **T1 (Sneaky):** Packets are spaced far apart — hard to distinguish from normal traffic
- **T4 (Aggressive):** Packets flood in nearly simultaneously — obviously a scan

---

## Scan Delay (`--scan-delay`)

Sets a **fixed delay between each probe packet** — the most precise way to control packet spacing for stealth.

```bash
nmap -Pn -sS -F --scan-delay 5s <target-ip>     # 5-second gap
nmap -Pn -sS -F --scan-delay 15s <target-ip>    # 15-second gap (very stealthy)
nmap -Pn -sS -F --scan-delay 500ms <target-ip>  # 500ms gap
```

> **Recommended for stealth:** `--scan-delay 15s` combined with fragmentation and decoys → [[Firewall-Detection-IDS-Evasion]]

**Trade-off:** Slower sending = slower scan completion.

---

## Host Timeout (`--host-timeout`)

Tells Nmap to **give up on a host** if it doesn't complete within the specified time. Useful for large subnets with unresponsive hosts.

```bash
nmap -Pn -sS -F --host-timeout 30s <target-subnet>/24
nmap -Pn -sS -F --host-timeout 5s <target-ip>/24     # Aggressive — skip after 5s
```

**Time units:** `30s`, `5m`, `2h`

**Lab result:**
- Full service scan on a subnet: **45.63 seconds** without timeout
- Same scan with `--host-timeout 5s`: **14.40 seconds** — same hosts discovered

> **Recommended:** `--host-timeout 30s` on large networks.

---

## Min/Max Rate (`--min-rate`, `--max-rate`)

```bash
nmap -Pn -sS --min-rate 1000 <target-ip>    # At least 1000 packets/sec
nmap -Pn -sS --max-rate 100 <target-ip>     # No more than 100 packets/sec
```

> Generally not recommended — timing templates and scan delay are more predictable.

---

## Quick Reference

| Option | Purpose | Example |
|---|---|---|
| `-T0` / `-T1` | Stealth / IDS evasion | `-T1` |
| `-T3` | Default — balanced | (automatic) |
| `-T4` | Fast scan on reliable network | `-T4` |
| `--scan-delay` | Fixed gap between packets | `--scan-delay 15s` |
| `--host-timeout` | Skip slow/unresponsive hosts | `--host-timeout 30s` |
| `--min-rate` / `--max-rate` | Control packets per second | `--min-rate 1000` |

---

## Combining Options

**For maximum stealth:**
```bash
nmap -Pn -sS -F -T1 --scan-delay 15s -f -D <decoy-ip-1>,<decoy-ip-2> -g 53 -n <target-ip>
```

**For speed on a trusted internal network:**
```bash
nmap -Pn -sS -sV -p- -T4 <target-ip>
```

**For large network sweeps:**
```bash
nmap -Pn -sS -F -T4 --host-timeout 30s <target-subnet>/24
```

---

## Key Takeaways

- Timing templates affect much more than packet speed — they also tune retransmission timeouts, parallelism, and probe delays
- When stealth is the goal: **T1 + scan-delay + fragmentation + decoys** is the most effective combination
- `--host-timeout` is critical for large subnet scans — prevents one slow host from blocking the rest
