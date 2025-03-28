# IoT Simulator

A simple IoT device simulator that sends temperature and humidity data to AWS IoT Core using MQTT protocol.

## Overview

This project simulates an IoT weather station device that periodically sends temperature and humidity readings to AWS IoT Core. The simulator uses the MQTT protocol via mosquitto clients to publish messages to a specified topic.

## Prerequisites

- AWS IoT Core account with configured device
- AWS IoT device certificates:
  - `device.cert.pem` (Device certificate)
  - `device.private.key` (Device private key)
  - `root-CA.crt` (AWS IoT Root CA certificate)
- Docker and Docker Compose (optional, for containerized deployment)

## Installation

### Linux

1. Install required dependencies:

   ```bash
   sudo apt-get update
   sudo apt-get install -y mosquitto-clients curl
   ```

2. Clone the repository:

   ```bash
   git clone https://your-repository-url/iot-simulator.git
   cd iot-simulator
   ```

3. Place your AWS IoT certificates in the `certs` directory:
   ```bash
   mkdir -p certs
   # Copy your certificates to the certs directory
   # Ensure proper permissions
   chmod 400 certs/device.private.key
   chmod 400 certs/device.cert.pem
   ```

### macOS

1. Install required dependencies using Homebrew:

   ```bash
   brew update
   brew install mosquitto curl
   ```

2. Clone the repository:

   ```bash
   git clone https://your-repository-url/iot-simulator.git
   cd iot-simulator
   ```

3. Place your AWS IoT certificates in the `certs` directory:
   ```bash
   mkdir -p certs
   # Copy your certificates to the certs directory
   # Ensure proper permissions
   chmod 400 certs/device.private.key
   chmod 400 certs/device.cert.pem
   ```

## Configuration

1. Edit the `scripts/simulate_device.sh` file to adjust simulation parameters:

   - `TOPIC`: The MQTT topic to publish to
   - `MAX_MESSAGES`: Number of messages to send
   - Sleep time between messages (default: 2 seconds)

2. Set your AWS IoT endpoint as an environment variable:
   ```bash
   export AWS_IOT_ENDPOINT=your-iot-endpoint.iot.region.amazonaws.com
   ```

## Running the Simulator

### Directly on the Host

1. Make the script executable:

   ```bash
   chmod +x scripts/simulate_device.sh
   ```

2. Run the simulation script:
   ```bash
   ./scripts/simulate_device.sh
   ```

### Using Docker

1. Build and run using Docker Compose:

   ```bash
   docker-compose up --build
   ```

2. To stop the simulator:
   ```bash
   docker-compose down
   ```

## Understanding simulate_device.sh

The `simulate_device.sh` script performs the following operations:

1. Reads configuration from environment variables or uses default values
2. Generates random temperature (20-40°C) and humidity (50-90%) values
3. Creates a timestamp in ISO format
4. Publishes a JSON message to AWS IoT Core using MQTT protocol
5. Repeats the process for a specified number of times with a delay between messages

Example message format:

```json
{
  "device_id": "station_test",
  "timestamp": "2023-04-01T12:34:56Z",
  "temperature": 25,
  "humidity": 65
}
```

## Troubleshooting

- **Connection Issues**: Verify that your AWS IoT endpoint is correct and accessible
- **Certificate Problems**: Ensure certificates have proper permissions and are in the correct location
- **MQTT Client Errors**: Check that mosquitto-clients is properly installed
- **Docker Errors**: Verify that Docker and Docker Compose are correctly installed and running

## Security Notes

- The certificates in the `certs` directory are excluded from git by `.gitignore`
- Always protect your device private key and certificates
- In production environments, consider using more secure methods to manage secrets
