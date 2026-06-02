---
title: Types of Security Audits
tags: [eJPT, AuditingFundamentals, SecurityAuditing, Compliance, AuditTypes]
created: 2026-04-14
source: Transcription
---

# Types of Security Audits

**Related:** [[Overview-of-Security-Auditing]] | [[Security-Auditing-and-Penetration-Testing]] | [[00-INDEX]]

---

## Overview

Security audits can be categorised based on **scope, methodology, and the aspects of the organisation** they focus on. Understanding these types helps penetration testers tailor their testing strategies effectively.

---

## Audit Types Reference Table

| Type | Objective | Importance | Example |
|------|-----------|-----------|---------|
| **Internal Audit** | Evaluate effectiveness of internal security controls and compliance with internal policies | Provides insight into self-assessment of security posture; highlights areas needing deeper testing | Review user access controls to ensure only authorised personnel access sensitive data |
| **External Audit** | Independent third-party evaluation providing unbiased assessment against external standards | Removes inherent bias; serves as benchmark for compliance and security effectiveness; pen testers use these findings to guide their testing | Company undergoing PCI DSS compliance audit via an external auditor |
| **Compliance Audit** | Verify adherence to specific regulatory requirements and industry standards | Identifies regulatory gaps that penetration tests can address through targeted testing | Healthcare provider undergoing HIPAA compliance audit to protect patient data |
| **Technical Audit** | Assess the technical aspects of IT infrastructure — hardware, software, network configurations | Provides detailed view of technical controls; highlights areas where penetration testing can uncover vulnerabilities | Thorough review of firewall configurations and server password policy enforcement |
| **Network Audit** | Assess the security of an organisation's network infrastructure (routers, switches, firewalls) | Reveals vulnerabilities in network design and configurations that pen testers can exploit | Identifying insecure protocols used for data transmission or default router passwords |
| **Application Audit** | Evaluate security of software applications — code quality, input validation, authentication, data handling | Highlights security flaws pen testers can exploit; closely resembles a web application pen test | Web application audit revealing SQL injection or XSS vulnerabilities |

---

## Key Distinctions

### Internal vs External
- **Internal audits** — performed by the organisation's own team; risk of inherent bias
- **External audits** — independent third-party; removes bias; more credible to regulators and clients

### Compliance vs Technical
- **Compliance audit** — evaluates adherence to regulations (PCI DSS, HIPAA, GDPR)
- **Technical audit** — evaluates the IT infrastructure itself against security benchmarks

### Network vs Application
- **Network audit** — focuses on perimeter, routing, switching, and network device security
- **Application audit** — focuses on code-level security (OWASP Top 10, mobile apps)

---

## Relation to Penetration Testing

Each audit type can **generate findings that feed directly into a pen test scope**:

| Audit Type | Likely Pen Test Follow-Up |
|------------|--------------------------|
| Compliance Audit (PCI DSS) | Test cardholder data environment, encryption, access controls |
| Technical Audit | Test identified misconfigurations, weak password policies |
| Network Audit | Test network device access, lateral movement paths |
| Application Audit | Web app pen test targeting identified SQLi/XSS/auth flaws |

> Penetration tests verify whether audit findings represent *real, exploitable* risks — turning theoretical policy gaps into demonstrated impact.

---

## Key Takeaways

- The naming of audit types is **not strictly standardised** — it varies by industry and region
- External audits > internal audits for unbiased compliance verification
- A compliance audit identifies *what* the gap is; a pen test proves *what happens* when that gap is exploited
- Application audits and web app pen tests have significant overlap — the pen test phase validates the audit findings in a practical, exploitable context
