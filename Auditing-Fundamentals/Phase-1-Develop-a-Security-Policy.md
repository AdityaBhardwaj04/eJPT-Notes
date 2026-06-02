---
title: Phase 1 — Develop a Security Policy (NIST SP 800-53)
tags: [eJPT, AuditingFundamentals, SecurityPolicy, NIST, SP800-53, Linux, Practical]
created: 2026-04-14
source: Transcription
---

# Phase 1 — Develop a Security Policy (NIST SP 800-53)

**Related:** [[Common-Standards-Frameworks-Guidelines]] | [[Phase-2-Security-Auditing-with-Lynis]] | [[Phase-3-Conduct-Penetration-Test]] | [[00-INDEX]]

---

## Context: The Practical Lifecycle

This note covers **Phase 1** of a three-part practical demonstration of the full audit → pen test lifecycle:

| Phase | Role | Action |
|-------|------|--------|
| **Phase 1** | Linux Sysadmin | Develop security policy aligned with NIST SP 800-53 |
| **Phase 2** | Security Auditor | Audit the Linux server using Lynis |
| **Phase 3** | Penetration Tester | Pen test based on the audit findings |

**Fictional company:** SecureTech Solutions — a cybersecurity consultancy securing IT infrastructure for clients.

---

## Objective

Establish a **baseline security policy for Linux servers** aligned with NIST SP 800-53 guidelines.

The policy should:
- Protect servers from unauthorised access, vulnerabilities, and security threats
- Establish baseline requirements for configuring, maintaining, and monitoring Linux servers
- Serve as the baseline for the subsequent security audit

---

## NIST SP 800-53 Primer

- **Full name:** Security and Privacy Controls for Information Systems and Organizations (Rev. 5, 2020)
- **Published by:** NIST (National Institute of Standards and Technology)
- **Download:** csrc.nist.gov — PDF + control catalog spreadsheet
- **Structure:** Security controls grouped into control families (e.g., Access Control = AC, Audit & Accountability = AU)
- Each control has a **Control ID** (e.g., AC-2, IA-5) mapping to a specific security requirement

---

## SecureTech Solutions — Linux Server Security Policy

### Policy Area: Access Control

| Control ID | Policy Statement |
|-----------|-----------------|
| **AC-2** (Account Management) | Only authorised personnel shall be granted server access. Each user must have a unique account. Shared accounts are prohibited. Inactive accounts must be disabled or removed within 30 days. |
| **AC-5** (Separation of Duties) | Privileged accounts must be separate from standard user accounts. No single user shall have unrestricted access to all server functions. |

### Policy Area: Authentication

| Control ID | Policy Statement |
|-----------|-----------------|
| **IA-5** (Authenticator Management) | Enforce strong password policy: minimum 12 characters, including uppercase/lowercase, numbers, and special characters. Utilise SSH key-based authentication. Disable password-based SSH access. Implement 2FA for privileged accounts. |

### Policy Area: Audit & Accountability

| Control ID | Policy Statement |
|-----------|-----------------|
| **AU-2** (Event Logging) | Enable and configure system logging to capture critical events. Use syslog or journald for centralised logging. |
| **AU-6** (Audit Review) | Regularly review logs for suspicious activities. Retain logs for a minimum of 90 days. |

### Policy Area: Configuration Management

| Control ID | Policy Statement |
|-----------|-----------------|
| **CM-6** (Configuration Settings) | Maintain a secure baseline configuration for all Linux servers. Utilise configuration management tools (Ansible, Puppet) to enforce configurations. |
| **CM-7** (Software Updates) | Keep systems and installed software up to date. Apply security patches within 30 days of release. |

### Policy Area: Identification & Authentication

| Control ID | Policy Statement |
|-----------|-----------------|
| **IA-5** (Password Management) | Enforce password complexity and expiration policies. Utilise password managers to securely store and manage passwords. |
| **IA-2** (User Identification) | Ensure all users are uniquely identified — user accounts must be tied to a specific individual for accountability and non-repudiation. |

### Policy Area: System & Information Integrity

| Control ID | Policy Statement |
|-----------|-----------------|
| **SI-3** (Malware Protection) | Implement malware detection and prevention measures. Regularly scan servers for malware. |
| **SI-4** (Security Monitoring) | Monitor systems for security breaches and anomalies. Utilise tools like **Lynis** to perform regular security audits. |

### Policy Area: Maintenance

| Control ID | Policy Statement |
|-----------|-----------------|
| **MA-2** (Maintenance) | Perform regular maintenance on servers according to documented procedures. |
| **MA-3** (Maintenance Tools) | Use only approved maintenance tools and ensure they are secure and up to date. |

---

## Requirements Gathering Process

When developing any security policy, start with requirements gathering:

1. **Define purpose and scope** — what systems does the policy cover?
2. **Identify control families** — which NIST SP 800-53 families are relevant? (Access Control, Audit, Config Management, etc.)
3. **Map policy statements to Control IDs** — each statement should reference a specific control
4. **Define enforcement mechanisms** — tools, processes, and procedures that will operationalise the policy

---

## Key Takeaways

- A security policy is the **starting point** — everything else (audits, pen tests) flows from it
- NIST SP 800-53 is the practical guideline for building Linux/server security policies
- Each policy area maps to **Control IDs** — these same IDs are referenced by audit tools like Lynis
- A good policy covers: access control, authentication, logging, configuration management, integrity monitoring, and maintenance
- The policy is **not a one-time document** — it evolves with each audit/pen test cycle
