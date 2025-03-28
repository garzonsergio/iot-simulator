#!/bin/bash

ENDPOINT=$AWS_IOT_ENDPOINT
TOPIC="estaciones/station_test/data"
CA_FILE="/app/certs/root-CA.crt"
CERT_FILE="/app/certs/device.cert.pem"
KEY_FILE="/app/certs/device.private.key"

# Messages count
MAX_MESSAGES=1
COUNT=1

while [ $COUNT -le $MAX_MESSAGES ]; do
# Create random values for temperature and humidity
  TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  TEMPERATURE=$(shuf -i 20-40 -n 1)
  HUMIDITY=$(shuf -i 50-90 -n 1)

  mosquitto_pub \
    -h "$ENDPOINT" \
    -p 8883 \
    -t "$TOPIC" \
    -i "station_test_client" \
    -m "{\"device_id\": \"station_test\", \"timestamp\": \"$TIMESTAMP\", \"temperature\": $TEMPERATURE, \"humidity\": $HUMIDITY}" \
    --cafile "$CA_FILE" \
    --cert "$CERT_FILE" \
    --key "$KEY_FILE" \
    --tls-version tlsv1.2 \
    -d

  echo "Mensaje $COUNT enviado. Restantes: $((MAX_MESSAGES - COUNT))"
  COUNT=$((COUNT + 1))
  sleep 2  # Wait 2 seconds between messages (adjust as needed)
done

echo "¡Se enviaron $MAX_MESSAGES mensajes!"