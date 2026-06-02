---
title: Active vs. Passive Reconnaissance
tags: [eJPT, Reconnaissance, Methodology]
created: 2026-03-30
source: Notion
---

# Active vs. Passive Reconnaissance

**Related:** [[Target-Scoping]] | [[Website-Recon]] | [[WHOIS-Enumeration]] | [[Active-Information-Gathering]] | [[00-INDEX]]

---

## Overview

Reconnaissance (information gathering) falls into two categories:

| | Passive | Active |
|---|---|---|
| **Direct interaction?** | No | Yes |
| **Detection risk** | Low | Higher |
| **When performed** | First | After passive |
| **Examples** | DNS records, WHOIS, Google Dorks | Nmap scan, dir brute-force, fuzzing |

---

## Passive Reconnaissance

Collecting information about a target **without directly interacting** with it.

**Characteristics:**
- No direct connection to target servers
- Lower risk of detection
- Uses publicly available information

**Examples of passive recon data:**
- Domain registration / WHOIS info
- DNS records
- Public website content
- Search engine results ([[Google-Dorks]])
- Publicly exposed email addresses ([[Email-Harvesting]])

---

## Active Reconnaissance

Direct interaction with the target or target systems — sending traffic to them.

**Characteristics:**
- Probes the target (e.g., sends packets)
- Increased visibility — logged by monitored systems
- Performed **after** passive recon

**Examples of active recon data:**
- Live hosts discovered ([[Host-Discovery-Techniques]])
- Open ports ([[Port-Scanning-Nmap]])
- Running services
- Network responses
- DNS zone transfer attempts ([[DNS-Reconnaissance]])

---

## Reconnaissance Strategy (4-Step)

1. **Define the target** — identify domain, IP, or network range; confirm what's in scope → [[Target-Scoping]]
2. **Passive recon** — gather public info, identify potential attack surfaces, build initial picture
3. **Active recon** — discover live hosts, open ports, exposed services → [[Active-Information-Gathering]]
4. **Document & organize** — record all findings; prep data for the enumeration phase

---

## What to Collect

Build a map of the target including:
- Domains and subdomains
- IP addresses
- Hosting infrastructure
- Technologies and services in use
- Open ports on target servers
- Publicly exposed information

---

## Common Beginner Mistakes

- Starting scans without defining scope first
- Skipping passive reconnaissance entirely
- Scanning everything instead of just relevant targets
- Not documenting results
- Trusting tool output without manual verification

---

## Key Takeaways

- **Passive recon always comes before active recon**
- Passive = no direct interaction; Active = direct interaction with target
- Goal of recon is to **build a map** of the target, not collect everything
- A structured 4-step approach improves accuracy and saves time
