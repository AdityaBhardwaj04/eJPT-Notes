---
title: Introduction to HTTP
tags: [eJPT, WebApp, HTTP, Protocol, TCP, Stateless, HTTP11]
created: 2026-06-21
source: Transcripts
---

# Introduction to HTTP

**Related:** [[HTTP-Requests]] | [[HTTP-Responses]] | [[HTTPS]] | [[Web-Application-Architecture]] | [[00-INDEX]]

---

## What is HTTP?

**HTTP** = HyperText Transfer Protocol

- A **stateless, application layer protocol** used for transmitting resources (web pages, data, files) between clients and servers
- Runs **on top of TCP** (transport layer) — TCP handles packet transport; HTTP handles the application-level interaction
- Designed specifically for communication between **web browsers and web servers**
- Communication model: **request → response** (nothing more)

> **Stateless** means HTTP itself does not maintain a connection or remember anything between requests. TCP below it IS stateful (requires a handshake), but at the HTTP level there is no handshake — you send a request, you get a response.

---

## HTTP vs HTTPS

A common misconception: **HTTPS is not a newer version of HTTP**. It is HTTP with an **SSL/TLS certificate** layered on top.

| Protocol | Port | Encryption |
|---|---|---|
| **HTTP** | 80 | None — data sent in clear text |
| **HTTPS** | 443 | SSL/TLS encrypted |

The original problem: With plain HTTP, if an attacker intercepted a request containing credentials (e.g., a banking login), they could read those credentials in clear text. HTTPS solved this by encrypting all requests and responses using a certificate installed on the web server.

See [[HTTPS]] for a full breakdown.

---

## HTTP 1.0 vs HTTP 1.1

| Feature | HTTP 1.0 | HTTP 1.1 |
|---|---|---|
| **Connection persistence** | Connection closed after each request — browser must re-establish TCP connection for every new request | Connection can be **kept alive** (reused) for multiple requests via the `Connection: keep-alive` header |
| **Speed** | Slower — TCP three-way handshake overhead repeated per request | Faster — TCP handshake performed once, subsequent requests reuse the connection |
| **Status** | Largely obsolete | Most widely used version today |

> HTTP 1.1 leverages TCP's stateful connection to maintain the underlying TCP session. You can verify this with `netstat -ntp` on Linux — active TCP connections to port 80/443 represent open HTTP 1.1 sessions.

---

## The Request-Response Model

HTTP communication is simple:

```
Browser (Client)  —— HTTP Request ——→  Web Server
Browser (Client)  ←— HTTP Response ——  Web Server
```

1. Browser resolves domain → IP address via DNS
2. TCP three-way handshake (SYN → SYN-ACK → ACK) establishes connection to port 80 (HTTP) or 443 (HTTPS)
3. Browser sends **HTTP request**
4. Web server processes it, may query a database
5. Web server sends back **HTTP response**
6. Browser parses and renders the response

The detail and nuance lives in the **data contained within the request and response** — the headers, the methods, the status codes.

---

## URL / URI — Identifying Resources

Resources on the web are uniquely identified by a **URL** (Uniform Resource Locator) or **URI** (Uniform Resource Identifier).

In an HTTP request, the URI is split across two locations:
- **Host header** → contains the domain (e.g., `google.com`)
- **Request line URI** → contains the resource path (e.g., `/login.php`)

The web server combines them: `google.com` + `/login.php` = `google.com/login.php`

---

## Structure of HTTP Messages (Overview)

Both requests and responses follow the same three-section structure:

**Request:**
```
[Request Line]  →  GET /index.php HTTP/1.1
[Headers]       →  Host: example.com
                   User-Agent: Mozilla/5.0
                   ...
[Body]          →  (optional — used with POST/PUT)
```

**Response:**
```
[Status Line]   →  HTTP/1.1 200 OK
[Headers]       →  Content-Type: text/html
                   Set-Cookie: PHPSESSID=abc123
                   ...
[Body]          →  (optional — usually the HTML page)
```

See [[HTTP-Requests]] and [[HTTP-Responses]] for the full breakdown.

---

## Key Takeaways

- HTTP = **stateless application layer protocol** running on TCP — request/response, no handshake at the HTTP level
- TCP IS stateful — the TCP three-way handshake (SYN/SYN-ACK/ACK) occurs before any HTTP traffic
- **HTTPS = HTTP + SSL/TLS certificate** on the web server — not a different protocol, just encrypted HTTP
- HTTP **1.0** closes connection after each request; HTTP **1.1** keeps the TCP connection alive (`Connection: keep-alive`)
- Default ports: HTTP → **80**, HTTPS → **443**
- Mastering HTTP is foundational — all web app pen testing involves intercepting, analyzing, and modifying HTTP requests and responses
