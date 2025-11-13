#!/bin/bash
# cert-gen-pqc.sh — генерация PQC-сертификатов через OQS

set -e

echo "Генерация ML-DSA (Dilithium) сертификата..."

# Используем OpenQuantumSafe Docker
docker run --rm -v $(pwd)/certs:/certs openquantumsafe/openssl:latest bash -c "
    mkdir -p /certs &&
    cd /certs &&
    openssl req -x509 -new -newkey dilithium3 -keyout dilithium.key -out dilithium.crt -nodes -subj '/CN=PQC-MikroTik' -days 365
"

echo "Сертификаты созданы в ./certs/"
echo "   dilithium.key"
echo "   dilithium.crt"
echo ""
echo "Загрузи в MikroTik: /certificate import file-name=dilithium.crt"
