---
title: Security Auditing Process / Lifecycle
tags: [eJPT, AuditingFundamentals, SecurityAuditing, AuditLifecycle, RiskAssessment, Remediation]
created: 2026-04-14
source: Transcription
---

# Security Auditing Process / Lifecycle

**Related:** [[Overview-of-Security-Auditing]] | [[Types-of-Security-Audits]] | [[Phase-1-Develop-a-Security-Policy]] | [[00-INDEX]]

---

## Overview

The security auditing process is **cyclic** — each audit builds on the remediation from the previous one, driving continuous improvement of the organisation's security posture.

---

## The 6 Phases

### Phase 1 — Planning & Preparation
Define what will be audited and assemble the team.

| Objective | Description |
|-----------|-------------|
| **Define objectives and scope** | Determine the goals of the audit and which systems, processes, and controls will be evaluated |
| **Gather documentation** | Collect policies, procedures, network diagrams, and previous audit reports |
| **Establish audit team** | Assemble internal audit team or engage an external audit firm |
| **Set schedule** | Create a timeline for audit activities |

---

### Phase 2 — Information Gathering
Understand the current state before assessing it.

| Objective | Description |
|-----------|-------------|
| **Review policies and procedures** | Examine security policies, procedures, and standards |
| **Conduct interviews** | Interview key personnel to understand security practices and identify gaps |
| **Collect technical information** | Gather data on system configurations, network architecture, and security controls |

> Interviews are critical — they reveal whether employees are actually following the defined security policies and whether policies are creating operational friction.

---

### Phase 3 — Risk Assessment
Identify and prioritise threats before executing the audit.

| Objective | Description |
|-----------|-------------|
| **Identify assets and threats** | List critical assets (systems, data, personnel) and potential threats |
| **Evaluate vulnerabilities** | Assess pre-existing vulnerabilities in systems and processes |
| **Determine risk levels** | Assign risk ratings based on Likelihood × Impact |

**Example:** Unencrypted employee laptops taken home → threat of data exposure → high likelihood × high impact = critical risk finding.

---

### Phase 4 — Audit Execution
Perform the actual assessment work.

| Objective | Description |
|-----------|-------------|
| **Technical testing** | Conduct vulnerability scans, penetration tests (if in scope), and configuration reviews |
| **Compliance verification** | Check adherence to relevant regulatory requirements and standards |
| **Evaluate controls** | Assess the effectiveness of existing security controls and practices |

> This is where pen testers come in if included in scope — to technically validate findings.

---

### Phase 5 — Analysis & Evaluation
Make sense of what was found.

| Objective | Description |
|-----------|-------------|
| **Analyse findings** | Review collected data to identify security weaknesses and improvement areas |
| **Compare against standards** | Measure the organisation's posture against industry standards (NIST, ISO 27001, etc.) |
| **Prioritise issues** | Rank findings by severity and potential impact — similar to CVSS scoring in pen tests |

---

### Phase 6 — Reporting
Document findings and communicate to stakeholders.

| Objective | Description |
|-----------|-------------|
| **Document findings** | Create a detailed report — vulnerabilities, non-compliance issues, ineffective controls |
| **Provide recommendations** | Offer actionable steps to address each finding |
| **Present results** | Share findings with relevant stakeholders and decision-makers |

---

### Phase 7 — Remediation
Act on the findings to improve security.

| Objective | Description |
|-----------|-------------|
| **Develop remediation plan** | Create a structured plan to address audit findings |
| **Implement changes** | Apply recommended improvements |
| **Conduct follow-up audits** | Schedule the next audit cycle to verify remediation was effective |
| **Monitor and update** | Continuously monitor security posture and update measures as needed |

---

## The Audit Lifecycle (Compressed View)

```
Planning & Preparation
        ↓
Information Gathering
        ↓
Risk Assessment
        ↓
Audit Execution
        ↓
Analysis & Reporting
        ↓
Remediation
        ↓
← Next Audit Cycle (picks up from here)
```

> Each cycle begins where the last one ended — continuous, iterative improvement.

---

## Audit Process vs Pen Test Process

| Phase | Security Audit | Pen Test Equivalent |
|-------|---------------|---------------------|
| Planning | Define scope and objectives | Scoping call, Rules of Engagement |
| Information Gathering | Document review, interviews | OSINT, passive recon |
| Risk Assessment | Asset/threat identification | Vulnerability assessment |
| Execution | Compliance checks, config review | Active exploitation |
| Analysis | Measure against standards | Exploit impact assessment |
| Reporting | Gaps + compliance recommendations | PoC + technical remediation guidance |
| Remediation | Fix policies, controls, configs | Patch systems, retest |

---

## Key Takeaways

- Security auditing is a **process, not an event** — the lifecycle is continuous
- Interviews during information gathering are just as important as technical testing
- Risk assessment uses **Likelihood × Impact** to prioritise — same logic as CVSS
- The audit report is the foundation for the pen test scope in the sequential approach
- Remediation + follow-up audit = the actual security improvement loop
