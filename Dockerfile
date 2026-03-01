# Kali Linux-based HexStrike AI Dockerfile
# Single-stage build with apt packages + Python dependencies
FROM kalilinux/kali-rolling

# Set environment variables
ENV PYTHONIOENCODING=utf-8 \
    PYTHONUNBUFFERED=1 \
    GOPATH=/go \
    PATH="/go/bin:$PATH"

# Disable SSL verification globally for kali.download mirror
RUN echo 'Acquire::https::kali.download::Verify-Peer "false";' > /etc/apt/apt.conf.d/99verify && \
    echo 'Acquire::https::kali.download::Verify-Host "false";' >> /etc/apt/apt.conf.d/99verify && \
    echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99verify && \
    sed -i 's|http://http.kali.org/kali|https://kali.download/kali|g' /etc/apt/sources.list

# Install system tools and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core system with build tools
    build-essential python3 python3-pip python3-dev golang-go ruby ruby-dev git curl wget \
    \
    # Network & scanning
    nmap masscan arp-scan nbtscan tcpdump tshark \
    \
    # Web security tools
    nikto gobuster dirb ffuf sqlmap wfuzz dirsearch wafw00f wpscan xsser dotdotpwn httpie \
    \
    # Password cracking
    hydra john hashcat medusa patator hashpump hashcat-utils ophcrack hash-identifier \
    \
    # Additional network scanning
    rustscan nxc autorecon \
    \
    # SMB & Windows enumeration
    smbmap enum4linux samba-common-bin enum4linux-ng \
    \
    # Exploitation
    metasploit-framework exploitdb \
    \
    # Wireless security
    aircrack-ng \
    \
    # Forensics & Reverse Engineering
    binwalk foremost scalpel bulk-extractor exiftool steghide testdisk sleuthkit outguess \
    gdb radare2 binutils file \
    \
    # OSINT & Reconnaissance
    amass subfinder theharvester fierce dnsenum recon-ng \
    \
    # Modern Go-based tools (in Kali rolling)
    nuclei feroxbuster hakrawler \
    \
    # Post-exploitation
    evil-winrm responder \
    \
    # Utilities & Container security
    xxd checksec trivy \
    && rm -rf /var/lib/apt/lists/*

# Install Go tools NOT in Kali apt repos
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/tomnomnom/anew@latest && \
    go install github.com/tomnomnom/qsreplace@latest && \
    go install github.com/jaeles-project/jaeles@latest

# Install Ruby gems (CTF/pentest tools)
RUN gem install one-gadget zsteg --no-document

# Download prebuilt binaries from GitHub releases
RUN \
    # pwninit — binary patcher for CTF pwn challenges
    curl -sL https://github.com/io12/pwninit/releases/latest/download/pwninit \
        -o /usr/local/bin/pwninit && chmod +x /usr/local/bin/pwninit && \
    # kube-bench — Kubernetes CIS benchmark
    curl -sL $(curl -s https://api.github.com/repos/aquasecurity/kube-bench/releases/latest \
        | grep 'browser_download_url.*linux_amd64.tar.gz"' | cut -d'"' -f4) \
        | tar -xz -C /usr/local/bin kube-bench && \
    # terrascan — IaC security scanner
    curl -sL $(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest \
        | grep 'browser_download_url.*Linux_x86_64.tar.gz"' | cut -d'"' -f4) \
        | tar -xz -C /usr/local/bin terrascan && \
    # x8 — hidden parameter discovery (Rust)
    curl -sL $(curl -s https://api.github.com/repos/sh1yo/x8/releases/latest \
        | grep 'browser_download_url.*x86_64-linux"' | cut -d'"' -f4) \
        -o /usr/local/bin/x8 && chmod +x /usr/local/bin/x8 && \
    # docker-bench-security — Docker CIS audit script
    curl -sL https://raw.githubusercontent.com/docker/docker-bench-security/main/docker-bench-security.sh \
        -o /usr/local/bin/docker-bench-security && chmod +x /usr/local/bin/docker-bench-security && \
    # libc-database — libc lookup for CTF pwn
    git clone --depth 1 https://github.com/niklasb/libc-database /opt/libc-database && \
    ln -sf /opt/libc-database/get /usr/local/bin/libc-database

# Install Python dependencies from requirements.txt
# Use --break-system-packages for Kali compatibility
# Exclude angr (too large ~1.5 GB)
# Note: Upgrade pip first to handle Debian/pip package conflicts
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --break-system-packages --upgrade pip setuptools wheel && \
    grep -v '^angr' /tmp/requirements.txt | pip3 install --break-system-packages --no-cache-dir --ignore-installed -r /dev/stdin && \
    rm /tmp/requirements.txt

# Fix binary name mismatches for health check compatibility
RUN \
    # exploit-db → searchsploit
    ln -sf /usr/bin/searchsploit /usr/local/bin/exploit-db && \
    # sleuthkit → fls (package installs fls/ils/mmls, not sleuthkit binary)
    ln -sf /usr/bin/fls /usr/local/bin/sleuthkit && \
    # bulk-extractor → bulk_extractor (underscore vs hyphen)
    ln -sf /usr/bin/bulk_extractor /usr/local/bin/bulk-extractor && \
    # ropgadget → ROPgadget (case sensitivity)
    ln -sf /usr/local/bin/ROPgadget /usr/local/bin/ropgadget && \
    # shodan-cli → shodan
    ln -sf /usr/local/bin/shodan /usr/local/bin/shodan-cli && \
    # censys-cli → censys
    ln -sf /usr/local/bin/censys /usr/local/bin/censys-cli && \
    # have-i-been-pwned → hibp
    ln -sf /usr/local/bin/hibp /usr/local/bin/have-i-been-pwned && \
    # volatility3/volatility → vol (volatility3 pip installs vol binary)
    ln -sf /usr/local/bin/vol /usr/local/bin/volatility3 && \
    ln -sf /usr/local/bin/vol /usr/local/bin/volatility && \
    # pwntools → pwn (pwntools pip package installs pwn binary)
    if which pwn > /dev/null 2>&1; then ln -sf $(which pwn) /usr/local/bin/pwntools; fi && \
    # metasploit → msfconsole (metasploit binary doesn't exist, msfconsole does)
    ln -sf /usr/bin/msfconsole /usr/local/bin/metasploit

# Create HexStrike directory
RUN mkdir -p /opt/hexstrike

# Copy HexStrike server files
COPY hexstrike_server.py /opt/hexstrike/hexstrike_server.py
COPY hexstrike_mcp.py /opt/hexstrike/hexstrike_mcp.py
COPY hexstrike-ai-mcp.json /opt/hexstrike/hexstrike-ai-mcp.json

# Set working directory
WORKDIR /opt/hexstrike

# Expose port 8888 for the HexStrike API server
EXPOSE 8888

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8888/health || exit 1

# Default command
CMD ["python3", "/opt/hexstrike/hexstrike_server.py"]
