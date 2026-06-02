---
title: Enumeration — Index
tags: [eJPT, Enumeration, Index, Hub]
created: 2026-04-06
source: Notion
---

# Enumeration

**Related:** [[00-INDEX]] | [[Footprinting-and-Scanning/00-INDEX]] | [[Reconnaissance/00-INDEX]]

---

## What is Enumeration?

Enumeration follows port scanning. Where scanning tells you *what's open*, enumeration answers: **what more can we learn about those services?**

The intelligence gathered here directly drives exploitation — credentials, shares, misconfigs, version-specific CVEs.

---

## Notes in This Section

| Note | Topic |
|---|---|
| [[Enumeration-Course-Introduction]] | Course roadmap, learning objectives, prerequisites |
| [[Introduction-to-Enumeration]] | What enumeration is, methodology position, protocol overview |
| [[Port-Scanning-with-Nmap-Metasploit]] | Nmap scanning for Windows targets, XML export |
| [[Importing-Nmap-into-Metasploit]] | db_import, workspaces, db_nmap, hosts/services |
| [[Port-Scanning-Auxiliary-Modules]] | TCP/UDP auxiliary modules, pivoting through Meterpreter |
| [[FTP-Enumeration]] | Port 21, ftp_version, ftp_login, anonymous login |
| [[SMB-Enumeration]] | Port 445, smb_version, smb_enumusers, smb_enumshares, smb_login |
| [[SSH-Enumeration]] | Port 22, ssh_version, ssh_login, ssh_enumusers |
| [[SMTP-Enumeration]] | Port 25, smtp_version, smtp_enum, VRFY/EXPN |
| [[MySQL-Enumeration]] | Port 3306, mysql_version, mysql_login, mysql_enum, mysql_sql |
| [[Web-Server-Enumeration]] | Port 80/443, Apache, dir_scanner, robots_txt, http_login |

---

## Service Quick Reference

| Service | Port | Key Modules | Primary Goal |
|---|---|---|---|
| FTP | 21 | ftp_version, ftp_login, anonymous | Credentials + file access |
| SSH | 22 | ssh_version, ssh_login, ssh_enumusers | Shell access |
| SMTP | 25 | smtp_version, smtp_enum | Username enumeration |
| SMB | 445 | smb_version, smb_enumusers, smb_enumshares, smb_login | File shares + credentials |
| HTTP/S | 80/443 | http_version, dir_scanner, robots_txt, http_login | Directories + credentials |
| MySQL | 3306 | mysql_version, mysql_login, mysql_enum, mysql_sql | Database access |

---

## Standard Workflow

```bash
service postgresql start
msfconsole
workspace add <engagement-name>

# 1. Scan target
db_nmap -Pn -sV -O <target-ip>
hosts && services

# 2. Enumerate each open service
# → See individual service notes above
```
