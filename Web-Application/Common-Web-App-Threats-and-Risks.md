---
title: Common Web App Threats and Risks
tags: [eJPT, WebApp, Threats, Risks, XSS, SQLi, CSRF, SSRF, BruteForce, FileUpload, AccessControl]
created: 2026-06-21
source: Transcripts
---

# Common Web App Threats and Risks

**Related:** [[Introduction-to-Web-Application-Security]] | [[Web-App-Security-Testing]] | [[HTTPS]] | [[00-INDEX]]

---

## Threat vs Risk — The Distinction

Understanding the difference between a threat and a risk is critical for writing professional pen test reports.

| Concept | Definition | Example |
|---|---|---|
| **Threat** | Any potential source of harm that may exploit a vulnerability — can be human-made (attackers, insiders) or natural (floods, power outages) | An XSS vulnerability on the login page |
| **Risk** | The **probability** of a threat being exploited **multiplied by** the **impact** if it is exploited | How easy is it to exploit the XSS? What data/sessions can be stolen if it is? |

```
Risk = Likelihood × Impact
```

**Likelihood factors:** Is it easy to exploit? Are public tools available? Does it require specialized knowledge? Can a script kiddie do it?

**Impact factors:** What data is exposed? What business function is disrupted? Is customer PII, financial data, or credentials at risk?

> When reporting vulnerabilities, you must calculate risk — not just list threats. Risk level determines remediation priority for the organization.

---

## Common Web Application Vulnerabilities

### High-Impact Vulnerabilities

| Vulnerability | Description | Risk |
|---|---|---|
| **Cross-Site Scripting (XSS)** | Attackers inject malicious JavaScript into web pages viewed by other users | Session hijacking, credential theft, browser manipulation, defacement |
| **SQL Injection (SQLi)** | Attackers inject malicious SQL into user input fields that flow into database queries | Unauthorized data access, data manipulation, full database compromise |
| **Server-Side Request Forgery (SSRF)** | Attacker tricks the server into making requests to internal or external resources on the attacker's behalf | Internal network pivoting, cloud metadata credential theft, data exfiltration |
| **File Upload Vulnerabilities** | Insecure upload mechanisms without file type/extension filtering allow uploading malicious scripts | Remote code execution on the server (e.g., PHP web shell upload) |

### Authentication and Session Vulnerabilities

| Vulnerability | Description | Risk |
|---|---|---|
| **Brute Force / Credential Stuffing** | Automated tools try large numbers of username/password combinations | Unauthorized account access; credential stuffing reuses leaked credentials from other breaches |
| **Broken Access Control** | Access control mechanisms are implemented but can be bypassed or circumvented | Unauthorized access to restricted functionality or sensitive data |
| **Inadequate Access Control** | Access controls are missing or insufficient for sensitive resources (e.g., admin panel exposed to any IP) | Unauthorized access, enabling further attacks like brute force on admin panels |

### Data and Configuration Vulnerabilities

| Vulnerability | Description | Risk |
|---|---|---|
| **Sensitive Data Exposure** | Sensitive data (passwords, PII, financial info) is inadequately protected — e.g., directory listing enabled on web server | Data breach, identity theft, compliance violations |
| **Security Misconfiguration** | Improperly configured servers, databases, or frameworks expose sensitive data or create entry points | Varies widely — from information disclosure to full system compromise |
| **Using Components with Known Vulnerabilities** | Third-party libraries, plugins, or frameworks with unpatched vulnerabilities integrated into the web app | Supply chain attacks; vulnerability in a plugin can compromise the entire application |

### Injection and Forgery

| Vulnerability | Description | Risk |
|---|---|---|
| **Cross-Site Request Forgery (CSRF)** | Attacker tricks an authenticated user into unknowingly performing actions (changing account details, transferring money) by exploiting their active session | Unauthorized transactions, account modifications, privilege escalation |

### Availability

| Vulnerability | Description | Risk |
|---|---|---|
| **DoS / DDoS** | Flooding a web server with traffic to overwhelm it and deny service to legitimate users | Service disruption, downtime, revenue loss |

---

## File Upload Vulnerability — Example

**Scenario:** A WordPress plugin allows users to upload their "profile picture." If the upload mechanism does not validate file extensions:

1. Attacker uploads `shell.php` (PHP web shell) instead of an image
2. File is stored on the web server in the `uploads/` directory
3. Attacker navigates to `http://target.com/uploads/shell.php?cmd=whoami`
4. Web server executes the PHP file → attacker has **Remote Code Execution (RCE)**

> The web shell must match the server-side language. PHP web shells only work on PHP servers. Java web app → use JSP shell. Python → use WSGI shell. See [[Exploiting-WordPress]] for a practical example.

---

## XSS vs SQLi — Quick Comparison

| Aspect | XSS | SQLi |
|---|---|---|
| **Attack surface** | HTML/JavaScript output rendered in the browser | Input fields that flow into SQL database queries |
| **Target** | Other users' browsers | The database server |
| **Execution** | In the victim's browser (client-side) | On the server (server-side) |
| **Primary impact** | Session hijacking, credential theft, browser manipulation | Database access, data exfiltration, data modification |

---

## Proactive Defense Approach

Web application security requires a **multi-layered approach**:

- **Secure coding practices** — validate and sanitize all user inputs at the source
- **Regular security testing** — vulnerability scanning + penetration testing
- **Keep components updated** — patch plugins, frameworks, and libraries
- **Continuous monitoring** — detect attacks in progress before they escalate
- **User education** — prevent phishing and social engineering

---

## Key Takeaways

- **Threat** = the vulnerability or potential attack; **Risk** = likelihood × impact of that threat being exploited
- Risk calculation determines severity rating in your report and drives remediation prioritization
- The most common high-impact vulnerabilities: **XSS**, **SQLi**, **SSRF**, **file upload**, **broken access control**
- **File upload** without extension filtering → web shell upload → Remote Code Execution
- **CSRF** exploits authenticated sessions; **XSS** injects malicious JS into pages
- Using **outdated or unpatched third-party components** (plugins, libraries) is a primary source of web app vulnerabilities — especially in CMS environments like WordPress
- HTTPS does **not** protect against any of these vulnerabilities — see [[HTTPS]]
