---
title: Phase 3 — Conduct Penetration Test (Audit to Pen Test)
tags: [eJPT, AuditingFundamentals, PenetrationTesting, Hydra, SSH, BruteForce, Remediation, Practical]
created: 2026-04-14
source: Transcription
---

# Phase 3 — Conduct Penetration Test (Audit to Pen Test)

**Related:** [[Phase-2-Security-Auditing-with-Lynis]] | [[Phase-1-Develop-a-Security-Policy]] | [[Security-Auditing-and-Penetration-Testing]] | [[00-INDEX]]

---

## Context

This is the **final phase** of the practical audit → pen test lifecycle. We now switch roles from auditor to penetration tester, using the Lynis audit findings to define our scope.

| Phase | Role | Action |
|-------|------|--------|
| Phase 1 | Sysadmin | Defined security policy (NIST SP 800-53) |
| Phase 2 | Security Auditor | Audited server with Lynis; performed some remediation |
| **Phase 3** | **Penetration Tester** | **Validate remediation effectiveness; test policy items** |

---

## Objective

**Validate the effectiveness of remediation actions** through a penetration test — ensuring the Linux server is secure and compliant with the security policy defined in Phase 1.

Two possible scenarios:
1. **Pre-remediation pen test:** Assign actual risk and impact to the audit findings
2. **Post-remediation pen test:** Verify that the remediations actually fixed the identified issues

---

## Scope

Scope is derived directly from the Lynis audit report and the security policy:

| Policy Item | Test |
|-------------|------|
| Password-based SSH authentication | Is password-based auth enabled? Can it be brute-forced? |
| Root login via SSH | Is root login permitted? Can we log in as root? |
| Password complexity | Are passwords weak enough to appear in a wordlist? |
| Rate limiting / fail2ban | Is there any brute-force protection in place? |
| Firewall (UFW) | Is a firewall active? |

---

## Execution

### Tool: Hydra (SSH Brute Force)

Testing whether password-based SSH is enabled and whether weak passwords are in use:

```bash
hydra -l root -P /usr/share/seclists/Passwords/xato-net-10-million-passwords.txt \
  ssh://TARGET_IP -t 2 -v
```

| Flag | Description |
|------|-------------|
| `-l root` | Target username (testing root account) |
| `-P /path/wordlist` | Password wordlist |
| `ssh://` | Protocol being tested |
| `-t 2` | Number of parallel threads |
| `-v` | Verbose output |
| `-I` | Resume a previous session |

### Example Output

```
[22][ssh] host: 178.79.173.229   login: root   password: <cracked>
```

If password-based authentication is confirmed enabled at the start of the scan, the remediation has already failed one check — regardless of whether the password is cracked.

---

## Validating Remediation

After the brute-force attempt, assess:

| Check | Result | Verdict |
|-------|--------|---------|
| Password-based SSH enabled | Yes — auth accepted | **FAIL** — policy requires key-based only |
| Root login permitted | Yes — root login allowed | **FAIL** — policy requires PermitRootLogin no |
| Rate limiting active | No fail2ban running | **FAIL** — no brute-force protection |
| Password cracked | Yes (weak password found) | **FAIL** — policy requires 12+ char complexity |

---

## Remediation Suggestions from Pen Test

### Disable Password-Based SSH and Root Login
```bash
sudo nano /etc/ssh/sshd_config
# Set:
PasswordAuthentication no
PermitRootLogin no

sudo systemctl restart sshd
```

### Implement Rate Limiting with fail2ban
```bash
sudo apt install -y fail2ban
sudo systemctl enable fail2ban --now
```

### Change Default SSH Port
```bash
# In /etc/ssh/sshd_config:
Port 2222
```

### Check UFW Firewall Status
```bash
sudo ufw status
sudo ufw enable
sudo ufw allow 2222/tcp  # Allow new SSH port
```

---

## Pen Test Report Structure

Even in this simplified demonstration, the report follows standard structure:

| Section | Content |
|---------|---------|
| **Executive Summary** | Overview of findings and overall security posture |
| **Methodology** | Tools used, scope, approach |
| **Findings** | Each vulnerability with evidence (screenshots, output) |
| **Recommendations** | Specific, actionable fixes tied back to audit findings and policy items |

> Key difference from audit report: Pen test recommendations are **specific** and **technical** — not "improve SSH security" but "disable `PasswordAuthentication`, enforce key-based auth, install fail2ban".

---

## The Full Lifecycle (Summary)

```
Security Policy (NIST SP 800-53)
        ↓
Security Audit (Lynis)
        ↓ findings
Audit Report → defines scope
        ↓
Penetration Test (Hydra, manual testing)
        ↓ findings
Pen Test Report → specific remediation
        ↓
Implement Fixes
        ↓
Next Audit Cycle
```

---

## Key Takeaways

- The pen test scope is **entirely derived from the audit report** in the sequential approach
- Testing starts with the specific policy items flagged by Lynis — not a free-form assessment
- Password-based authentication being enabled is an immediate policy violation — even before the brute force completes
- fail2ban is the standard Linux rate-limiting solution for SSH brute-force protection
- The pen test proves whether remediations are effective — it's the **verification step** in the audit lifecycle
- This three-phase demo (policy → audit → pen test) is the core model you'll encounter in real-world enterprise engagements
