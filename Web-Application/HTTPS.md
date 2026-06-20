---
title: HTTPS
tags: [eJPT, WebApp, HTTPS, SSL, TLS, Encryption, ManInTheMiddle]
created: 2026-06-21
source: Transcripts
---

# HTTPS

**Related:** [[Introduction-to-HTTP]] | [[HTTP-Requests]] | [[Web-Application-Technologies]] | [[00-INDEX]]

---

## What is HTTPS?

**HTTPS** = HyperText Transfer Protocol **Secure**

HTTPS is **not a new protocol** or an advanced version of HTTP. It is HTTP with an **SSL/TLS certificate** layered on top:

```
HTTPS = HTTP + SSL/TLS
```

The underlying protocol is still HTTP. The only change is that all requests and responses are **encrypted** before transmission.

---

## Why HTTPS Was Needed

### The Problem with Plain HTTP

HTTP sends all data in **clear text**. This creates two serious vulnerabilities:

1. **No encryption** — Any attacker who can intercept your packets can read your credentials, session tokens, and all other data in plain text
2. **No strong authentication** — You cannot verify you're talking to the legitimate server

**Attack scenario:** You're at a café on public WiFi. You log into a site using HTTP. An attacker on the same network runs Wireshark, captures your packets, and reads your username and password in clear text. This is a **man-in-the-middle (MITM) attack**.

This also applies to ISPs — they can monitor all your HTTP traffic if it's unencrypted.

### The HTTPS Solution

An SSL/TLS certificate is installed on the web server. When you connect:

1. Your browser receives the server's SSL/TLS certificate
2. An encrypted communication channel is established using the certificate's keys
3. All HTTP requests and responses are **encrypted** before leaving your browser
4. Even if an attacker intercepts the packet, they see only encrypted ciphertext — unreadable without the private key

---

## SSL vs TLS

| Term | Full Name | Status |
|---|---|---|
| **SSL** | Secure Sockets Layer | Older; largely deprecated but the term is still commonly used |
| **TLS** | Transport Layer Security | Modern replacement for SSL; what's actually in use today |

In practice: when people say "SSL certificate" or "SSL/TLS," they both refer to the same thing — the cryptographic certificate installed on the web server.

---

## What HTTPS Protects

| Protected | Not Protected |
|---|---|
| Credentials sent in HTTP requests (login form data) | Web application vulnerabilities (XSS, SQLi) |
| Session cookies transmitted between browser and server | Malicious payloads sent in requests |
| All HTTP headers and body data in transit | Stored data on the server |
| Against MITM traffic sniffing | Server-side misconfigurations |

---

## The Critical Limitation: HTTPS Does NOT Protect Against Web Application Attacks

> **HTTPS encrypts the transport, not the application logic.**

A SQL injection payload like `' OR '1'='1` injected into a login form is still sent to the server — it just travels encrypted. The encryption protects the payload **in transit**, but the web server decrypts it and processes it as SQL. The attack still works.

The same applies to:
- **XSS** — injected JavaScript is encrypted in transit but executes in the victim's browser
- **CSRF** — the forged request is encrypted but the server still processes it
- **File upload vulnerabilities** — the malicious file uploads over HTTPS just fine

> HTTPS secures the **channel** (communication between browser and server). It does nothing to secure the **web application itself** against code-level vulnerabilities.

---

## HTTP Ports vs HTTPS Ports

| Protocol | Default Port |
|---|---|
| HTTP | 80 |
| HTTPS | 443 |

---

## Practical Note for Pen Testing

When you intercept HTTPS traffic with Burp Suite, the proxy handles the decryption/re-encryption automatically (using its own CA certificate installed in your browser). You see the traffic in plain text within Burp. This is why:
- Burp Suite works equally well on HTTPS and HTTP targets
- HTTPS does not prevent web app pen testing — it just affects network-level sniffing
- Modern browsers send `Upgrade-Insecure-Requests: 1` header to automatically request HTTPS when available

---

## Key Takeaways

- **HTTPS = HTTP + SSL/TLS** — still HTTP underneath, just with encryption
- SSL/TLS certificate installed on the web server encrypts all HTTP traffic between browser and server
- Protects against **network-level interception** (MITM, packet sniffing on public WiFi, ISP monitoring)
- Does **NOT protect against web application vulnerabilities** (XSS, SQLi, CSRF) — those payloads are encrypted but still reach and execute on the server
- Default ports: HTTP = **80**, HTTPS = **443**
- Burp Suite handles HTTPS transparently — pen testing HTTPS sites works the same as HTTP
