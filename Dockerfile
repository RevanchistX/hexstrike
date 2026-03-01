# Kali Linux-based HexStrike AI Dockerfile
# Single-stage build with apt packages + Python dependencies
FROM kalilinux/kali-rolling

# Set environment variables
ENV PYTHONIOENCODING=utf-8 \
    PYTHONUNBUFFERED=1 \
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
    nikto gobuster dirb ffuf sqlmap wfuzz dirsearch wafw00f wpscan \
    \
    # Password cracking
    hydra john hashcat medusa patator \
    \
    # SMB & Windows enumeration
    smbmap enum4linux samba-common-bin \
    \
    # Exploitation
    metasploit-framework exploitdb \
    \
    # Wireless security
    aircrack-ng \
    \
    # Forensics & Reverse Engineering
    binwalk foremost scalpel bulk-extractor exiftool steghide testdisk sleuthkit \
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
    # Utilities
    xxd checksec \
    && rm -rf /var/lib/apt/lists/*

# Install Go tools NOT in Kali apt repos
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/tomnomnom/anew@latest && \
    go install github.com/tomnomnom/qsreplace@latest

# Install Python dependencies from requirements.txt
# Use --break-system-packages for Kali compatibility
# Exclude angr (too large ~1.5 GB)
# Note: Upgrade pip first to handle Debian/pip package conflicts
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --break-system-packages --upgrade pip setuptools wheel && \
    grep -v '^angr' /tmp/requirements.txt | pip3 install --break-system-packages --no-cache-dir --ignore-installed -r /dev/stdin && \
    rm /tmp/requirements.txt

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
