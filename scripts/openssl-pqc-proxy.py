#!/usr/bin/env python3
"""
PQC TLS Proxy: перенаправляет трафик через OQS-OpenSSL
"""

import subprocess
import sys

def start_proxy():
    cmd = [
        "docker", "run", "--rm", "-p", "443:443",
        "-v", f"{sys.path[0]}/certs:/certs",
        "openquantumsafe/openssl:latest",
        "openssl", "s_server",
        "-cert", "/certs/dilithium.crt",
        "-key", "/certs/dilithium.key",
        "-www", "-tls1_3"
    ]
    print("Запуск PQC TLS прокси на :443...")
    subprocess.run(cmd)

if __name__ == "__main__":
    start_proxy()
