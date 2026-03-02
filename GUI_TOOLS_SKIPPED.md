# GUI Tools Skipped from HexStrike AI

This document tracks GUI applications, commercial software, and fictional CLI tools that were removed from the `/health` endpoint health check in `hexstrike_server.py`. These tools cannot be executed in containerized environments or have no CLI binary equivalent.

## Summary
- **Total removed:** 19 entries across 8 tool categories
- **Reason:** GUI-only, commercial, infeasible in Docker, or no `which`-able binary
- **Last updated:** 2026-03-01

## Removed Tools

| Tool | Category | Reason | Notes |
|---|---|---|---|
| `burpsuite` | web_security | Commercial Java GUI | Burp Suite Professional/Community requires browser interaction; use `httpx`, `ffuf`, or `feroxbuster` instead |
| `zaproxy` | web_security | Java GUI (OWASP ZAP) | Desktop application; use `httpx`, `ffuf`, or `dirsearch` for similar functionality |
| `ghidra` | binary | Java GUI RE tool | NSA reverse engineering tool; desktop-only; use `radare2` or `gdb` as CLI alternatives |
| `angr` | binary | Python library only, no CLI | Binary analysis framework; no standalone binary; can use `radare2` for symbolic execution |
| `stegsolve` | forensics | Java GUI | Steganography image analysis tool; use `zsteg` or `outguess` instead |
| `scout-suite` | cloud | Binary name mismatch + needs credentials | Binary is `scout` not `scout-suite`; also requires AWS/Azure/GCP credentials |
| `falco` | cloud | Kernel module/eBPF, infeasible in Docker | Runtime security monitoring requires host kernel integration; not available in standard containers |
| `clair` | cloud | Server daemon, not a CLI tool | Container image scanner runs as a service; not a command-line binary |
| `social-analyzer` | osint | Web UI tool, no `which`-able binary | Social media OSINT tool with web interface; no standalone CLI |
| `maltego` | osint | Commercial Java GUI | Graphical OSINT platform; desktop application only |
| `api-schema-analyzer` | api | Not a real installable binary | Fictional tool name; no public repository or package |
| `postman` | api | Electron GUI REST client | Desktop application; use `curl`, `httpie`, or `httpx` instead |
| `insomnia` | api | Electron GUI REST client | Desktop REST client; use `curl`, `httpie`, or `httpx` instead |
| `kismet` | wireless | Needs physical wireless hardware | Wireless network detector; requires actual WiFi interface; not functional in containerized environments |
| `wireshark` | wireless | Qt GUI packet analyzer | Desktop GUI; use `tshark` (CLI equivalent) instead |
| `autopsy` | additional | Java/NetBeans GUI forensics | Digital forensics GUI; use `sleuthkit` CLI tools instead |
| `graphql-scanner` (old) | vuln_scanning + additional | Fictional name; replaced with real tools | Removed and replaced with `graphql-scanner` (GitHub: davidfortytwo) and `graphql-cop` (GitHub: dolevf) |
| `jwt-analyzer` | vuln_scanning + additional | Fictional name; replaced with real tools | Removed and replaced with `jwt_tool` (ticarpi/jwt_tool) and `jwtxpl` (jwtxploiter pip package) |

## Replaced Tools

The following tools were removed because they were fictional CLI names, but real alternatives were installed:

### JWT Security
- **Removed:** `jwt-analyzer`
- **Installed:**
  - `jwt_tool` — JWT manipulation & testing (git clone: ticarpi/jwt_tool)
  - `jwtxpl` — JWT exploitation framework (pip: jwtxploiter)
- **Installation:** Dockerfile lines 70–77

### GraphQL Security
- **Removed:** `graphql-scanner` (old fictional name)
- **Installed:**
  - `graphql-scanner` — GraphQL endpoint scanner (git clone: davidfortytwo/graphql-scanner)
  - `graphql-cop` — GraphQL security auditor (git clone: dolevf/graphql-cop)
- **Installation:** Dockerfile lines 70–77

## Alternatives for Common Use Cases

| Removed Tool | Use Case | Recommended CLI Alternatives |
|---|---|---|
| Burpsuite | Web vulnerability scanning | `httpx`, `ffuf`, `feroxbuster`, `nuclei` |
| ZAProxy | Web proxy + scanning | `mitmproxy`, `ffuf`, `feroxbuster` |
| Ghidra | Binary reverse engineering | `radare2`, `gdb`, `objdump`, `binutils` |
| Stegsolve | Steganography detection | `zsteg`, `outguess`, `steghide` |
| Maltego | OSINT reconnaissance | `amass`, `subfinder`, `theharvester`, `shodan-cli` |
| Postman/Insomnia | API testing | `curl`, `httpie`, `httpx` |
| Wireshark | Packet analysis | `tshark`, `tcpdump` |

## Architecture Notes

- **GUI tools cannot run in headless Docker containers** without X11 forwarding or virtual displays
- **Java GUI tools** (Burp, ZAP, Ghidra, Autopsy) require GUI environments and are unsuitable for cloud deployments
- **Commercial tools** (Burp Suite Pro, Maltego) require licenses and are not suitable for open-source Docker images
- **Hardware-dependent tools** (Kismet, WiFi scanners) cannot function in containerized environments without host device access

## Future Improvements

If CLI alternatives become available for these tools, consider:
1. **Burpsuite Community:** Unofficial CLI wrapper projects may emerge
2. **Wireshark:** Already has `tshark` (installed and available)
3. **Falco:** May support container-based execution in future updates

For reference, see the current health check implementation in `hexstrike_server.py` function `health_check()` (lines ~9031–9095).
