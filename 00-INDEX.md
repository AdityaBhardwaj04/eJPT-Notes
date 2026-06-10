---
title: Penetration Testing Vault — Master Index
tags:
  - eJPT
  - Index
  - Hub
  - MasterIndex
  - Pentesting
created: 2026-04-06
updated: 2026-06-08
source: Notion / Transcription / Knowledge
---

# Penetration Testing Vault

Master reference for the penetration testing career path — from eJPT through OSCP and beyond.

---

## Full Pentest Lifecycle

```
Passive Reconnaissance
        ↓
Active Recon (Footprinting & Scanning)
        ↓
Enumeration
        ↓
Vulnerability Assessment
        ↓
Exploitation
        ↓
Post-Exploitation (PrivEsc → Persistence → Lateral Movement)
        ↓
Reporting
```

---

## Sections

### Networking Fundamentals
> Foundational concepts required before everything else

| Note | Summary |
|---|---|
| [[Networking-Fundamentals-OSI]] | OSI 7-layer model, packet structure, encapsulation |
| [[Transport-Layer-TCP-UDP]] | TCP vs UDP, 3-way handshake, TCP flags, port ranges |

→ [[Networking/00-INDEX]]

---

### Reconnaissance (Passive)
> Intelligence gathering without touching the target

| Note | Summary |
|---|---|
| [[Active-vs-Passive-Recon]] | Core distinction and 4-step strategy |
| [[Target-Scoping]] | LOE, ROE, defining scope |
| [[Website-Recon]] | host, robots.txt, BuiltWith, Wappalyzer, whatweb |
| [[WHOIS-Enumeration]] | Domain/IP registration data |
| [[Netcraft]] | SSL/TLS, hosting history, site tech |
| [[DNS-Reconnaissance]] | DNS record types, dnsrecon, DNSdumpster |
| [[WAF-Detection-wafw00f]] | Detect and identify WAF |
| [[Subdomain-Enumeration]] | sublist3r |
| [[Google-Dorks]] | Google operators, GHDB, Wayback Machine |
| [[Email-Harvesting]] | theHarvester, crtsh, rapiddns |
| [[Leaked-Password-Databases]] | HIBP manual + API |

→ [[Reconnaissance/00-INDEX]]

---

### Footprinting & Scanning (Active Recon)
> Live host discovery, port scanning, service/OS detection

| Note | Summary |
|---|---|
| [[Active-Information-Gathering]] | Methodology flow, passive vs active |
| [[Network-Mapping]] | Subnet mapping objectives |
| [[Host-Discovery-Techniques]] | 6 discovery techniques, Nmap flags |
| [[Port-Scanning-Nmap]] | Core Nmap: -Pn, scan types, -sV, -O, output |
| [[Port-Scanning-Nmap-InDepth]] | SYN vs TCP Connect, port states, UDP |
| [[Service-Version-OS-Detection]] | Version intensity, OS fingerprinting |
| [[NSE]] | Nmap script categories, -sC, wildcard scripts |
| [[Optimizing-Nmap-Scans]] | Timing templates, scan delay, benchmarks |
| [[Nmap-Output-Formats]] | -oN/-oX/-oG/-oA, db_import |
| [[Firewall-Detection-IDS-Evasion]] | Fragmentation, decoys, source port spoofing |

→ [[Footprinting-and-Scanning/00-INDEX]]

---

### Enumeration
> Deep-dive into discovered services

| Note | Summary |
|---|---|
| [[Introduction-to-Enumeration]] | What enumeration adds, methodology position |
| [[Port-Scanning-with-Nmap-Metasploit]] | Nmap + MSF integration, XML export |
| [[Importing-Nmap-into-Metasploit]] | db_import, workspaces, db_nmap |
| [[Port-Scanning-Auxiliary-Modules]] | Auxiliary modules, pivoting via Meterpreter |
| [[FTP-Enumeration]] | Port 21 — version, brute force, anonymous |
| [[SMB-Enumeration]] | Port 445 — users, shares, brute force, smbclient |
| [[SSH-Enumeration]] | Port 22 — version, login, enumusers, sessions |
| [[SMTP-Enumeration]] | Port 25 — version, VRFY/EXPN user enum |
| [[MySQL-Enumeration]] | Port 3306 — version, login, enum, sql, schemadump |
| [[SNMP-Enumeration]] | UDP 161 — community strings, snmpwalk, user/software enumeration |
| [[Web-Server-Enumeration]] | Port 80/443 — Apache, dirs, robots.txt, auth brute force |

→ [[Enumeration/00-INDEX]]

---

### Vulnerability Assessment
> Identify, classify, and prioritise vulnerabilities before exploitation

| Note | Summary |
|---|---|
| [[Overview-of-Windows-Vulnerabilities]] | Windows threat surface, history (EternalBlue, Conflicker), vulnerability types |
| [[Frequently-Exploited-Windows-Services]] | IIS, WebDAV, SMB, RDP, WinRM — ports and attack vectors |
| [[Vulnerability-Analysis-EternalBlue]] | MS17-010 — manual (AutoBlue) + Metasploit |
| [[Vulnerability-Analysis-BlueKeep]] | CVE-2019-0708 RDP exploit |
| [[Vulnerability-Scanning-with-MSF]] | db_nmap, searchsploit, db_autopwn |
| [[WebDAV-Vulnerabilities]] | davtest, cadaver, ASP web shell |
| [[Vulnerability-Scanning-with-Nessus]] | Nessus install, scan, export to MSF |
| [[Web-App-Vulnerability-Scanning-with-WMAP]] | WMAP plugin, HTTP method abuse |
| [[Pass-the-Hash-Attacks]] | PtH via MSF psexec and CrackMapExec |
| [[Exploiting-HTTP-File-Server]] | Rejetto HFS 2.3 RCE — Windows Meterpreter |
| [[Exploiting-WinRM]] | WinRM brute force + script exec — SYSTEM Meterpreter |
| [[Exploiting-Apache-Tomcat]] | Tomcat 8.5.19 JSP upload bypass → Meterpreter via MSFvenom |

→ [[Vulnerability-Assessment/00-INDEX]]

---

### Linux Exploitation
> Exploiting Linux systems and services

| Note | Summary |
|---|---|
| [[Frequently-Exploited-Linux-Services]] | GNU/Linux overview, Apache/SSH/FTP/Samba |
| [[Vulnerability-Analysis-Shellshock]] | CVE-2014-6271 — Bash RCE via Apache CGI |
| [[Exploiting-FTP-vsftpd]] | VSFTPD 2.3.4 backdoor — instant root shell |
| [[Exploiting-SSH-libssh]] | libSSH 0.6–0.8 auth bypass — root shell |
| [[Exploiting-SMTP-Haraka]] | Haraka < 2.8.9 command injection — root Meterpreter |
| [[Exploiting-Samba-MSF]] | Samba 3.5.0–4.4.14 is_known_pipename — root shell |

→ [[Linux-Exploitation/00-INDEX]]

---

### Post-Exploitation
> Privilege escalation, persistence, lateral movement, and clearing tracks

| Note | Summary |
|---|---|
| [[Introduction-to-Post-Exploitation]] | Post-exploitation lifecycle, ROE, objectives, key variables |
| [[Post-Exploitation-Methodology]] | 8-stage methodology, tools per phase, workflow overview |
| [[Post-Exploitation-Cheatsheet]] | All commands organized by phase — quick reference |
| [[eJPT-Post-Exploitation-Checklist]] | Exam-day checklist for Windows and Linux tracks |
| [[Windows-Local-Enumeration]] | System info, users, groups, network, processes, JAWS automation |
| [[Linux-Local-Enumeration]] | System info, users, groups, network, cron, LinEnum automation |
| [[File-Transfers]] | Python web server, certutil (Windows), wget (Linux), tmux |
| [[Upgrading-Shells]] | Non-interactive shell, Python pty, env fix, shell→Meterpreter |
| [[Windows-Privilege-Escalation]] | PrivescCheck, WinLogon credentials, psexec.py, web_delivery |
| [[Linux-Privilege-Escalation-SUDO]] | sudo -l, NOPASSWD, GTFOBins, pager escapes |
| [[Linux-Privilege-Escalation-Weak-Permissions]] | World-writable files, /etc/shadow exploit, openssl passwd |
| [[Windows-Persistence]] | Service-based persistence, RDP backdoor (getgui), registry |
| [[Linux-Persistence-SSH-Keys]] | SSH key theft, key planting, authorized_keys |
| [[Linux-Persistence-Cron-Jobs]] | Cron reverse shell, bash /dev/tcp, netcat listener |
| [[Windows-Password-Hashes]] | NTLM theory, SAM, hashdump, Kiwi/Mimikatz, John/Hashcat |
| [[Dumping-Linux-Password-Hashes]] | /etc/shadow, linux/gather/hashdump, sha512crypt cracking |
| [[Pivoting]] | autoroute, port forwarding, bind_tcp payloads, ping verification |
| [[Clearing-Tracks-Windows]] | /temp artifacts, MSF cleanup scripts, clearev (red team only) |
| [[Clearing-Tracks-Linux]] | /tmp, bash history, history -c, selective deletion |
| [[Msfvenom-Payloads]] | Generating, encoding (Shikata Ga Nai), injecting payloads into PE files |
| [[Meterpreter-Fundamentals]] | Session management, filesystem, shell, process migration |
| [[Resource-Scripts]] | Automating MSF with .rc files — handler, port scan, db_status |
| [[Windows-Post-Exploitation-Modules]] | win_privs, enum_logged_on, checkvm, enum_applications, enum_patches |
| [[Alternate-Data-Streams]] | NTFS ADS — hiding executables in resource streams |
| [[Keylogging-and-Covering-Tracks]] | keyscan_start/dump, clearev — erase Windows event logs |
| [[Enabling-RDP]] | Enable RDP via MSF module, xfreerdp access from Kali |
| [[Searching-For-Passwords-In-Windows-Configuration-Files]] | Unattended install files, registry passwords |

→ [[Post-Exploitation/00-INDEX]]

---

### Web Application Security
> OWASP Top 10 and web exploitation techniques

| Note | Summary |
|---|---|
| [[SQL-Injection]] | Union-based, blind, auth bypass, sqlmap, file read/write |
| [[File-Inclusion-LFI-RFI]] | LFI path traversal, log poisoning, PHP wrappers, RFI |

---

### Cheatsheets
> Quick reference for use during tests

| Note | Summary |
|---|---|
| [[Metasploit-Cheatsheet]] | Setup, sessions, Meterpreter, msfvenom, pivoting, resource scripts |

---

### Auditing Fundamentals
> Security auditing from a penetration tester's perspective — compliance, GRC, standards, practical audit-to-pentest lifecycle

| Note | Summary |
|---|---|
| [[Course-Introduction]] | Course overview and learning objectives |
| [[Overview-of-Security-Auditing]] | Definition, audit vs pentest vs VA, 6 reasons organisations audit |
| [[Essential-Terminology]] | Security policy, control, compliance, risk assessment, audit trail |
| [[Types-of-Security-Audits]] | Internal, external, compliance, technical, network, application audits |
| [[Security-Auditing-Process-Lifecycle]] | 6-phase audit lifecycle: planning through remediation |
| [[Security-Auditing-and-Penetration-Testing]] | Differences, sequential approach, PCI DSS case study |
| [[GRC]] | Governance, Risk & Compliance — components and pen tester relevance |
| [[Common-Standards-Frameworks-Guidelines]] | NIST CSF, COBIT, ISO 27001, PCI DSS, HIPAA, GDPR, CIS, NIST SP 800-53 |
| [[Phase-1-Develop-a-Security-Policy]] | NIST SP 800-53 controls, Linux server security policy |
| [[Phase-2-Security-Auditing-with-Lynis]] | Lynis install/run/interpret, ClamAV/RKHunter remediation |
| [[Phase-3-Conduct-Penetration-Test]] | Hydra SSH brute-force, validate remediations, audit-to-pen-test complete |

→ [[Auditing-Fundamentals/00-INDEX]]

---

## Service Port Reference

| Port | Service | Phase |
|---|---|---|
| 21 | FTP | Enumeration |
| 22 | SSH | Enumeration |
| 25 | SMTP | Enumeration |
| 53 | DNS | Reconnaissance |
| 80 | HTTP | Enumeration / Web App |
| 88 | Kerberos | Active Directory |
| 139/445 | SMB | Enumeration / AD |
| 389 | LDAP | Active Directory |
| 443 | HTTPS | Enumeration / Web App |
| 3306 | MySQL | Enumeration |
| 3389 | RDP | Exploitation |
| 5985 | WinRM | Lateral Movement |
