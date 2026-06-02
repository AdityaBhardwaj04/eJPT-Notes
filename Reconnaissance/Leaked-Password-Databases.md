---
title: Leaked Password Databases (HaveIBeenPwned)
tags: [eJPT, Reconnaissance, OSINT, Passive, Credentials]
created: 2026-03-30
source: Notion
---

# Leaked Password Databases (HaveIBeenPwned)

**Related:** [[Email-Harvesting]] | [[Active-vs-Passive-Recon]] | [[00-INDEX]]

---

## Overview

After harvesting email addresses from a target organization, the next passive step is checking whether those emails have appeared in publicly known **data breaches**. If credentials were leaked, employees may still be reusing that same password across services.

---

## HaveIBeenPwned (HIBP)

**URL:** `haveibeenpwned.com`  
Created and maintained by **Troy Hunt**. Aggregates leaked databases from major breaches (Facebook, LinkedIn, Adobe, etc.) and allows anyone to check whether an email has been compromised.

**Why it matters for pentesting:**
- Employees who reuse breached passwords are vulnerable to **password spray** and **credential stuffing** attacks
- A breached password can give access to corporate email, VPN, cloud services, etc.

---

## How to Use (Manual)

1. Navigate to `haveibeenpwned.com`
2. Enter target employee email address
3. Review breach results

**Output includes:**
- Which services were breached
- When the breach occurred
- What data was exposed (email, password hash, plaintext, name, phone, etc.)

**Notable breach example:**
- April 2021: 500M+ Facebook records leaked, including phone numbers, emails, and personal info

---

## HIBP API

```bash
# Check if an email has been pwned (v3 API requires API key)
curl -H "hibp-api-key: YOUR_API_KEY" \
  "https://haveibeenpwned.com/api/v3/breachedaccount/test@example.com"

# Check if a password hash has been seen in breaches (no API key needed)
# Hash the password with SHA-1 first, use first 5 chars as prefix
echo -n "password123" | sha1sum
# Returns: cbfdac6008f9cab4083784cbd1874f76618d2a97

# Query k-anonymity endpoint with prefix
curl "https://api.pwnedpasswords.com/range/cbfda"
# Returns all hashes starting with 'cbfda' and breach count
```

---

## Workflow: Email Harvesting → Credential Check

```
1. theHarvester -d target.com -b bing,crtsh,rapiddns    → [[Email-Harvesting]]
         ↓ (collect employee emails)
2. Check each email on haveibeenpwned.com
         ↓ (identify breached accounts)
3. Review breach details for leaked passwords
         ↓ (obtain password candidates)
4. Password spray / credential stuffing (active phase)
```

---

## Key Takeaways

- HIBP is **passive** — you're querying a third-party database, not the target
- Most people reuse passwords — a breach from any site can compromise corporate accounts
- HIBP has a free API (`pwnedpasswords.com`) for checking password hashes without exposing the full hash
- Always combine with [[Email-Harvesting]] as part of passive recon
- This technique feeds directly into the **active/exploitation** phase password attacks
