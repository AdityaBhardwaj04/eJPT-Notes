---
title: HTTP Requests
tags: [eJPT, WebApp, HTTP, Requests, Headers, Methods, GET, POST, PUT, DELETE, OPTIONS]
created: 2026-06-21
source: Transcripts
---

# HTTP Requests

**Related:** [[Introduction-to-HTTP]] | [[HTTP-Responses]] | [[HTTP-Basics-Lab]] | [[00-INDEX]]

---

## Structure of an HTTP Request

Every HTTP request has exactly **three sections** in this order:

```
GET /login.php HTTP/1.1                    ← Request Line
Host: example.com                          ← Request Headers (start)
User-Agent: Mozilla/5.0 (Windows NT 10.0)
Accept: text/html,application/xhtml+xml
Accept-Encoding: gzip, deflate
Connection: keep-alive
                                           ← Blank line separates headers from body
username=test&password=test                ← Request Body (optional)
```

---

## Section 1 — Request Line

The **first line** of every HTTP request. Always present. Contains three components:

| Component | Example | Description |
|---|---|---|
| **HTTP Method** | `GET` | The type of operation being requested |
| **URI / Resource** | `/login.php` | The specific resource path (NOT the domain — that's in the Host header) |
| **HTTP Version** | `HTTP/1.1` | Protocol version browser will use to communicate |

> The domain goes in the `Host` header; the resource path (after the domain) goes in the request line URI. Web server combines them: `Host: example.com` + URI `/login.php` = `example.com/login.php`

---

## Section 2 — Request Headers

Headers provide **additional context** about the request. Format: `Header-Name: value`

| Header | Purpose | Security Relevance |
|---|---|---|
| **Host** | Specifies the domain/IP of the target server. Allows one server to host multiple sites (virtual hosting) | Manipulating it can cause host header injection |
| **User-Agent** | Identifies the browser, OS, and browser engine making the request | Can be spoofed to change what version of a site the server returns |
| **Accept** | File formats the browser will accept in the response (e.g., `text/html`) | Changing it can affect what data the server returns |
| **Accept-Encoding** | Compression formats the browser supports (e.g., `gzip`) | Server will encode response body in this format |
| **Authorization** | Carries credentials for HTTP-level authentication | Sent in clear text over HTTP — reason HTTPS is critical |
| **Cookie** | Session data stored by the browser and sent back with every request after the server sets it | Primary target for session hijacking attacks |
| **Connection** | `keep-alive` (HTTP 1.1) tells the server to maintain the TCP connection for future requests | `close` terminates the connection after this request |

> `Authorization` and `Cookie` headers are **not always present** — only included when authentication or session tracking is needed.

---

## Section 3 — Request Body

Optional. Only used with specific HTTP methods that send data **to** the server (POST, PUT).

- Credentials on login forms → sent in the body as form data: `username=test&password=test`
- File uploads → file data is placed in the body
- API requests → JSON/XML data sent in the body

---

## HTTP Methods (Verbs)

The method tells the server **what operation** to perform on the specified resource.

| Method | Purpose | Notes |
|---|---|---|
| **GET** | Retrieve a resource from the server | Default method when loading a page; no request body; does not modify server state |
| **POST** | Submit data to be processed by the server | Used for logins, form submissions, file uploads; includes a request body |
| **PUT** | Upload or replace a resource at the specified URL | Used to upload files to a server; can create a resource if it doesn't exist |
| **DELETE** | Remove the resource at the specified URL | Dangerous if allowed on directories without authentication |
| **PATCH** | Apply partial modifications to a resource | Similar to PUT but only updates specific fields, not the entire resource |
| **HEAD** | Same as GET but server only returns **response headers**, not the body | Used to check if a resource exists, check modification date, or analyze headers without downloading content |
| **OPTIONS** | Query what HTTP methods are supported for the specified resource | Critical for pen testing — reveals if dangerous methods like PUT/DELETE are enabled on a directory |

---

## Why HTTP Methods Matter for Pen Testing

**OPTIONS** is a key enumeration technique:

```bash
# Check supported methods on a resource
curl -v -X OPTIONS http://target.com/uploads/
# If response "Allow:" header includes PUT, DELETE — potential file upload/deletion vulnerability
```

**PUT** — if enabled on a directory without auth, you can upload files (e.g., a PHP web shell):

```bash
curl http://target.com/uploads/ --upload-file shell.php
```

**DELETE** — if enabled, authenticated or unauthenticated users can delete server files.

> When you see a directory during enumeration, always check what methods it supports with OPTIONS. If PUT is in the `Allow:` response header, test whether you can upload a file.

---

## Practical Example — What a GET Request Looks Like

When you navigate to `google.com` in a browser:

```
GET / HTTP/1.1
Host: google.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip, deflate
Connection: keep-alive
```

- `GET /` → retrieve the homepage (root resource)
- No body — GET requests don't send data

---

## Practical Example — What a POST Request Looks Like

When you submit a login form:

```
POST /login.php HTTP/1.1
Host: target.com
User-Agent: Mozilla/5.0
Content-Type: application/x-www-form-urlencoded
Content-Length: 27
Cookie: PHPSESSID=abc123
Connection: keep-alive

name=admin&password=secret
```

- `POST /login.php` → sending data to the login handler
- Credentials in the **body**, not the URL
- `Content-Type` header tells the server the body is URL-encoded form data

---

## Key Takeaways

- HTTP requests have **three sections**: request line → headers → body (optional)
- **Request line** = method + URI resource path + HTTP version
- **Host header** = domain; URI in request line = resource path — the server combines them
- **GET** = retrieve (no body); **POST** = send data (body); **PUT** = upload file; **DELETE** = remove; **HEAD** = headers only; **OPTIONS** = enumerate allowed methods
- **OPTIONS** is a critical pen testing technique — check if dangerous methods (PUT/DELETE) are enabled on directories
- Credentials in login forms travel in the **POST request body** — interceptable with Burp Suite or Wireshark over plain HTTP
