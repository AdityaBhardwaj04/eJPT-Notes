---
title: Target Scoping
tags: [eJPT, Reconnaissance, Methodology]
created: 2026-03-30
source: Notion
---

# Target Scoping

**Related:** [[Active-vs-Passive-Recon]] | [[00-INDEX]]

---

## What is Target Scoping?

Target scoping is the process of **defining exactly what systems, networks, or applications** a penetration tester is authorized to test.

- Defined in the **Letter of Engagement (LOE)** and **Rules of Engagement (ROE)**
- Scope is **legally binding** — testing out-of-scope targets can result in legal liability
- Applies throughout all phases of a pentest, but is especially relevant during **information gathering**

---

## Types of Targets

### Domain-Based
- Primary domain: `example.com`
- Subdomains: `mail.example.com`, `admin.example.com`
- Subdomains may be **in-scope or out-of-scope independently**

### IP-Based
- Single IP address (specific host)
- Network range / CIDR block (e.g., `192.168.1.0/24`)
- Common in internal, lab, and cloud environments

### Application-Based
- Specific web application
- Mobile application
- Login portal or API endpoint
- Recon focuses **only** on that application — not the full server

---

## In-Scope vs. Out-of-Scope

| | Definition |
|---|---|
| **In-Scope** | Assets you are authorized to scan, collect info from, and enumerate |
| **Out-of-Scope** | Assets you must NOT interact with |

**Common out-of-scope examples:**
- Third-party services (e.g., payment processors, CDNs)
- External domains not listed in the engagement
- Systems owned by other organizations

---

## Why Scoping Matters

- Prevents wasting time on irrelevant hosts
- Keeps reconnaissance **focused, efficient, and legally compliant**
- Avoids noisy, confusing results
- Without clear scope: risk of testing the wrong target or causing unintended damage

---

## Key Takeaways

- **Target scoping defines what you're allowed to test** — always confirm before starting
- Scope is laid out in the **Rules of Engagement** and is **legally binding**
- In the context of recon: scope answers *"What am I allowed to collect information about?"*
- A well-defined scope keeps your work relevant to later pentest phases
