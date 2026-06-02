---
title: Phase 2 — Security Auditing with Lynis
tags: [eJPT, AuditingFundamentals, Lynis, SecurityAudit, Linux, Hardening, ClamAV, RKHunter, Practical]
created: 2026-04-14
source: Transcription
---

# Phase 2 — Security Auditing with Lynis

**Related:** [[Phase-1-Develop-a-Security-Policy]] | [[Phase-3-Conduct-Penetration-Test]] | [[00-INDEX]]

---

## Context

Phase 2 of the practical lifecycle. We're now acting as the **security auditor** — using Lynis to perform a baseline security audit of the Linux server against the policy defined in Phase 1.

| Phase | Role | Action |
|-------|------|--------|
| Phase 1 | Sysadmin | Defined security policy aligned with NIST SP 800-53 |
| **Phase 2** | **Security Auditor** | **Audit the server with Lynis; identify findings; remediate** |
| Phase 3 | Pen Tester | Validate remediations through a penetration test |

---

## What is Lynis?

**Lynis** is a battle-tested, open-source security auditing tool for Linux, macOS, and Unix-based systems.

- **Website:** cisofy.com/lynis
- **License:** GPL (open source, available since 2007)
- **Purpose:** Extensive health scan to support system hardening and compliance testing

### Use Cases
| Use Case | Description |
|----------|-------------|
| **Security Auditing** | Baseline assessment of a system's security posture |
| **Compliance Testing** | Check adherence to standards and frameworks |
| **Vulnerability Detection** | Identify missing patches, weak configs, and security gaps |
| **System Hardening** | Remediate findings to reduce attack surface |
| **Penetration Testing** | Can also be used in pen test mode |

---

## Installation

### Method 1: Tarball (Latest Version — Recommended)
```bash
# Download from cisofy.com/lynis or direct link
wget https://cisofy.com/files/lynis-<version>.tar.gz

# Extract
tar -xzf lynis-<version>.tar.gz

# Make executable
chmod +x lynis/lynis

cd lynis/
```

### Method 2: Package Manager (Older Version)
```bash
sudo apt install lynis
```

---

## Running Lynis

### Full System Audit
```bash
./lynis audit system
```

### Audit with Auditor Name (for Report Attribution)
```bash
./lynis audit system --auditor "Alexis"
```

### Quiet Mode (No Screen Output)
```bash
./lynis audit system --quiet
```

### Quick Mode (Skip Confirmation Prompts)
```bash
./lynis audit system --quick
```

### Run Specific Control IDs Only
```bash
./lynis audit system --tests "MALW-3280"
./lynis audit system --tests "AUTH-9228,LOGG-2130"
```

---

## Understanding the Lynis Report

After a scan completes, Lynis displays a **summary** and saves a report.

### Summary Fields
| Field | Description |
|-------|-------------|
| **Hardening Index** | Score out of 100 (e.g., 59/100) — higher is better |
| **Tests Performed** | Total number of checks run |
| **Warnings** | Issues requiring immediate attention |
| **Suggestions** | Recommendations to improve security |

### Report File Location
```
/var/log/lynis-report.dat    # Report data
/var/log/lynis.log           # Full audit log
```

### Interpreting Results

The scan output is divided into sections. For each finding you'll see:
- **Control ID** (e.g., `SSH-7408`) — searchable on cisofy.com for remediation guidance
- **Warning** — critical issues to address immediately
- **Suggestion** — recommended improvements

---

## Mapping Policy to Lynis Controls

After defining the security policy (Phase 1), identify the corresponding Lynis Control IDs:

| Policy Statement | Lynis Control ID |
|-----------------|-----------------|
| Malware protection — install AV scanner | `MALW-3280` |
| SSH configuration hardening | `SSH-7408` |
| Password expiry dates | `AUTH-9228` |
| Log review / syslog | `LOGG-2130` |
| Permit root login disabled | `SSH-7412` |

> Navigate to **cisofy.com/lynis/controls/** to browse all controls and find the IDs relevant to your policy.

---

## Example Findings from a Fresh Ubuntu Server

After running `./lynis audit system` on a default Ubuntu 22.04 system (Hardening Index: 59/100):

### Warnings
- Vulnerable packages detected — outdated software
- No malware scanner installed (`MALW-3280`)

### SSH-Related Suggestions
```
SSH-7408  AllowTcpForwarding — change from yes to no
SSH-7412  PermitRootLogin — disable root SSH login
SSH-7414  MaxSessions — reduce maximum allowed sessions
SSH-7440  Change default SSH port from 22
```

### Authentication Suggestions
```
AUTH-9228  No password expiry dates set for user accounts
```

---

## Remediation Examples

### Installing a Malware Scanner (ClamAV + RKHunter)

Lynis control `MALW-3280` checks for the presence of a malware/rootkit scanner.

```bash
# Install ClamAV
sudo apt update && sudo apt install -y clamav

# Install RKHunter (rootkit scanner)
sudo apt install -y rkhunter

# Install CHKRootkit
sudo apt install -y chkrootkit
```

After installation, re-run the audit to verify the finding is resolved.

### Disabling Password-Based SSH / Root Login
```bash
sudo nano /etc/ssh/sshd_config
```

Edit the following settings:
```
PermitRootLogin no
PasswordAuthentication no
Port 2222          # Change default port
AllowTcpForwarding no
MaxSessions 2
```

```bash
sudo systemctl restart sshd
```

### Enforcing Password Expiry
```bash
# Set password expiry for a user (90-day max)
sudo chage -M 90 username

# Check current settings
sudo chage -l username
```

---

## After the Audit: What Goes into the Report?

The Lynis audit produces findings that become the **basis for Phase 3 (pen test)**:

| Lynis Finding | Pen Test Action |
|---------------|----------------|
| Password-based SSH enabled | Brute-force SSH (Hydra) to verify password strength |
| Root login permitted | Attempt root brute-force |
| No rate limiting (fail2ban) | Test for lockout / throttling controls |
| Malware scanner missing | Verify detection capability of the system |

---

## Key Takeaways

- Lynis is the standard tool for **automated Linux security auditing**
- The hardening index score gives a quick snapshot of overall security posture
- Always run Lynis **before** defining remediation actions — let the tool identify the gaps
- Map Lynis Control IDs to your security policy items for a structured audit
- Lynis findings define the **scope of the pen test** in the sequential approach
- The remediation cycle: Audit → Find → Fix → Audit again (continuous improvement)
