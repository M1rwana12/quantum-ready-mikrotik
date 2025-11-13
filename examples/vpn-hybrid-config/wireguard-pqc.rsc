# Гибридный WireGuard: классика + PQC прокси
/interface wireguard
add name=wg-pqc private-key="..." listen-port=51820

/ip address
add address=10.0.0.1/24 interface=wg-pqc

# Проксируем через PQC TLS
/ip firewall nat
add chain=dstnat dst-port=443 protocol=tcp action=dst-nat to-addresses=127.0.0.1 to-ports=8443
