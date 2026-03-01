# HexStrike AI - Complete Tool Reference

This document provides a comprehensive list of all 150+ security tools available in HexStrike AI, organized by category with installation method, size, and GitHub repository information.

## Tool Status Legend

- ✅ **Available** — Installed and functional in the Docker image
- 🟡 **Partial/Optional** — Installed but may require configuration, or available via alternative methods
- ❌ **Not Available** — Intentionally excluded due to size, dependencies, or technical constraints

## Categories

| Category | Count | Description |
|----------|-------|-------------|
| Essential | 7 | Core pentesting and scanning tools |
| Network | 9 | Network reconnaissance and enumeration |
| Web Security | 19 | Web application testing and scanning |
| Vulnerability Scanning | 7 | Template-based and automated vulnerability detection |
| Password | 4 | Password cracking and hash identification |
| Binary | 10 | Binary analysis, ROP gadgets, and reverse engineering |
| Forensics | 15 | File recovery, steganography, and memory analysis |
| Cloud | 4 | Kubernetes and Docker security testing |
| OSINT | 11 | Open source intelligence and reconnaissance |
| Exploitation | 2 | Exploit database and payload generation |
| API | 5 | HTTP clients and API testing tools |
| Wireless | 3 | WiFi and wireless security testing |
| Additional | 10 | Miscellaneous utilities and frameworks |

---

## Full Tool Reference Table

| # | Tool | Category | Install Method | Size | Functionality | GitHub Repo | Status |
|---|------|----------|----------------|------|---------------|------------|--------|
| 1 | nmap | essential | `apk add nmap` | ~5 MB | Port scanner, service/OS detection | [https://github.com/nmap/nmap](https://github.com/nmap/nmap) | ✅ |
| 2 | gobuster | essential | `go install github.com/OJ/gobuster@v3.6.0` | ~8 MB | Directory/DNS/vhost brute-force | [https://github.com/OJ/gobuster](https://github.com/OJ/gobuster) | ✅ |
| 3 | dirb | essential | `apk add dirb` | ~2 MB | Classic directory bruteforcer | SourceForge | ✅ |
| 4 | nikto | essential | `apk add nikto` | ~2 MB | Web server vulnerability scanner | [https://github.com/sullo/nikto](https://github.com/sullo/nikto) | ✅ |
| 5 | sqlmap | essential | `pip install sqlmap` | ~10 MB | SQL injection detection/exploitation | [https://github.com/sqlmapproject/sqlmap](https://github.com/sqlmapproject/sqlmap) | ✅ |
| 6 | hydra | essential | `apk add hydra` | ~3 MB | Multi-protocol brute-force login | [https://github.com/vanhauser-thc/thc-hydra](https://github.com/vanhauser-thc/thc-hydra) | ✅ |
| 7 | john | essential | `apk add john` | ~8 MB | Password cracker (dictionary/brute/rule) | [https://github.com/openwall/john](https://github.com/openwall/john) | ✅ |
| 8 | masscan | network | `apk add masscan` | ~1 MB | Async port scanner (millions/sec) | [https://github.com/robertdavidgraham/masscan](https://github.com/robertdavidgraham/masscan) | ✅ |
| 9 | autorecon | network | `pip install autorecon` | ~3 MB | Multi-threaded network recon | [https://github.com/Tib3rius/AutoRecon](https://github.com/Tib3rius/AutoRecon) | ✅ |
| 10 | nbtscan | network | `git clone + autoconf` | ~0.3 MB | NetBIOS network scanner | [https://github.com/resurrecting-open-source-projects/nbtscan](https://github.com/resurrecting-open-source-projects/nbtscan) | ✅ |
| 11 | arp-scan | network | `apk add arp-scan` | ~0.5 MB | ARP-based host discovery | [https://github.com/royhills/arp-scan](https://github.com/royhills/arp-scan) | ✅ |
| 12 | responder | network | `git clone + pip` | ~2 MB | LLMNR/NBT-NS/MDNS poisoner | [https://github.com/lgandx/Responder](https://github.com/lgandx/Responder) | ✅ |
| 13 | nxc | network | `pip install nxc` | ~10 MB | Network execution / post-exploitation | [https://github.com/Pennyw0rth/NetExec](https://github.com/Pennyw0rth/NetExec) | ✅ |
| 14 | enum4linux-ng | network | `git clone + pip` | ~1 MB | SMB/LDAP enumeration (Python) | [https://github.com/cddmp/enum4linux-ng](https://github.com/cddmp/enum4linux-ng) | ✅ |
| 15 | rpcclient | network | `apk add samba-client` | ~8 MB | RPC enumeration via Samba | [https://www.samba.org](https://www.samba.org) | ✅ |
| 16 | enum4linux | network | `git clone` | ~0.3 MB | Legacy SMB/NetBIOS enumeration (Perl) | [https://github.com/CiscoCXSecurity/enum4linux](https://github.com/CiscoCXSecurity/enum4linux) | ✅ |
| 17 | ffuf | web_security | `go install github.com/ffuf/ffuf@v2.1.0` | ~8 MB | Fast web fuzzer (dirs, params, vhosts) | [https://github.com/ffuf/ffuf](https://github.com/ffuf/ffuf) | ✅ |
| 18 | dirsearch | web_security | `pip install dirsearch` | ~3 MB | Web path scanner | [https://github.com/maurosoria/dirsearch](https://github.com/maurosoria/dirsearch) | ✅ |
| 19 | dotdotpwn | web_security | `git clone` | ~1 MB | Directory traversal fuzzer (Perl) | [https://github.com/wireghoul/dotdotpwn](https://github.com/wireghoul/dotdotpwn) | ✅ |
| 20 | xsser | web_security | `git clone + pip` | ~3 MB | XSS scanner and exploitation framework | [https://github.com/epsylon/xsser](https://github.com/epsylon/xsser) | ✅ |
| 21 | wfuzz | web_security | `pip install wfuzz==2.4.4` | ~5 MB | Web application fuzzer | [https://github.com/xmendez/wfuzz](https://github.com/xmendez/wfuzz) | ✅ |
| 22 | gau | web_security | `go install github.com/lc/gau@latest` | ~6 MB | Fetch known URLs from AlienVault/Wayback | [https://github.com/lc/gau](https://github.com/lc/gau) | ✅ |
| 23 | waybackurls | web_security | `go install github.com/tomnomnom/waybackurls@latest` | ~2 MB | Fetch Wayback Machine URLs | [https://github.com/tomnomnom/waybackurls](https://github.com/tomnomnom/waybackurls) | ✅ |
| 24 | arjun | web_security | `pip install arjun` | ~2 MB | HTTP parameter discovery | [https://github.com/s0md3v/Arjun](https://github.com/s0md3v/Arjun) | ✅ |
| 25 | paramspider | web_security | `git clone + pip` | ~1 MB | Parameter mining from Wayback Machine | [https://github.com/devanshbatham/ParamSpider](https://github.com/devanshbatham/ParamSpider) | ✅ |
| 26 | jaeles | web_security | `go install github.com/jaeles-project/jaeles@latest` | ~10 MB | Web vulnerability scanner (needs sigs) | [https://github.com/jaeles-project/jaeles](https://github.com/jaeles-project/jaeles) | ✅ |
| 27 | dalfox | web_security | `go install github.com/hahwul/dalfox@v2.9.2` | ~8 MB | XSS scanning and parameter analysis | [https://github.com/hahwul/dalfox](https://github.com/hahwul/dalfox) | ✅ |
| 28 | httpx | web_security | `go install github.com/projectdiscovery/httpx@v1.4.1` | ~10 MB | HTTP toolkit — probe, fingerprint | [https://github.com/projectdiscovery/httpx](https://github.com/projectdiscovery/httpx) | ✅ |
| 29 | wafw00f | web_security | `pip install wafw00f` | ~2 MB | WAF detection and fingerprinting | [https://github.com/EnableSecurity/wafw00f](https://github.com/EnableSecurity/wafw00f) | ✅ |
| 30 | katana | web_security | `go install github.com/projectdiscovery/katana@v1.0.5` | ~10 MB | Advanced web crawler for attack surface | [https://github.com/projectdiscovery/katana](https://github.com/projectdiscovery/katana) | ✅ |
| 31 | hakrawler | web_security | `go install github.com/hakluke/hakrawler@latest` | ~5 MB | Simple fast web crawler | [https://github.com/hakluke/hakrawler](https://github.com/hakluke/hakrawler) | ✅ |
| 32 | safety | web_security | `pip install safety` | ~2 MB | Python dependency vulnerability scanner | [https://github.com/pyupio/safety](https://github.com/pyupio/safety) | ✅ |
| 33 | bandit | web_security | `pip install bandit` | ~3 MB | Python security linter | [https://github.com/PyCQA/bandit](https://github.com/PyCQA/bandit) | ✅ |
| 34 | semgrep | web_security | `pip install semgrep` | ~50 MB | Static analysis tool for code security | [https://github.com/returntocorp/semgrep](https://github.com/returntocorp/semgrep) | ✅ |
| 35 | truffleHog | web_security | `pip install truffleHog` | ~5 MB | Detect secrets in git repos | [https://github.com/trufflesecurity/trufflehog](https://github.com/trufflesecurity/trufflehog) | ✅ |
| 36 | retire | web_security | `npm install -g retire` | ~5 MB | Frontend dependency vulnerability scanner | [https://github.com/RetireJS/retire.js](https://github.com/RetireJS/retire.js) | ✅ |
| 37 | nuclei | vuln_scanning | `go install github.com/projectdiscovery/nuclei@v3.2.4` | ~20 MB | Template-based vulnerability scanner | [https://github.com/projectdiscovery/nuclei](https://github.com/projectdiscovery/nuclei) | ✅ |
| 38 | wpscan | vuln_scanning | `gem install wpscan` | ~25 MB | WordPress vulnerability scanner | [https://github.com/wpscanteam/wpscan](https://github.com/wpscanteam/wpscan) | ✅ |
| 39 | graphql-cop | vuln_scanning | `git clone` | ~0.5 MB | GraphQL API security auditing | [https://github.com/dolevf/graphql-cop](https://github.com/dolevf/graphql-cop) | ✅ |
| 40 | graphql-scanner | vuln_scanning | `git clone` | ~0.5 MB | GraphQL endpoint security scanner | [https://github.com/davidfortytwo/graphql-scanner](https://github.com/davidfortytwo/graphql-scanner) | ✅ |
| 41 | jwt_tool | vuln_scanning | `git clone` | ~0.5 MB | JWT token manipulation and exploitation | [https://github.com/ticarpi/jwt_tool](https://github.com/ticarpi/jwt_tool) | ✅ |
| 42 | osv | vuln_scanning | `pip install osv` | ~2 MB | Open Source Vulnerabilities checker | [https://github.com/google/osv](https://github.com/google/osv) | ✅ |
| 43 | pip-audit | vuln_scanning | `pip install pip-audit` | ~2 MB | Python package vulnerability scanner | [https://github.com/pypa/pip-audit](https://github.com/pypa/pip-audit) | ✅ |
| 44 | medusa | password | `apk add medusa` | ~3 MB | Parallel brute-force login | [https://github.com/jmk-foit/medusa](https://github.com/jmk-foit/medusa) | ✅ |
| 45 | patator | password | `pip install patator` | ~3 MB | Multi-protocol brute-forcer | [https://github.com/gat3way/patator](https://github.com/gat3way/patator) | ✅ |
| 46 | hash-identifier | password | `pip install hashid` | ~0.5 MB | Identify hash algorithm by format | [https://github.com/psypanda/hashID](https://github.com/psypanda/hashID) | ✅ |
| 47 | hashcat-utils | password | Manual install | ~1 MB | Hashcat helper utilities | [https://github.com/hashcat/hashcat-utils](https://github.com/hashcat/hashcat-utils) | 🟡 |
| 48 | gdb | binary | `apk add gdb` | ~10 MB | GNU debugger | [https://github.com/bminor/gdb](https://github.com/bminor/gdb) | ✅ |
| 49 | radare2 | binary | `apk add radare2` | ~12 MB | Reverse engineering framework | [https://github.com/radareorg/radare2](https://github.com/radareorg/radare2) | ✅ |
| 50 | binwalk | binary | `apk add binwalk` | ~1 MB | Firmware analysis and extraction | [https://github.com/ReFirmLabs/binwalk](https://github.com/ReFirmLabs/binwalk) | ✅ |
| 51 | ropgadget | binary | `pip install ROPGadget` | ~2 MB | ROP chain builder from binaries | [https://github.com/JonathanSalwan/ROPgadget](https://github.com/JonathanSalwan/ROPgadget) | ✅ |
| 52 | checksec | binary | `pip install checksec` | ~0.5 MB | Check ELF binary security mitigations | [https://github.com/slimm609/checksec.sh](https://github.com/slimm609/checksec.sh) | ✅ |
| 53 | objdump | binary | `apk add binutils` | ~5 MB | Binary disassembler/analysis | GNU binutils | ✅ |
| 54 | pwntools | binary | `pip install pwntools` | ~40 MB | CTF/exploit development framework | [https://github.com/Gallopsled/pwntools](https://github.com/Gallopsled/pwntools) | 🟡 |
| 55 | one-gadget | binary | `gem install one_gadget` | ~2 MB | Find libc one-gadget RCE offsets | [https://github.com/david942j/one_gadget](https://github.com/david942j/one_gadget) | ✅ |
| 56 | ropper | binary | `pip install ropper` | ~3 MB | ROP/JOP gadget finder | [https://github.com/sashs/Ropper](https://github.com/sashs/Ropper) | ✅ |
| 57 | libc-database | binary | `git clone` | ~50 MB | Identify libc version from leaked address | [https://github.com/niklasb/libc-database](https://github.com/niklasb/libc-database) | ✅ |
| 58 | volatility3 | forensics | `pip install volatility3` | ~15 MB | Memory forensics analysis framework | [https://github.com/volatilityfoundation/volatility3](https://github.com/volatilityfoundation/volatility3) | ✅ |
| 59 | vol | forensics | Symlink to vol3 | — | Alias for volatility3 CLI | — | ✅ |
| 60 | steghide | forensics | `apk add steghide` | ~1 MB | Steganography embed/extract (JPEG/BMP) | [https://github.com/StefanoDeVuono/steghide](https://github.com/StefanoDeVuono/steghide) | ✅ |
| 61 | hashpump | forensics | Manual compile | ~0.3 MB | Hash length extension attacks | [https://github.com/bwall/HashPump](https://github.com/bwall/HashPump) | 🟡 |
| 62 | foremost | forensics | `apk add foremost` | ~1 MB | File carving from disk images | [https://github.com/korczis/foremost](https://github.com/korczis/foremost) | ✅ |
| 63 | exiftool | forensics | `apk add exiftool` | ~4 MB | Read/write file metadata | [https://github.com/exiftool/exiftool](https://github.com/exiftool/exiftool) | ✅ |
| 64 | strings | forensics | `apk add binutils` | — | Extract printable strings from binary | GNU binutils | ✅ |
| 65 | xxd | forensics | Built-in Alpine/busybox | — | Hex dump tool | — | ✅ |
| 66 | file | forensics | Built-in Alpine | ~1 MB | Identify file type from magic bytes | [https://github.com/file/file](https://github.com/file/file) | ✅ |
| 67 | photorec | forensics | `apk add testdisk` | ~2 MB | File recovery from disk/memory | [https://www.cgsecurity.org](https://www.cgsecurity.org) | ✅ |
| 68 | testdisk | forensics | `apk add testdisk` | ~2 MB | Disk partition recovery | [https://www.cgsecurity.org](https://www.cgsecurity.org) | ✅ |
| 69 | scalpel | forensics | `apk add scalpel` | ~1 MB | File carving from raw disk images | [https://github.com/sleuthkit/scalpel](https://github.com/sleuthkit/scalpel) | ✅ |
| 70 | bulk-extractor | forensics | Manual compile | ~5 MB | Extract features from disk images | [https://github.com/simsong/bulk_extractor](https://github.com/simsong/bulk_extractor) | 🟡 |
| 71 | zsteg | forensics | `gem install zsteg` | ~1 MB | PNG/BMP steganography detection | [https://github.com/zardus/zsteg](https://github.com/zardus/zsteg) | ✅ |
| 72 | outguess | forensics | `apk add outguess` | ~0.5 MB | JPEG steganography | [https://github.com/crorvick/outguess](https://github.com/crorvick/outguess) | ✅ |
| 73 | kube-hunter | cloud | `pip install kube-hunter` | ~5 MB | Kubernetes penetration testing | [https://github.com/aquasecurity/kube-hunter](https://github.com/aquasecurity/kube-hunter) | ✅ |
| 74 | docker-bench-security | cloud | `git clone` | ~1 MB | Docker CIS benchmark audit script | [https://github.com/docker/docker-bench-security](https://github.com/docker/docker-bench-security) | ✅ |
| 75 | amass | osint | `go install github.com/owasp-amass/amass/v4@v4.2.0` | ~20 MB | Deep subdomain enumeration + OSINT | [https://github.com/owasp-amass/amass](https://github.com/owasp-amass/amass) | ✅ |
| 76 | subfinder | osint | `go install github.com/projectdiscovery/subfinder@v2.6.6` | ~10 MB | Fast passive subdomain discovery | [https://github.com/projectdiscovery/subfinder](https://github.com/projectdiscovery/subfinder) | ✅ |
| 77 | fierce | osint | `pip install fierce` | ~2 MB | DNS recon and subdomain enumeration | [https://github.com/mschwager/fierce](https://github.com/mschwager/fierce) | ✅ |
| 78 | dnsenum | osint | `git clone` | ~1 MB | DNS enumeration Perl script | [https://github.com/fwaeytens/dnsenum](https://github.com/fwaeytens/dnsenum) | ✅ |
| 79 | theharvester | osint | `pip install theHarvester` | ~8 MB | Email/host/domain OSINT harvesting | [https://github.com/laramies/theHarvester](https://github.com/laramies/theHarvester) | ✅ |
| 80 | sherlock | osint | `pip install sherlock-project` | ~3 MB | Username hunt across 400+ sites | [https://github.com/sherlock-project/sherlock](https://github.com/sherlock-project/sherlock) | ✅ |
| 81 | recon-ng | osint | `git clone + pip` | ~5 MB | Modular OSINT recon framework | [https://github.com/lanmaster53/recon-ng](https://github.com/lanmaster53/recon-ng) | ✅ |
| 82 | spiderfoot | osint | `git clone + pip` | ~100 MB | Automated OSINT intelligence platform | [https://github.com/smicallef/spiderfoot](https://github.com/smicallef/spiderfoot) | ✅ |
| 83 | shodan-cli | osint | `pip install shodan` | ~3 MB | Shodan internet search API | [https://github.com/achillean/shodan-python](https://github.com/achillean/shodan-python) | ✅ |
| 84 | censys-cli | osint | `pip install censys` | ~5 MB | Censys internet search API | [https://github.com/censys/censys-python](https://github.com/censys/censys-python) | ✅ |
| 85 | have-i-been-pwned | osint | `pip install hibp` | ~1 MB | Check emails against HIBP breach data | [https://github.com/justinforce/hibp](https://github.com/justinforce/hibp) | ✅ |
| 86 | exploit-db | exploitation | `git clone` | ~60 MB | Offline exploit database (via searchsploit) | [https://gitlab.com/exploit-database/exploitdb](https://gitlab.com/exploit-database/exploitdb) | ✅ |
| 87 | searchsploit | exploitation | `git clone` | ~60 MB | ExploitDB offline search CLI | [https://gitlab.com/exploit-database/exploitdb](https://gitlab.com/exploit-database/exploitdb) | ✅ |
| 88 | curl | api | `apk add curl` | ~0.5 MB | HTTP requests CLI | [https://github.com/curl/curl](https://github.com/curl/curl) | ✅ |
| 89 | httpie | api | `pip install httpie` | ~5 MB | User-friendly HTTP CLI client | [https://github.com/httpie/httpie](https://github.com/httpie/httpie) | ✅ |
| 90 | anew | api | `go install github.com/tomnomnom/anew@latest` | ~1 MB | Append unique lines (pipeline dedup) | [https://github.com/tomnomnom/anew](https://github.com/tomnomnom/anew) | ✅ |
| 91 | qsreplace | api | `go install github.com/tomnomnom/qsreplace@latest` | ~1 MB | Replace query string values in URLs | [https://github.com/tomnomnom/qsreplace](https://github.com/tomnomnom/qsreplace) | ✅ |
| 92 | uro | api | `pip install uro` | ~0.5 MB | URL deduplication/normalization | [https://github.com/s0md3v/uro](https://github.com/s0md3v/uro) | ✅ |
| 93 | tshark | wireless | `apk add tshark` | ~5 MB | CLI packet analyzer (Wireshark) | [https://gitlab.com/wireshark/wireshark](https://gitlab.com/wireshark/wireshark) | ✅ |
| 94 | tcpdump | wireless | `apk add tcpdump` | ~1 MB | CLI packet capture | [https://github.com/the-tcpdump-group/tcpdump](https://github.com/the-tcpdump-group/tcpdump) | ✅ |
| 95 | aircrack-ng | wireless | `apk add aircrack-ng` | ~4 MB | WPA/WEP cracking suite | [https://github.com/aircrack-ng/aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) | ✅ |
| 96 | smbmap | additional | `git clone + pip` | ~1 MB | SMB share enumeration and access | [https://github.com/ShawnDEvans/smbmap](https://github.com/ShawnDEvans/smbmap) | ✅ |
| 97 | volatility | additional | Legacy (use volatility3) | — | Memory forensics (legacy v2) | — | ❌ |
| 98 | sleuthkit | additional | `apk add sleuthkit` | ~5 MB | Digital forensics CLI toolkit | [https://github.com/sleuthkit/sleuthkit](https://github.com/sleuthkit/sleuthkit) | ✅ |
| 99 | evil-winrm | additional | `gem install evil-winrm` | ~5 MB | WinRM shell for pentesters | [https://github.com/Hackplayers/evil-winrm](https://github.com/Hackplayers/evil-winrm) | ✅ |
| 100 | airmon-ng | additional | `apk add aircrack-ng` | — | WiFi monitor mode (part of aircrack-ng) | [https://github.com/aircrack-ng/aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) | ✅ |
| 101 | airodump-ng | additional | `apk add aircrack-ng` | — | WiFi packet capture (part of aircrack-ng) | [https://github.com/aircrack-ng/aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) | ✅ |
| 102 | aireplay-ng | additional | `apk add aircrack-ng` | — | WiFi packet injection (part of aircrack-ng) | [https://github.com/aircrack-ng/aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) | ✅ |

---

## Installation Methods

### apk add (Alpine Package Manager)
Fast, reliable installation of pre-compiled binaries. Recommended for stable tools without complex dependencies.

### pip install (Python Package Manager)
Most web security, OSINT, and forensics tools are Python-based. Installed in isolated venv at `/opt/hexstrike/venv`.

### go install (Go Toolchain)
Static-compiled Go binaries with no runtime dependencies. Ideal for production Docker use.

### gem install (Ruby Gems)
WordPress scanning, WinRM, and steganography tools. Minimal overhead (~30 MB total).

### npm install -g (Node.js Package Manager)
Frontend security tools like Retire.js for JavaScript dependency scanning.

### git clone + Compilation
For tools unavailable in package managers. Compiled during build, source cleaned up to minimize image size.

---

## Notable Exclusions

| Tool | Reason | Alternative |
|------|--------|-------------|
| **Metasploit** | ~1.2 GB (Ruby + PostgreSQL framework) | Use separate `metasploitframework/metasploit-framework` container |
| **Wireshark** | 50 MB GUI-only | Use `tshark` (CLI, ~5 MB) |
| **OWASP ZAP** | 300 MB Java GUI | Use separate `zaproxy/zaproxy` container |
| **Burp Suite** | ~300 MB commercial GUI | Use separate container or free community version |
| **Ghidra** | ~600 MB Java GUI reverse engineer | Not worth headless mode; use separate container |
| **angr** | ~1.5 GB binary analysis (bloats image) | Install on-demand if needed |
| **Hashcat** | Requires GPU/OpenCL hardware | CPU-based: use `john` or `hydra` instead |
| **Rust-based tools** (Feroxbuster, rustscan, x8) | Rust toolchain adds ~300 MB bloat | Use Go/Python alternatives instead |
| **Cloud SDKs** (Prowler, Scout Suite) | 80-100 MB each | Use dedicated security containers |

---

## Version Pinning

Critical tools are pinned to stable versions to avoid breaking changes:

- **dalfox**: v2.9.2 (not v1.4.9)
- **katana**: v1.0.5 (avoids go-tree-sitter issues)
- **nuclei**: v3.2.4 (latest stable)
- **subfinder**: v2.6.6 (stable subdomain enum)
- **wfuzz**: 2.4.4 (compatibility with Alpine)
- **amass**: v4.2.0 (latest stable)

---

## Quick Tool Lookup by Function

### Port Scanning
`nmap`, `masscan`

### Web Fuzzing
`ffuf`, `wfuzz`, `dirb`, `dirsearch`

### Subdomain Enumeration
`subfinder`, `amass`, `fierce`, `dnsenum`

### Vulnerability Scanning
`nuclei`, `wpscan`, `nikto`

### SQL Injection
`sqlmap`

### XSS Detection
`dalfox`, `xsser`

### Password Cracking
`hydra`, `john`, `medusa`, `patator`

### ROP Gadget Finding
`ropgadget`, `ropper`, `one-gadget`

### Memory Forensics
`volatility3` (vol alias)

### Steganography
`steghide`, `zsteg`, `outguess`

### SMB/LDAP Enumeration
`enum4linux`, `enum4linux-ng`, `smbmap`, `rpcclient`

### OSINT
`recon-ng`, `spiderfoot`, `theHarvester`, `sherlock`

### API Testing
`httpie`, `curl`, `anew`, `qsreplace`

### Reverse Engineering
`radare2`, `gdb`, `binwalk`, `checksec`

---

## Support & Documentation

For issues with a specific tool, consult:
1. Tool's GitHub repository (see table above)
2. `docker exec hexstrike-ai <tool> --help`
3. HexStrike AI server health check: `curl http://localhost:8888/health`

---

*Last Updated: 2026-03-01*
