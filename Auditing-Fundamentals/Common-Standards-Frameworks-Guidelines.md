---
title: Common Standards, Frameworks & Guidelines
tags: [eJPT, AuditingFundamentals, GRC, NIST, ISO27001, PCIDSS, HIPAA, GDPR, CIS, Compliance]
created: 2026-04-14
source: Transcription
---

# Common Standards, Frameworks & Guidelines

**Related:** [[GRC]] | [[Phase-1-Develop-a-Security-Policy]] | [[00-INDEX]]

---

## Framework vs Standard vs Guideline

| Type | Definition | Mandatory? | Examples |
|------|-----------|------------|---------|
| **Framework** | Structured approach to implementing security practices — flexible and adaptable | No | NIST CSF, COBIT |
| **Standard** | Specific requirements that must be met to achieve compliance | Yes (in regulated industries) | PCI DSS, ISO 27001 |
| **Guideline** | Recommended best practices and advice to improve security | No (best practice) | CIS Controls, NIST SP 800-53 |

---

## Frameworks

### NIST Cybersecurity Framework (NIST CSF)
- **By:** National Institute of Standards and Technology (NIST), USA
- **Purpose:** Guidelines and best practices to help organisations manage and reduce cybersecurity risk
- **Core Functions:**

| Function | Description |
|----------|-------------|
| **Identify** | Know your assets, risks, and environment |
| **Protect** | Implement controls to safeguard systems |
| **Detect** | Identify cybersecurity events |
| **Respond** | Take action against detected incidents |
| **Recover** | Restore capabilities after an incident |

### COBIT
- **Stands for:** Control Objectives for Information and Related Technologies
- **Purpose:** Framework for developing, implementing, monitoring, and improving IT governance and management
- **Key Focus:** Aligning IT goals with business objectives, managing IT risks, ensuring compliance

---

## Standards

### ISO/IEC 27001
- **Type:** International standard for Information Security Management Systems (ISMS)
- **Purpose:** Outlines best practices for managing and protecting sensitive information
- **Key Focus:** Establishing, implementing, maintaining, and continuously improving an ISMS
- **Who Uses It:** Any organisation wanting to demonstrate commitment to information security; commonly seen as a trust signal to customers/clients
- **Legal Requirement:** Not legally required, but certification is a competitive differentiator

### PCI DSS (Payment Card Industry Data Security Standard)
- **Purpose:** Protect payment card information and ensure secure processing of credit card transactions
- **Key Focus:** Protecting cardholder data, maintaining a secure network, implementing robust access controls
- **Legal Requirement:** **Mandatory** for any organisation that handles, stores, or processes credit card transactions
- **Relevance to Pen Testing:** Pen tests for PCI DSS clients must cover the cardholder data environment (CDE) — encryption, network segmentation, access controls

### HIPAA (Health Insurance Portability and Accountability Act)
- **Origin:** United States federal law
- **Purpose:** Set standards for protecting sensitive patient information (Protected Health Information — PHI)
- **Key Rules:**
  - **Privacy Rule** — protects PHI disclosure
  - **Security Rule** — safeguards for electronic PHI
  - **Breach Notification Rule** — required notification after data breaches
- **Legal Requirement:** Mandatory for all US healthcare providers, health plans, and organisations handling PHI (including DNA testing companies, health apps, etc.)

### GDPR (General Data Protection Regulation)
- **Origin:** European Union regulation
- **Purpose:** Governs data protection and privacy for individuals within the EU and European Economic Area (EEA)
- **Key Focus:** Data protection principles, rights of data subjects, obligations for data controllers and processors
- **Legal Requirement:** Required for **any** organisation that processes personal data of EU/EEA individuals — regardless of where the company is based
  - A US company with EU customers storing their data must comply with GDPR

---

## Guidelines

### CIS Controls (Center for Internet Security)
- **Purpose:** Set of best practices and actionable steps to improve cybersecurity posture
- **Structure:** Organised into control categories:
  - **Basic controls** — foundational hygiene (inventory, patching, secure configs)
  - **Foundational controls** — email protection, malware defences, data recovery
  - **Organisational controls** — security program, pen testing, incident response

### NIST SP 800-53
- **By:** NIST — National Institute of Standards and Technology
- **Full Name:** Security and Privacy Controls for Information Systems and Organizations (Revision 5 — 2020)
- **Purpose:** Comprehensive catalog of security and privacy controls for federal information systems
- **Legal Requirement:** Required for US federal agencies and organisations handling federal data
- **Broader Use:** Widely adopted as a baseline security framework — not just by government entities
- **How to Use:**
  - Download the control catalog spreadsheet from [csrc.nist.gov](https://csrc.nist.gov)
  - Each control has a **Control ID** (e.g., AC-2, IA-5) and policy text
  - Map your security policy statements to NIST SP 800-53 control IDs
- **Relevance to Pen Testing:** Security policies derived from NIST SP 800-53 define what an audit will check — and consequently, what the pen test will verify

---

## Quick Reference: Which Standard Applies to You?

| Organisation Type | Applicable Standard/Regulation |
|-------------------|-------------------------------|
| Processes credit card payments | PCI DSS |
| US healthcare provider | HIPAA |
| Has EU/EEA customers | GDPR |
| Wants ISMS certification | ISO 27001 |
| US federal agency / federal contractor | NIST SP 800-53 |
| Any organisation (best practice) | NIST CSF, CIS Controls |

---

## Key Takeaways

- **Framework** = flexible guidance; **Standard** = must comply; **Guideline** = recommended practice
- PCI DSS and HIPAA are **legally enforceable** — non-compliance carries heavy penalties
- GDPR applies **globally** if you process EU citizen data — not just to EU companies
- NIST SP 800-53 is the most comprehensive controls catalog — useful for building security policies regardless of industry
- As a pen tester, always identify which standards the client must comply with — your pen test scope and report format should reflect those requirements
