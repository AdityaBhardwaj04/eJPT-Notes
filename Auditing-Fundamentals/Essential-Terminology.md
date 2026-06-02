---
title: Essential Security Auditing Terminology
tags: [eJPT, AuditingFundamentals, Terminology, SecurityPolicy, Compliance, AuditReport]
created: 2026-04-14
source: Transcription
---

# Essential Security Auditing Terminology

**Related:** [[Overview-of-Security-Auditing]] | [[GRC]] | [[00-INDEX]]

---

## Key Terms Reference Table

| Term | Definition | Importance |
|------|-----------|-----------|
| **Security Policy** | A formal document defining an organisation's security objectives, guidelines, and procedures to protect information assets | Establishes the framework for implementing and enforcing security controls |
| **Compliance** | Adherence to regulatory requirements, industry standards, and internal policies related to security and data protection | Ensures the organisation meets legal obligations and best practices |
| **Vulnerability** | A weakness in a system **or process** that can be exploited to gain unauthorised access or cause harm | Identifying vulnerabilities is crucial for assessing and improving security measures |
| **Control** | A safeguard or countermeasure implemented to mitigate risks and protect information assets | Controls are designed to prevent, detect, or respond to security threats |
| **Risk Assessment** | The process of identifying, analysing, and evaluating risks to an organisation's information assets | Helps prioritise security measures based on the likelihood and impact of identified risks |
| **Audit Trail** | A chronological record of events and activities providing evidence of actions taken within a system | Supports accountability and traceability during security audits and investigations |
| **Compliance Audit** | An examination of an organisation's adherence to regulatory requirements and industry standards | Validates whether the organisation meets necessary compliance criteria and identifies areas for improvement |
| **Access Control** | Measures and mechanisms regulating who can access specific information or systems and what actions they can perform | Protects sensitive information from unauthorised access and misuse |
| **Audit Report** | A formal document presenting the findings, conclusions, and recommendations from a security audit | Communicates audit results and provides guidance for improving security practices |

---

## Expanding on Key Terms

### Security Policy
- The **foundation** of a security audit — the audit checks whether the organisation is following its own policy
- Covers areas like: password policy, access control, data retention, incident response, acceptable use
- Referenced against frameworks like **NIST SP 800-53** for control IDs

### Control
The security world uses "controls" to describe any security measure. Categories:
- **Preventive** — stop an incident from occurring (firewalls, access control)
- **Detective** — identify incidents (IDS, logging, audit trails)
- **Corrective** — respond and recover (patch management, incident response)

### Risk Assessment
Two key dimensions:
- **Likelihood** — how probable is this risk occurring?
- **Impact** — how severe would the damage be?

Risk = Likelihood × Impact

### Audit Report vs Pen Test Report

| | Audit Report | Pen Test Report |
|--|-------------|----------------|
| **Findings** | Gaps in policy/compliance | Exploitable vulnerabilities with PoC |
| **Recommendations** | Broad — "improve encryption" | Specific — "patch CVE-XXXX in service X" |
| **Tone** | Compliance-focused | Technical-focused |

---

## Key Takeaways

- The word **"control"** appears throughout security documentation — it just means a security measure
- **Audit trail** = logs — essential for accountability and post-incident investigation
- An audit report looks similar to a pen test report structurally, but the findings are policy/compliance-based, not exploitation-based
