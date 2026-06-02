---
title: Overview of Security Auditing
tags: [eJPT, AuditingFundamentals, SecurityAuditing, Compliance, RiskManagement]
created: 2026-04-14
source: Transcription
---

# Overview of Security Auditing

**Related:** [[Essential-Terminology]] | [[Types-of-Security-Audits]] | [[Security-Auditing-and-Penetration-Testing]] | [[00-INDEX]]

---

## What is Security Auditing?

Security auditing is a **systematic process of evaluating and verifying the security measures and controls** in place within an organisation to ensure they are effective, appropriate, and compliant with relevant standards, policies, and regulations.

It involves reviewing:
- Information systems and networks
- Applications
- Operational procedures and policies
- Employee compliance with security policies

---

## Security Audit vs Penetration Test vs Vulnerability Assessment

| | Security Audit | Vulnerability Assessment | Penetration Test |
|--|---------------|------------------------|-----------------|
| **Focus** | Policies, processes, compliance | Technical vulnerabilities | Actively exploiting vulnerabilities |
| **Question** | "Are we compliant and following our own rules?" | "What vulnerabilities exist?" | "Can these vulnerabilities actually be exploited?" |
| **Output** | Gaps in policy/compliance + recommendations | List of vulnerabilities with severity | Proof of exploitation + impact |
| **Performed by** | Auditors (internal or external) | Security tools/analysts | Penetration testers |

> **Key insight:** A security audit starts at the lowest layer — the policies and processes the company defined themselves — and assesses whether they are actually being followed.

---

## Why Organisations Perform Security Audits

### 1. Identify Vulnerabilities and Weaknesses
- Uncovers weaknesses in systems and infrastructure that could be exploited
- Ensures security controls are **effective and up-to-date**

### 2. Ensure Compliance
Organisations must comply with regulatory requirements depending on their sector:
| Standard | Applies To |
|----------|-----------|
| **GDPR** | Any organisation processing EU/EEA personal data |
| **HIPAA** | US healthcare providers and health data handlers |
| **PCI DSS** | Any organisation processing credit card transactions |
| **ISO 27001** | Any organisation wanting ISMS certification |

Failing compliance can result in **serious legal and financial penalties**.

### 3. Enhance Risk Management
- Audits provide a comprehensive view of the organisation's security posture
- Allows risks to be **identified, quantified, and prioritised** based on potential impact
- Leads to effective risk mitigation strategies

### 4. Improve Security Policies and Procedures
- Regular audits identify gaps or loopholes in existing policies
- Keeps employees accountable — they know they will be audited
- Ensures policies evolve with the threat landscape

### 5. Support Business Objectives
- Strong security posture protects critical business operations from disruptions
- ISO 27001 or PCI DSS compliance certificates build **customer trust**
- Organisations advertise compliance as a trust signal

### 6. Continuous Improvement
- Security audits are not a one-time activity — they are a **cyclic, ongoing process**
- Regular audits ensure security measures evolve to address new threats
- Each audit cycle builds on the remediation from the previous one

---

## Key Takeaways

- Security auditing ≠ penetration testing — they have **different objectives, scope, and outcomes**
- Audits assess **compliance with policies** — pen tests assess **exploitability of vulnerabilities**
- A pen test can validate or disprove the theoretical risks identified in an audit report
- Large organisations almost always start with a security audit before commissioning a pen test
