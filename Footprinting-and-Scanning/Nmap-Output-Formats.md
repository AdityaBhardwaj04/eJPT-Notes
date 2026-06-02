---
title: Nmap Output Formats & Saving Scan Results
tags: [eJPT, Nmap, OutputFormats, Metasploit, Reporting, Pentesting]
created: 2026-04-04
source: Notion
---

# Nmap Output Formats & Saving Scan Results

**Related:** [[Port-Scanning-Nmap]] | [[Importing-Nmap-into-Metasploit]] | [[Optimizing-Nmap-Scans]] | [[00-INDEX]]

---

## Overview

Saving scan results is one of the most important habits in pentesting:
- **Accountability** — record every action taken against a target system
- **Large scans** — losing results from a long scan means repeating the work
- **Tool integration** — XML can be imported directly into Metasploit
- **Reporting** — scan results need to be included in reports or handed off

---

## Output Formats

### Normal (`-oN`) — Human-Readable

```bash
nmap -Pn -sS -F -T4 -oN nmap_normal.txt <target-ip>
```

- Saves results **exactly as they appear on the terminal**
- Best for: **reporting, personal notes**
- Results are still printed to the terminal regardless of which output flag is used

---

### XML (`-oX`) — Tool Integration

```bash
nmap -Pn -sS -F -T4 -oX nmap_scan.xml <target-ip>
```

- Best for: **Metasploit import, automation pipelines** → [[Importing-Nmap-into-Metasploit]]
- Verify format: `cat nmap_scan.xml`

---

### Grepable (`-oG`) — Scripting & Parsing

```bash
nmap -Pn -sS -F -T4 -oG nmap_grep.txt <target-ip>
```

- One host per line, structured for `grep`, `awk`, `cut`
- Best for: **scripting, automation, custom parsing pipelines**

```bash
# Extract open ports
egrep -v "^#|Status: Up" nmap_grep.txt | cut -d' ' -f2 | awk '{print $1}'
```

---

### All Formats at Once (`-oA`) — Recommended

```bash
nmap -Pn -sS -F -T4 -oA nmap_results <target-ip>
# Creates: nmap_results.nmap, nmap_results.xml, nmap_results.gnmap
```

Best choice when you're unsure which format you'll need — covers everything in one scan run.

---

## Output Format Summary

| Flag | Format | Best Used For |
|---|---|---|
| `-oN` | Normal | Reporting, human-readable notes |
| `-oX` | XML | Metasploit import, tool integration |
| `-oG` | Grepable | Scripting, automation, parsing |
| `-oA` | All three | Capture everything in one scan |

---

## Additional Output Options

### Verbosity (`-v`, `-vv`)

```bash
nmap -Pn -sS -F -v <target-ip>    # Verbose
nmap -Pn -sS -F -vv <target-ip>   # Extra verbose
```

Shows results in real time as scan runs. Useful to see closed vs filtered reasoning.

### Reason (`--reason`)

```bash
nmap -Pn -sS -F --reason <target-ip>
```

Displays the **specific reason** a port is in its current state (e.g., `syn-ack` for open, `reset` for closed).

---

## Importing XML into Metasploit

See full details: [[Importing-Nmap-into-Metasploit]]

```bash
# Quick reference
service postgresql start
msfconsole
workspace add pentest_1
db_import /path/to/nmap_scan.xml
hosts
services
```

---

## Recommended Workflow

```bash
# 1. Initial discovery scan — save all formats
nmap -Pn -sS -F -T4 -oA recon/nmap_initial <target-subnet>/24

# 2. Import into Metasploit
service postgresql start && msfconsole
workspace add client_pentest
db_import recon/nmap_initial.xml

# 3. Deeper scan via db_nmap (auto-saves to workspace)
db_nmap -Pn -sS -sV -O -p- -T4 <target-ip>

# 4. Review
hosts
services
```

---

## Key Takeaways

- Always use `-oA` — covers all bases in a single scan run
- For **reporting**: use `-oN` — most readable for pentest reports
- XML (`-oX`) → feed directly into Metasploit via `db_import`
- Metasploit workspace data persists across sessions as long as PostgreSQL is running
- Use `-oA` as your default; cherry-pick formats only when necessary
