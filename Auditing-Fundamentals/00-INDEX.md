---
title: Auditing Fundamentals — Section Index
tags: [eJPT, AuditingFundamentals, Index, SecurityAuditing, GRC, Compliance]
created: 2026-04-14
source: Transcription
---

# Auditing Fundamentals

Security auditing from a penetration tester's perspective — understanding what audits are, how they differ from pen tests, and how audit findings shape the scope and objectives of a penetration test.

**Instructor:** Alexis Ahmed — Senior Penetration Tester at HackerSploit, Red Team Instructor at INE.

→ [[00-INDEX]] (Master Index)

---

## Notes

| Note | Summary |
|------|---------|
| [[Course-Introduction]] | Course overview, learning objectives, why auditing matters for pen testers |
| [[Overview-of-Security-Auditing]] | Definition, audit vs pen test vs VA, 6 reasons organisations audit |
| [[Essential-Terminology]] | Security policy, control, compliance, risk assessment, audit trail, audit report |
| [[Types-of-Security-Audits]] | Internal, external, compliance, technical, network, application audits |
| [[Security-Auditing-Process-Lifecycle]] | 6-phase audit lifecycle: planning → info gathering → risk assessment → execution → analysis → reporting → remediation |
| [[Security-Auditing-and-Penetration-Testing]] | Differences, sequential approach, combined approach, Secure Payments Inc. case study |
| [[GRC]] | Governance, Risk & Compliance — components, importance for pen testers |
| [[Common-Standards-Frameworks-Guidelines]] | NIST CSF, COBIT, ISO 27001, PCI DSS, HIPAA, GDPR, CIS Controls, NIST SP 800-53 |
| [[Phase-1-Develop-a-Security-Policy]] | NIST SP 800-53 controls, SecureTech Solutions example, Linux server security policy |
| [[Phase-2-Security-Auditing-with-Lynis]] | Lynis install, run, interpret results, control IDs, ClamAV/RKHunter remediation |
| [[Phase-3-Conduct-Penetration-Test]] | Hydra SSH brute-force, validate remediation, audit-to-pen-test lifecycle complete |

---

## Core Concepts

### The Central Distinction

| | Security Audit | Penetration Test |
|--|----------------|-----------------|
| **Focus** | Compliance, policies, processes | Technical exploitation |
| **Output** | Gaps + compliance recommendations | PoC exploits + technical fixes |
| **When** | First (defines the pen test scope) | Second (validates/extends audit findings) |

### Key Compliance Standards

| Standard | Applies To |
|----------|-----------|
| **PCI DSS** | Any org processing credit card transactions |
| **HIPAA** | US healthcare providers and PHI handlers |
| **GDPR** | Any org processing EU/EEA personal data |
| **ISO 27001** | Any org wanting ISMS certification |
| **NIST SP 800-53** | US federal agencies; widely used as baseline |

### The Practical Lifecycle (Phases 1-3)

```
Phase 1: Develop Security Policy (NIST SP 800-53)
        ↓
Phase 2: Security Audit with Lynis
        ↓
Phase 3: Penetration Test (Hydra, SSH brute-force)
```

---

## Quick Reference

### Lynis Commands
```bash
./lynis audit system                         # Full audit
./lynis audit system --auditor "Name"        # With auditor attribution
./lynis audit system --tests "MALW-3280"     # Specific control only
./lynis audit system --quiet                 # No screen output
```

### Key Lynis Control IDs
| Control ID | Check |
|-----------|-------|
| `MALW-3280` | Presence of malware/rootkit scanner |
| `SSH-7408` | SSH AllowTcpForwarding |
| `SSH-7412` | SSH PermitRootLogin |
| `AUTH-9228` | Password expiry dates |
