FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    mosquitto-clients \
    curl \
    awscli \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Copy certificates and scripts
COPY certs/ /app/certs/
COPY scripts/ /app/scripts/

# Assign permissions
RUN chmod 400 /app/certs/device.private.key \
    && chmod 400 /app/certs/device.cert.pem

# Set working directory
WORKDIR /app

# Run the script
CMD ["bash", "/app/scripts/simulate_device.sh"]



