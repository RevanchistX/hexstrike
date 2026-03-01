# =============================================================================
# HEXSTRIKE AI — Web Penetration Testing Docker Image (Alpine, Slim)
# =============================================================================
# Multi-stage build: Go tools compiled on Alpine, then Python runtime
# Final image: ~580-640 MB (vs 2-4 GB Kali-based, vs 1 GB with Chrome)
# =============================================================================

# ============================================================================
# STAGE 1: Go Tools Builder
# ============================================================================
FROM golang:1.26.0-alpine3.23 AS go-builder

RUN apk add --no-cache git

WORKDIR /build

# Install static Go binaries (CGO_ENABLED=0 for musl compatibility)
# Using stable versions to avoid dependency conflicts
# ============================================================================
# TIER 1: Core tools (already established)
# ============================================================================
RUN CGO_ENABLED=0 go install -ldflags="-s -w" github.com/ffuf/ffuf/v2@v2.1.0 && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/projectdiscovery/httpx/cmd/httpx@v1.4.1 && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/hakluke/hakrawler@latest || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/lc/gau/v2/cmd/gau@latest || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/tomnomnom/waybackurls@latest || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/projectdiscovery/dalfox/cmd/dalfox@v1.4.9 || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/OJ/gobuster/v3@v3.6.0 || true

# ============================================================================
# TIER 2: Advanced Go tools (vulnerability scanning, enumeration, crawling)
# ============================================================================
RUN CGO_ENABLED=0 go install -ldflags="-s -w" github.com/projectdiscovery/nuclei/v3/cmd/nuclei@v3.2.4 || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/projectdiscovery/subfinder/v2/cmd/subfinder@v2.6.6 || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/owasp-amass/amass/v4/...@v4.2.0 || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/hahwul/dalfox/v2@v2.9.2 || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/tomnomnom/anew@latest || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/tomnomnom/qsreplace@latest || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/projectdiscovery/katana/cmd/katana@v1.0.5 || true && \
    CGO_ENABLED=0 go install -ldflags="-s -w" github.com/jaeles-project/jaeles@latest || true && \
    find $(go env GOPATH)/bin -type f -executable 2>/dev/null | head -30

# ============================================================================
# STAGE 2: Final Python Runtime (Alpine)
# ============================================================================
FROM python:3.14.1-alpine3.23

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================
ENV PYTHONIOENCODING=utf-8 \
    PYTHONUNBUFFERED=1 \
    HEXSTRIKE_HOST=0.0.0.0 \
    HEXSTRIKE_PORT=8888 \
    VENV=/opt/hexstrike/venv \
    PATH="/opt/hexstrike/venv/bin:/usr/local/go/bin:/usr/local/bin:$PATH"

WORKDIR /opt/hexstrike

# =============================================================================
# INSTALL RUNTIME DEPENDENCIES (apk)
# =============================================================================
RUN apk add --no-cache \
    ca-certificates \
    git \
    curl \
    wget \
    bash \
    perl \
    libffi \
    openssl \
    libpcap \
    libxml2 \
    libxslt \
    nmap \
    nikto \
    hydra \
    masscan \
    john \
    radare2 \
    gdb \
    binutils \
    exiftool \
    testdisk \
    tcpdump \
    tshark \
    arp-scan \
    samba-client \
    aircrack-ng \
    sleuthkit \
    ruby \
    ruby-bundler \
    file \
    nodejs \
    npm \
    libjpeg-turbo \
    libssh2 \
    tre

# =============================================================================
# INSTALL BUILD DEPENDENCIES (temporary for pip install)
# =============================================================================
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    g++ \
    cmake \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    libpcap-dev \
    curl-dev \
    libxml2-dev \
    libxslt-dev \
    ruby-dev \
    autoconf \
    automake \
    make \
    rust \
    cargo \
    libjpeg-turbo-dev \
    zlib-dev \
    tre-dev \
    libssh2-dev

# =============================================================================
# CREATE VENV AND INSTALL PYTHON PACKAGES
# =============================================================================
RUN python -m venv $VENV && \
    $VENV/bin/pip install --upgrade pip setuptools wheel

# Core framework dependencies
RUN $VENV/bin/pip install \
    "flask>=2.3.0,<4.0.0" \
    "requests>=2.31.0,<3.0.0" \
    "psutil>=5.9.0,<6.0.0" \
    "fastmcp>=0.2.0,<1.0.0"

# Web scraping & automation
RUN $VENV/bin/pip install \
    "beautifulsoup4>=4.12.0,<5.0.0" \
    "selenium>=4.15.0,<5.0.0" \
    "webdriver-manager>=4.0.0,<5.0.0" \
    "websocket-client>=1.9.0"

# Async & networking
RUN $VENV/bin/pip install \
    "aiohttp>=3.8.0,<4.0.0"

# Proxy & testing
RUN $VENV/bin/pip install \
    "mitmproxy>=9.0.0,<11.0.0"

# Web security tools (Python packages)
RUN $VENV/bin/pip install \
    sqlmap \
    arjun \
    dirsearch \
    "wfuzz==2.4.4" \
    wafw00f \
    || true

# ParamSpider (install from GitHub since not on PyPI)
RUN cd /tmp && \
    git clone https://github.com/devanshbatham/ParamSpider.git && \
    cd ParamSpider && \
    $VENV/bin/pip install -e . && \
    rm -rf /tmp/ParamSpider || true

# XSSer (install from GitHub since not on PyPI)
RUN cd /tmp && \
    git clone https://github.com/epsylon/xsser.git && \
    cd xsser && \
    $VENV/bin/pip install -e . && \
    rm -rf /tmp/xsser || true

# General security utilities
# Note: pwntools may fail to build on musl (Alpine) due to unicorn dependency
RUN $VENV/bin/pip install \
    "pwntools>=4.10.0,<5.0.0" \
    || echo "Warning: pwntools installation failed (unicorn compatibility issue with musl/Alpine)"

# ============================================================================
# TIER 3: Additional Python packages (OSINT, forensics, exploitation, misc)
# ============================================================================
RUN $VENV/bin/pip install "fierce>=0.1.0" || echo "Warning: fierce failed"
RUN $VENV/bin/pip install "hashid>=3.1.4" || echo "Warning: hashid failed"
RUN $VENV/bin/pip install "volatility3>=2.5.0" || echo "Warning: volatility3 failed"
RUN $VENV/bin/pip install "ROPGadget>=7.3" || echo "Warning: ROPGadget failed"
RUN $VENV/bin/pip install "ropper>=1.13.8" 2>&1 | grep -i "ERROR\|warning" && echo "Warning: ropper (may have failed)" || echo "ropper installed" || true
RUN $VENV/bin/pip install "kube-hunter>=0.6.8" 2>&1 | grep -i "ERROR\|warning" && echo "Warning: kube-hunter (may have failed)" || echo "kube-hunter installed" || true
RUN $VENV/bin/pip install "shodan>=1.31.0" || echo "Warning: shodan failed"
RUN $VENV/bin/pip install "theHarvester" || echo "Warning: theHarvester failed"
RUN $VENV/bin/pip install "patator>=0.9" 2>&1 | grep -i "ERROR\|warning" && echo "Warning: patator (may have failed)" || echo "patator installed" || true
RUN $VENV/bin/pip install "httpie>=3.0.0" || echo "Warning: httpie failed"
RUN cd /tmp && git clone --depth=1 https://github.com/Tib3rius/AutoRecon.git && $VENV/bin/pip install -e AutoRecon && rm -rf /tmp/AutoRecon || echo "Warning: autorecon from GitHub failed"
RUN $VENV/bin/pip install "netexec" || $VENV/bin/pip install "nxc" || echo "Warning: nxc/netexec failed"
RUN $VENV/bin/pip install "uro>=0.1.0" || echo "Warning: uro failed"
RUN $VENV/bin/pip install "hibp" || $VENV/bin/pip install "have-i-been-pwned" || echo "Warning: hibp failed"
RUN $VENV/bin/pip install "censys>=1.0.0" || echo "Warning: censys failed"
RUN $VENV/bin/pip install "sherlock-project>=0.14.0" || echo "Warning: sherlock failed"
RUN $VENV/bin/pip install "checksec" || echo "Warning: checksec failed"
RUN $VENV/bin/pip install "binwalk==2.1.0" || echo "Warning: binwalk failed"
RUN $VENV/bin/pip install "pyjwt>=2.8.0" || echo "Warning: pyjwt failed"

# ============================================================================
# WEB SECURITY & VULNERABILITY SCANNING EXPANSION
# ============================================================================
RUN $VENV/bin/pip install "safety>=2.3.0" || echo "Warning: safety failed"
RUN $VENV/bin/pip install "bandit>=1.7.5" || echo "Warning: bandit failed"
RUN $VENV/bin/pip install "semgrep>=1.45.0" || echo "Warning: semgrep failed"
RUN $VENV/bin/pip install "truffleHog>=2.0.0" || echo "Warning: truffleHog failed"
RUN $VENV/bin/pip install "osv>=0.1.0" || echo "Warning: osv failed"
RUN $VENV/bin/pip install "pip-audit>=2.5.0" || echo "Warning: pip-audit failed"

# Binary analysis (angr would add ~1.5 GB, skipped to keep image slim)
# Optional: include if binary analysis is needed
# RUN $VENV/bin/pip install "angr>=9.2.0,<10.0.0"

# ============================================================================
# TIER 4b: Install retire.js (npm tool for frontend dependency scanning)
# ============================================================================
RUN npm install -g retire || echo "Warning: retire failed"

# =============================================================================
# TIER 4: Ruby Gems (WordPress scanning, WinRM, steganography, ROP)
# =============================================================================
RUN gem install wpscan evil-winrm one_gadget zsteg --no-document 2>/dev/null || \
    echo "Warning: Some Tier 4 gems failed to install"

# =============================================================================
# INSTALL DOTDOTPWN (Perl directory traversal tool)
# =============================================================================
RUN cd /opt && \
    git clone https://github.com/wireghoul/dotdotpwn.git && \
    ln -sf /opt/dotdotpwn/dotdotpwn.pl /usr/local/bin/dotdotpwn && \
    chmod +x /opt/dotdotpwn/dotdotpwn.pl || true

# =============================================================================
# COMPILE TOOLS FROM GITHUB (not available in Alpine apk)
# =============================================================================

# dirb (web directory brute-forcer)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/v0re/dirb.git && \
    cd dirb && \
    autoreconf -i 2>/dev/null && ./configure 2>/dev/null && make 2>/dev/null && \
    cp dirb /usr/local/bin/ && \
    cd / && rm -rf /tmp/dirb || true

# steghide (steganography tool)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/StefanoDeVuono/steghide.git && \
    cd steghide && \
    ./bootstrap 2>/dev/null && ./configure 2>/dev/null && make 2>/dev/null && \
    cp src/steghide /usr/local/bin/ 2>/dev/null && \
    cd / && rm -rf /tmp/steghide || true

# scalpel (file carving)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/sleuthkit/scalpel.git && \
    cd scalpel && \
    ./configure 2>/dev/null && make 2>/dev/null && \
    cp src/scalpel /usr/local/bin/ 2>/dev/null && \
    cd / && rm -rf /tmp/scalpel || true

# outguess (JPEG steganography)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/crorvick/outguess.git && \
    cd outguess && \
    autoreconf -i 2>/dev/null && ./configure 2>/dev/null && make 2>/dev/null && \
    cp outguess /usr/local/bin/ 2>/dev/null && \
    cd / && rm -rf /tmp/outguess || true

# medusa (parallel login brute-forcer)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/jmk-foit/medusa.git && \
    cd medusa && \
    autoreconf -i 2>/dev/null && ./configure 2>/dev/null && make 2>/dev/null && \
    cp medusa /usr/local/bin/ 2>/dev/null && \
    cd / && rm -rf /tmp/medusa || true

# foremost (file carving from raw images)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/korczis/foremost.git && \
    cd foremost && \
    ./configure 2>/dev/null && make 2>/dev/null && \
    cp foremost /usr/local/bin/ && \
    cd / && rm -rf /tmp/foremost || true

# hashpump (hash length extension attack)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/bwall/HashPump.git && \
    cd HashPump && \
    make 2>/dev/null && cp hashpump /usr/local/bin/ && \
    cd / && rm -rf /tmp/HashPump || true

# bulk-extractor (feature extraction from disk images)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/simsong/bulk_extractor.git && \
    cd bulk_extractor && \
    ./configure 2>/dev/null && make 2>/dev/null && \
    cp src/bulk_extractor /usr/local/bin/ 2>/dev/null && \
    cd / && rm -rf /tmp/bulk_extractor || true

# hashcat-utils (hashcat utilities)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/hashcat/hashcat-utils.git && \
    cd hashcat-utils/src && \
    make 2>/dev/null && cp *.bin /usr/local/bin/ 2>/dev/null && \
    cd / && rm -rf /tmp/hashcat-utils || true

# =============================================================================
# TIER 5: Git Clone Tools (no pip/apk packages available)
# =============================================================================

# enum4linux (Perl SMB enumeration)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/CiscoCXSecurity/enum4linux.git && \
    cp enum4linux/enum4linux.pl /usr/local/bin/enum4linux && \
    chmod +x /usr/local/bin/enum4linux && \
    rm -rf /tmp/enum4linux || true

# enum4linux-ng (Python rewrite)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/cddmp/enum4linux-ng.git && \
    $VENV/bin/pip install -e enum4linux-ng && \
    rm -rf /tmp/enum4linux-ng || true

# smbmap (SMB share enumeration)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/ShawnDEvans/smbmap.git && \
    $VENV/bin/pip install -e smbmap && \
    rm -rf /tmp/smbmap || true

# searchsploit / ExploitDB (~60 MB offline DB)
RUN cd /opt && \
    git clone --depth=1 https://gitlab.com/exploit-database/exploitdb.git && \
    ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit || true

# libc-database (~50 MB, for ROP/pwn offsets)
RUN cd /opt && \
    git clone --depth=1 https://github.com/niklasb/libc-database.git || true

# recon-ng (OSINT framework)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/lanmaster53/recon-ng.git && \
    $VENV/bin/pip install -e recon-ng && \
    rm -rf /tmp/recon-ng || true

# docker-bench-security (Docker CIS audit)
RUN cd /opt && \
    git clone --depth=1 https://github.com/docker/docker-bench-security.git && \
    ln -sf /opt/docker-bench-security/docker-bench-security.sh /usr/local/bin/docker-bench-security || true

# nbtscan (NetBIOS scanner - requires compilation)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/resurrecting-open-source-projects/nbtscan.git && \
    cd nbtscan && \
    autoreconf -i && ./configure && make && \
    cp nbtscan /usr/local/bin/ && \
    cd / && rm -rf /tmp/nbtscan || true

# responder (LLMNR/NBT-NS poisoner)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/lgandx/Responder.git && \
    cd Responder && \
    $VENV/bin/pip install . && \
    rm -rf /tmp/Responder || true

# spiderfoot (Automated OSINT intelligence platform)
RUN cd /opt && \
    git clone --depth=1 https://github.com/smicallef/spiderfoot.git && \
    $VENV/bin/pip install -r /opt/spiderfoot/requirements.txt || \
    echo "Warning: spiderfoot dependencies partially failed" && \
    ln -sf /opt/spiderfoot/sf.py /usr/local/bin/spiderfoot && \
    chmod +x /opt/spiderfoot/sf.py || true

# jwt_tool (JWT token manipulation and exploitation)
RUN cd /opt && \
    git clone --depth=1 https://github.com/ticarpi/jwt_tool.git && \
    ln -sf /opt/jwt_tool/jwt_tool.py /usr/local/bin/jwt_tool && \
    chmod +x /opt/jwt_tool/jwt_tool.py || true

# graphql-cop (GraphQL API security auditing tool)
RUN cd /opt && \
    git clone --depth=1 https://github.com/dolevf/graphql-cop.git && \
    cd graphql-cop && chmod +x graphql-cop.py && \
    ln -sf /opt/graphql-cop/graphql-cop.py /usr/local/bin/graphql-cop && \
    cd /opt || true

# graphql-scanner (GraphQL endpoint security scanner)
RUN cd /opt && \
    git clone --depth=1 https://github.com/davidfortytwo/graphql-scanner.git && \
    cd graphql-scanner && chmod +x scan.py && \
    ln -sf /opt/graphql-scanner/scan.py /usr/local/bin/graphql-scanner && \
    cd /opt || true

# dnsenum (DNS enumeration - Perl)
RUN cd /tmp && \
    git clone --depth=1 https://github.com/fwaeytens/dnsenum.git && \
    cp dnsenum/dnsenum.pl /usr/local/bin/dnsenum && \
    chmod +x /usr/local/bin/dnsenum && \
    rm -rf /tmp/dnsenum || true


# =============================================================================
# COPY GO BINARIES FROM BUILDER STAGE
# =============================================================================
COPY --from=go-builder /go/bin/* /usr/local/bin/

# =============================================================================
# CREATE SYMLINKS FOR TOOL ALIASES & VOLATILITY
# =============================================================================
RUN $VENV/bin/pip install volatility || echo "volatility2 legacy install" || true
RUN ln -sf $VENV/bin/vol3 /usr/local/bin/vol 2>/dev/null || ln -sf $VENV/bin/volatility /usr/local/bin/vol 2>/dev/null || true
RUN ln -sf $VENV/bin/vol3 /usr/local/bin/volatility 2>/dev/null || true

# =============================================================================
# INITIALIZE JAELES CONFIG (requires signatures)
# =============================================================================
RUN jaeles config init 2>/dev/null || true

# =============================================================================
# REMOVE BUILD DEPENDENCIES (cleanup)
# =============================================================================
RUN apk del .build-deps

# =============================================================================
# COPY APPLICATION CODE
# =============================================================================
COPY . .

# =============================================================================
# EXPOSE PORT
# =============================================================================
EXPOSE 8888

# =============================================================================
# HEALTHCHECK
# =============================================================================
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8888/health || exit 1

# =============================================================================
# RUN HEXSTRIKE SERVER
# =============================================================================
CMD ["python", "hexstrike_server.py"]
