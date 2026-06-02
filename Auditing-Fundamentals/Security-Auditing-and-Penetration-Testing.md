---
title: Security Auditing and Penetration Testing
tags: [eJPT, AuditingFundamentals, SecurityAuditing, PenetrationTesting, Sequential, PCI-DSS]
created: 2026-04-14
source: Transcription
---

# Security Auditing and Penetration Testing

**Related:** [[Types-of-Security-Audits]] | [[GRC]] | [[Overview-of-Security-Auditing]] | [[00-INDEX]]

---

## The Link Between Audits and Pen Tests

Security audits and penetration tests are **two separate assessments** with different objectives, scope, and outcomes. Understanding the distinction — and the relationship — is critical for any penetration tester.

---

## Comparison Table

| Factor | Security Audit | Penetration Test |
|--------|---------------|-----------------|
| **Purpose** | Evaluate overall security posture; assess compliance with policies, standards, regulations | Simulate real-world attacks; identify and exploit technical vulnerabilities |
| **Scope** | Comprehensive — policies, procedures, technical controls, physical security, compliance | Specific — defined systems, networks, or applications |
| **Methodology** | Review documentation, conduct interviews, technical assessments, compliance checks | Use tools and techniques to actively breach systems and assess security defences |
| **Outcome** | Identify gaps in policies/procedures/controls; recommendations for compliance | Detailed list of exploitable vulnerabilities; targeted remediation recommendations |
| **Frequency** | Regular schedule — annually, biennially, or as required by compliance regulations | As needed — post-change, regularly scheduled, or per compliance requirement |

---

## Approaches: How They Work Together

### Sequential Approach (Most Common)

1. **Security audit first** — evaluate overall posture, compliance gaps, policy deficiencies
2. **Penetration test second** — driven by audit findings:
   - **Pre-remediation:** Pen test assigns real risk/impact to the audit findings
   - **Post-remediation:** Pen test verifies whether the remediations actually work

**Advantages:**
- Covers both policy/procedural and technical perspectives
- Audit findings prioritise what the pen test should focus on
- Cost-efficient: audit defines the scope so the pen test is targeted

### Combined / Hybrid Approach (Less Common)

The pen testing firm performs both the audit and the pen test in a single engagement.

**Advantages:**
- Streamlines the process — one engagement, one deliverable
- More complete picture of security posture
- More cost-efficient for organisations

**When to avoid:** If the pen testing team lacks audit expertise or compliance knowledge, do not take on a compliance audit. Stick to what you know.

---

## Case Study: Secure Payments Incorporated (PCI DSS)

**Scenario:** Fictional company processing credit card transactions — must comply with PCI DSS.

### Audit Findings (External Auditor)
- Inadequate encryption for cardholder data in transit
- Weak network security controls and traffic monitoring
- Weak access control policies — excessive permissions granted
- Outdated incident response procedures

### Audit Recommendations
- Implement strong encryption protocols for data in transit
- Revise access control policies to follow least privilege
- Update and test incident response procedures regularly

> The company performed remediation — now they've hired you (pen tester) to **verify that the remediations work**.

### Pen Test Phases (Sequential Approach)

**Phase 1 — Planning & Preparation**
- Identify PCI DSS scope: cardholder data environment (CDE)
- Review network diagrams and PCI DSS Self-Assessment Questionnaire (SAQ)
- Define pen test scope — focus on areas from the audit (network, application)

**Phase 2 — Information Gathering & Recon**
- Gather info on access control policies, encryption standards, incident response procedures
- Review the most recent PCI DSS audit report

**Phase 3 — Execution**
- Network scanning, enumeration, vulnerability assessment
- Attempt to exploit identified vulnerabilities to assess impact
- Test effectiveness of newly implemented encryption and access controls

**Phase 4 — Findings & Recommendations**

| Finding | Recommendation |
|---------|---------------|
| Exposed admin interface allowing unauthorised access | Secure with additional authentication and access controls |
| SQL injection in customer-facing web application | Patch SQL injection and conduct thorough application security review |

---

## Summary

| | Security Audit | Penetration Test |
|--|----------------|-----------------|
| **Reveals** | Compliance gaps and policy deficiencies | Specific, exploitable technical vulnerabilities |
| **Provides** | Recommendations to improve policies/procedures | Targeted, actionable recommendations to fix technical weaknesses |

---

## Key Takeaways

- Audits and pen tests are **not the same** — never combine or confuse them
- The **audit report defines the pen test scope** — in the sequential approach
- Pen tests take vague audit findings ("inadequate encryption") and make them concrete ("here is the exact endpoint that is vulnerable and here is the exploit")
- As a pen tester you'll often be working from an audit report you didn't produce — reading and interpreting audit reports is a real-world skill
- Large organisations almost always audit first, then pen test
