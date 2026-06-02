# eJPT Vault

Personal knowledge base for the **INE Junior Penetration Tester (eJPT)** certification.

Built in Obsidian — all notes use `[[wikilinks]]` for graph navigation.

---

## Vault Structure

```
eJPT-Vault/
├── 00-INDEX.md                        ← Master index (start here)
├── README.md                          ← This file
│
├── Networking/
│   ├── 00-INDEX.md
│   ├── Networking-Fundamentals-OSI.md
│   └── Transport-Layer-TCP-UDP.md
│
├── Reconnaissance/
│   ├── 00-INDEX.md
│   ├── Active-vs-Passive-Recon.md
│   ├── Target-Scoping.md
│   ├── Website-Recon.md
│   ├── WHOIS-Enumeration.md
│   ├── Netcraft.md
│   ├── DNS-Reconnaissance.md
│   ├── WAF-Detection-wafw00f.md
│   ├── Subdomain-Enumeration.md
│   ├── Google-Dorks.md
│   ├── Email-Harvesting.md
│   └── Leaked-Password-Databases.md
│
├── Footprinting-and-Scanning/
│   ├── 00-INDEX.md
│   ├── Course-Introduction.md
│   ├── Active-Information-Gathering.md
│   ├── Network-Mapping.md
│   ├── Host-Discovery-Techniques.md
│   ├── Port-Scanning-Nmap.md
│   ├── Port-Scanning-Nmap-InDepth.md
│   ├── Service-Version-OS-Detection.md
│   ├── NSE.md
│   ├── Optimizing-Nmap-Scans.md
│   ├── Nmap-Output-Formats.md
│   ├── Firewall-Detection-IDS-Evasion.md
│   └── Course-Conclusion.md
│
└── Enumeration/
    ├── 00-INDEX.md
    ├── Enumeration-Course-Introduction.md
    ├── Introduction-to-Enumeration.md
    ├── Port-Scanning-with-Nmap-Metasploit.md
    ├── Importing-Nmap-into-Metasploit.md
    ├── Port-Scanning-Auxiliary-Modules.md
    ├── FTP-Enumeration.md
    ├── SMB-Enumeration.md
    ├── SSH-Enumeration.md
    ├── SMTP-Enumeration.md
    ├── MySQL-Enumeration.md
    └── Web-Server-Enumeration.md
```

---

## Navigation

- Open `00-INDEX.md` to navigate the full vault
- Each subfolder has its own `00-INDEX.md` hub
- All notes use `[[wikilinks]]` — enable Obsidian graph view for visual navigation
- Tags are set in frontmatter — use Obsidian tag search to filter by topic

---

## Note Format

All notes follow this structure:

```yaml
---
title: Note Title
tags: [eJPT, Category, Tool, ...]
created: YYYY-MM-DD
source: Notion
---
```

- Kebab-case filenames (`FTP-Enumeration.md`)
- Wikilinks reference filenames without extension (`[[FTP-Enumeration]]`)
- Code blocks use `bash` syntax highlighting
- Tables for comparisons, flag references, and module lists
