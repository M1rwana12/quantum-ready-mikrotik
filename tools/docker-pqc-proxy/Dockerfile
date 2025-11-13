FROM openquantumsafe/openssl:latest

COPY certs/ /certs/

EXPOSE 443

CMD ["openssl", "s_server", "-cert", "/certs/dilithium.crt", "-key", "/certs/dilithium.key", "-www", "-tls1_3"]
