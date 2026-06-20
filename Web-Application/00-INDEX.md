---
title: Web Application Penetration Testing — Index
tags: [eJPT, WebApp, Index, Hub, HTTP, WordPress, CMS]
created: 2026-06-21
source: Transcripts
---

# Web Application Penetration Testing — Introduction to the Web & HTTP Protocol

**Related:** [[00-INDEX]] | [[Reconnaissance/00-INDEX]] | [[Enumeration/00-INDEX]]

---

## What is Web Application Penetration Testing?

Web application penetration testing is a **subset of web application security testing** that involves actively attempting to exploit identified vulnerabilities in web applications. The primary goal is to:

- Identify vulnerabilities, misconfigurations, and security weaknesses
- Exploit them in a controlled manner to validate risk
- Understand how web applications are built and why they fail
- Provide actionable remediation recommendations

This course covers the **fundamentals** — HTTP, web architecture, technologies, and introductory testing techniques — that underpin every other course in the web application learning path.

---

## Notes in This Section

**Foundations:**

| Note | Topic |
|---|---|
| [[Introduction-to-Web-Application-Security]] | Web app definition, CIA triad, security importance, best practices |
| [[Web-Application-Architecture]] | Client-server model, components, client-side vs server-side processing, data flow |
| [[Web-Application-Technologies]] | HTML/CSS/JS, web servers, databases, APIs, SSL/TLS, CDNs |

**HTTP Protocol:**

| Note | Topic |
|---|---|
| [[Introduction-to-HTTP]] | HTTP overview, stateless protocol, HTTP 1.0 vs 1.1, request-response model |
| [[HTTP-Requests]] | Request line, methods (GET/POST/PUT/DELETE/HEAD/OPTIONS), request headers, body |
| [[HTTP-Responses]] | Status line, response headers, status codes, cache-control directives |
| [[HTTP-Basics-Lab]] | Wireshark TCP analysis, curl, Burp Suite repeater, file upload via HTTP methods |
| [[HTTPS]] | SSL/TLS encryption, HTTPS limitations, attack implications |

**Threats & Testing Methodology:**

| Note | Topic |
|---|---|
| [[Common-Web-App-Threats-and-Risks]] | Threat vs risk, XSS, SQLi, CSRF, file upload vulns, brute force, SSRF |
| [[Web-App-Security-Testing]] | Security testing vs pen testing, types, methodology comparison |

**Active Enumeration & Scanning:**

| Note | Topic |
|---|---|
| [[Web-Server-Scanning-with-Nikto]] | Nikto syntax, web server vs web app vulns, directory indexing, LFI detection |
| [[File-and-Directory-Brute-Force]] | GoBuster dir mode, wordlists, extension filtering, seclists |
| [[Crawling-and-Spidering]] | Passive crawling (Burp Suite), active spidering (OWASP ZAP), site map building |

**CMS Security Testing:**

| Note | Topic |
|---|---|
| [[CMS-Security-Testing]] | CMS overview, why they're targeted, common vulnerabilities, testing methodology |
| [[WordPress-Security-Testing-Intro]] | WordPress architecture, attack vectors, WPScan methodology |
| [[Exploiting-WordPress]] | WPScan enumeration, user enumeration, password brute force, admin access |

---

## Course Sections Overview

| Section | Topics |
|---|---|
| Web Application Security | What web apps are, CIA triad, security importance, best practices |
| Web Application Architecture | Client-server model, components, processing, data flow |
| Web Application Technologies | HTML/CSS/JS, web/app/database servers, APIs, SSL/TLS |
| HTTP Protocol | HTTP fundamentals, requests, responses, HTTPS |
| Threats & Risks | Common vulnerabilities, threat vs risk calculation |
| Security Testing | Testing types, pen testing vs security testing |
| Active Scanning | Nikto, GoBuster, Burp Suite, OWASP ZAP |
| CMS Testing | WordPress enumeration, vulnerability scanning, exploitation |

---

## Prerequisites

- Basic Linux command-line familiarity
- Basic cybersecurity terminology and concepts
