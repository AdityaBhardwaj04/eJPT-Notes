---
title: Web Application Architecture
tags: [eJPT, WebApp, Architecture, ClientServer, Frontend, Backend, Database]
created: 2026-06-21
source: Transcripts
---

# Web Application Architecture

**Related:** [[Introduction-to-Web-Application-Security]] | [[Web-Application-Technologies]] | [[Introduction-to-HTTP]] | [[00-INDEX]]

---

## Overview

Understanding web application architecture is critical for web application penetration testing. Knowing what components exist, where they sit, and how they interact allows you to:

- Understand **where vulnerabilities originate** (client-side vs server-side)
- Know **what to look for** when identifying and exploiting misconfigurations
- Understand **why** certain attacks (XSS, SQLi) exist and how they work at a structural level

---

## The Client-Server Model

Web applications are built on the **client-server model**:

```
[Client — Browser]  ←—HTTP requests/responses—→  [Server — Web Application]
```

| Component | Role |
|---|---|
| **Client** | The browser on the user's device — handles the user interface, renders HTML/CSS/JS, sends requests |
| **Server** | The web server and application backend — processes requests, interacts with databases, generates responses |

The key point: **a portion of the web application runs in the browser** (client-side) and the rest runs on the server (server-side). Attacks target either side.

---

## Web Application Components

| Component | Function |
|---|---|
| **User Interface** | Visual elements seen and interacted with by users — web pages, forms, buttons, menus |
| **Client-Side Technologies** | HTML, CSS, JavaScript — create the UI and handle browser interactions |
| **Server-Side Technologies** | PHP, Python, Java, Ruby — implement business logic, process requests, interact with databases |
| **Database Server** | Stores persistent data — user credentials, content, configurations |
| **Application Logic** | Rules governing how the app functions — authentication, validation, access control |
| **Web Server** | Handles incoming HTTP requests, serves static files — e.g., Apache, Nginx, IIS |
| **Application Server** | Executes server-side code and handles dynamic processing — think of it as the CMS core (e.g., WordPress core) |

---

## Client-Side Processing

Processing that occurs **in the user's browser**. Technologies involved: HTML, CSS, JavaScript.

**Key characteristics:**

- Handles user interaction, UI rendering, and client-side validation
- JavaScript can be manipulated by users or attackers — this is the attack surface for **Cross-Site Scripting (XSS)**
- Input validation done client-side can be bypassed — always re-validate server-side
- Client-side code is visible to any user who views the page source

**Why this matters for attacks:**
XSS exploits client-side processing — malicious JavaScript is injected and executed by another user's browser.

---

## Server-Side Processing

Processing that occurs **on the web server**. Technologies: PHP, Python, Java, Ruby.

**Key characteristics:**

- Handles sensitive operations — credential verification, database queries, business logic
- More secure than client-side (runs on a trusted server the attacker does not control)
- Server-side language determines how database interaction is implemented — affects SQLi approach

**Why this matters for attacks:**
SQL injection exploits server-side database interaction. If user input reaches a database query without validation, an attacker can inject SQL commands.

---

## Communication and Data Flow

```
1. User types URL in browser
2. Browser performs DNS lookup → gets IP address of web server
3. Browser sends HTTP request to web server (via TCP)
4. Web server processes request → may query database
5. Database returns data to web server
6. Web server generates HTTP response → sends HTML/CSS/JS + data back to browser
7. Browser parses and renders the response
```

The protocol facilitating steps 3–6 is **HTTP** (or HTTPS). See [[Introduction-to-HTTP]].

---

## How a Browser Renders a Web Page

```
1. Request sent → server returns HTML file
2. Browser HTML parser processes HTML → builds Document Object Model (DOM)
3. JavaScript is downloaded and executed by the browser's JavaScript engine
4. CSS is downloaded and parsed → styling applied
5. Page rendered and displayed to user
```

The **JavaScript engine** within every modern browser (Chrome V8, Firefox SpiderMonkey) executes JavaScript. This is what XSS targets.

---

## Data Interchange — APIs

Modern web applications use **APIs (Application Programming Interfaces)** for communication between components and with external services.

| Format/Protocol | Description |
|---|---|
| **JSON** | JavaScript Object Notation — lightweight data format for server-client data exchange |
| **XML** | Extensible Markup Language — structured data format for configuration and web services |
| **REST** | Representational State Transfer — uses standard HTTP methods (GET, POST, PUT, DELETE) for data exchange |
| **SOAP** | Simple Object Access Protocol — structured XML-based protocol for web services |

APIs are a significant attack surface — covered in dedicated courses within this learning path.

---

## Key Takeaways

- Web applications follow the **client-server model** — browser is client, web server + app + database is the server side
- **Client-side** (HTML/CSS/JS) runs in the browser — vulnerable to XSS and JavaScript manipulation
- **Server-side** (PHP/Python/Java) runs on the server — vulnerable to SQLi, command injection, etc.
- The web server (Apache/Nginx/IIS) handles requests and serves files; the application server handles business logic
- All client-server communication is via **HTTP/HTTPS** — understanding this protocol is mandatory for web app testing
- APIs extend web application functionality and introduce additional attack surfaces
