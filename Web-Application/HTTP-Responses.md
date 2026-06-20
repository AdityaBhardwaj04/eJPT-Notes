---
title: HTTP Responses
tags: [eJPT, WebApp, HTTP, Responses, StatusCodes, Headers, CacheControl]
created: 2026-06-21
source: Transcripts
---

# HTTP Responses

**Related:** [[HTTP-Requests]] | [[Introduction-to-HTTP]] | [[HTTP-Basics-Lab]] | [[00-INDEX]]

---

## Structure of an HTTP Response

Mirrors the request structure — three sections:

```
HTTP/1.1 200 OK                            ← Status Line (Response Line)
Date: Sat, 21 Jun 2026 10:00:00 GMT        ← Response Headers (start)
Server: Apache/2.4.7 (Ubuntu)
X-Powered-By: PHP/5.5.9
Cache-Control: private, no-cache
Content-Type: text/html; charset=UTF-8
Content-Encoding: gzip
Content-Length: 4523
Set-Cookie: PHPSESSID=abc123; path=/
                                           ← Blank line
<!DOCTYPE html><html>...                   ← Response Body (optional)
```

---

## Section 1 — Status Line

The **first line** of every HTTP response. Always present. Contains:

| Component | Example | Description |
|---|---|---|
| **HTTP Version** | `HTTP/1.1` | Protocol version used |
| **Status Code** | `200` | Numeric result of the request |
| **Status Text** | `OK` | Human-readable meaning of the code |

---

## HTTP Status Codes

| Code | Name | Meaning |
|---|---|---|
| **200** | OK | Request successful — server returned the requested resource |
| **301** | Moved Permanently | Resource permanently moved to new URL — client should use new URL for all future requests |
| **302** | Found | Resource temporarily at a different URL — common redirect; web proxies like Burp Suite will show many of these during testing |
| **400** | Bad Request | Server could not understand the request — malformed syntax or invalid request |
| **401** | Unauthorized | Authentication required at the **web server level** — valid credentials must be provided to access the resource |
| **403** | Forbidden | Server understood the request but refuses to authorize it — you're authenticated but don't have permission for this resource |
| **404** | Not Found | Requested resource does not exist on the server — request itself is valid |
| **405** | Method Not Allowed | The HTTP method used is not supported for the requested resource |
| **500** | Internal Server Error | Server encountered an error while processing the request — not a client error |

> During pen testing, **302** redirects in Burp Suite can be followed using "Follow redirects." **403** means the resource exists but access is denied — worth probing further. **500** can indicate server-side errors triggered by your input.

---

## Section 2 — Response Headers

| Header | Purpose | Security Relevance |
|---|---|---|
| **Date** | Timestamp of when the response was generated | Useful for time-based SQLi — monitor response time between request and this timestamp |
| **Server** | Reveals the web server technology and version (e.g., `Apache/2.4.7`) | Information disclosure — often disabled on hardened servers |
| **X-Powered-By** | Reveals the server-side scripting language (e.g., `PHP/5.5.9`) | Information disclosure — reveals backend language and potentially vulnerable version |
| **Content-Type** | Media type of the response body (e.g., `text/html`, `application/json`) | Tells the browser how to render/parse the body |
| **Content-Encoding** | Compression format used (e.g., `gzip`) | Browser decodes before rendering; Wireshark shows raw encoded data |
| **Content-Length** | Size of the response body in bytes | Browser uses this to know when the full response has been received |
| **Set-Cookie** | Sends a cookie to the browser to store and include in future requests | Primary session management mechanism — target for cookie theft/hijacking |
| **Cache-Control** | Instructs the browser on caching behavior for this response | Incorrect caching of sensitive pages can expose data to other users |

> **Server** and **X-Powered-By** headers are a form of information disclosure. In a real assessment, these are noted during enumeration. On hardened servers they are removed — but many misconfigured servers leave them enabled.

---

## Section 3 — Response Body

Contains the actual content of the response:
- HTML pages (for web page loads)
- JSON/XML data (for API responses)
- File contents (for download requests)
- Error pages (for 4xx/5xx responses)

The body is optional but almost always present. Content is often **encoded** (gzip) — the browser decodes it before rendering.

---

## Cache-Control Directives

The `Cache-Control` response header tells the browser how to cache the response.

| Directive | Meaning |
|---|---|
| **public** | Response can be cached by any intermediary cache (CDNs, proxy servers) and shared across users |
| **private** | Response is specific to a single user — must not be cached by shared/intermediary caches (e.g., Google uses `private` because each user's session is unique) |
| **no-cache** | Browser may store a cache but must **revalidate** with the server before using it |
| **no-store** | Browser must **not cache** the response in any form — every request re-downloads everything |
| **max-age=N** | Response can be cached for N seconds before it expires and must be revalidated |

> **no-store** is typically used for development environments where you want live changes to appear immediately, or for highly sensitive pages where caching any content is unacceptable.

---

## Practical Example — Analyzing a Response with curl

```bash
# Make GET request and see full request + response (verbose)
curl -v http://target.com

# Make HEAD request — response headers only, no body
curl -I http://target.com
# or equivalent:
curl -v -X HEAD http://target.com
```

From the response:
- `Server: Apache/2.4.7` → identifies web server
- `X-Powered-By: PHP/5.5.9-1ubuntu4.29` → identifies backend language + OS hint
- `Set-Cookie: PHPSESSID=...` → session cookie (no `HttpOnly` flag = JS-accessible → XSS risk)
- `Cache-Control: no-cache` → server is instructing browser to revalidate on each request

---

## Key Takeaways

- HTTP responses have **three sections**: status line → headers → body
- **Status line** = HTTP version + numeric status code + text description
- **200** = success; **301/302** = redirect; **400** = bad request; **401** = auth required; **403** = forbidden (resource exists, no permission); **404** = not found; **500** = server error
- **Server** and **X-Powered-By** headers disclose infrastructure info — valuable for targeting attacks
- **Set-Cookie** in a response is how the server establishes a user session — the browser will send this cookie in all future requests
- **Cache-Control** controls browser caching — `private` for user-specific pages, `no-store` for sensitive content
- During pen testing: monitor status codes to understand whether requests are being processed, rejected, or triggering errors
