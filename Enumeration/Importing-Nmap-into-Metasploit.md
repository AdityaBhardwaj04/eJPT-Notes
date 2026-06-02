---
title: Importing Nmap Scan Results into Metasploit
tags: [Enumeration, Nmap, Metasploit, XMLImport, Workspace, dbImport, eJPT]
created: 2026-04-04
source: Notion
---

# Importing Nmap Scan Results into Metasploit

**Related:** [[Nmap-Output-Formats]] | [[Port-Scanning-with-Nmap-Metasploit]] | [[Port-Scanning-Auxiliary-Modules]] | [[00-INDEX]]

---

## Overview

Continuation from port scanning with Nmap. We had performed a port scan and exported results to `WindowsServer2012.xml`. This covers importing that XML into Metasploit and running scans directly from within MSF.

---

## Step 1 — Start PostgreSQL

```bash
service postgresql start
```

---

## Step 2 — Launch MSF & Verify DB Connection

```bash
msfconsole
db_status
# Connected to msf. Connection type: postgresql.
```

---

## Step 3 — Create a Workspace

Always create a dedicated workspace per engagement:

```bash
workspace                  # List existing workspaces
workspace -a Win2K12       # Create and switch to new workspace
workspace                  # Confirm active workspace (highlighted)
```

---

## Step 4 — Import the Nmap XML File

```bash
db_import /root/WindowsServer2012.xml
# Output: Importing Nmap XML data... host imported successfully
```

> If the file isn't in the current directory, provide the **absolute path**.

---

## Step 5 — Verify Imported Data

```bash
hosts
# Shows: IP address, OS name, purpose (server)

services
# Shows: port, protocol, service name, version info
# Includes HTTP file server, MSRPC, NetBIOS, SMB, RDP
```

---

## Alternative — Run Nmap Directly from MSF (`db_nmap`)

Results are **automatically saved** to the current workspace — no manual import needed.

```bash
workspace -a NmapMSF

db_nmap -Pn -sV -O <target-ip>

hosts
services
```

> Each workspace is completely independent — scanning the same target in two different workspaces produces isolated result sets.

---

## Check for Vulnerabilities

```bash
vulns
# Lists vulnerabilities MSF has associated with discovered services
# Empty at this stage — populated after running exploit/vuln modules
```

---

## Workflow Summary

```bash
# Option A: Manual import
service postgresql start
msfconsole
db_status
workspace -a <engagement-name>
db_import /path/to/nmap_scan.xml
hosts && services

# Option B: Scan from within MSF
service postgresql start
msfconsole
workspace -a <engagement-name>
db_nmap -Pn -sV -O <target-ip>
hosts && services
```

---

## Key Takeaways

- Workspaces are the recommended way to organise data per engagement or target
- `db_import` requires XML format — normal/grepable formats won't work
- `db_nmap` auto-saves results — the most efficient workflow
- Data persists across sessions as long as PostgreSQL is running
- Next: use imported data with **auxiliary modules** to enumerate services → [[Port-Scanning-Auxiliary-Modules]]
