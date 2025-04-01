Aquí está tu archivo `README.md` bien formateado en Markdown:

```markdown
# Gensyn Testnet Node Setup

This repository provides a simple way to run a Gensyn testnet node using Docker and Docker Compose. Follow the instructions below to set up and run the node on your machine or VPS.

---

## Prerequisites

- A Linux-based system (e.g., Ubuntu) is recommended.
- Docker and Docker Compose installed (see installation instructions below).

Install required packages:
```bash
sudo apt-get install -y ca-certificates curl gnupg lsb-release
```

---

## Step 1: Install Docker and Docker Compose

If you already have Docker and Docker Compose installed, skip to [Step 2](#step-2-clone-the-repository-and-run-the-node).

### Install Docker

Follow the official Docker installation guide for your system. For Ubuntu, you can use these steps:

1. **Update your package index**:
   ```bash
   sudo apt-get update
   ```

2. **Add Docker’s official GPG key**:
   ```bash
   sudo mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   ```

3. **Set up the Docker repository**:
   ```bash
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

4. **Install Docker Engine**:
   ```bash
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io
   ```

5. **Verify Docker is installed**:
   ```bash
   sudo docker --version
   ```

### Install Docker Compose

Install Docker Compose using the official instructions:

1. **Download the latest version of Docker Compose**:
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. **Apply executable permissions**:
   ```bash
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. **Verify installation**:
   ```bash
   docker-compose --version
   ```

---

## Step 2: Clone the Repository and Run the Node

1. **Clone this repository**:
   ```bash
   git clone https://github.com/edwinosky/gensyn-testnet.git
   cd gensyn-testnet
   ```

2. **Create a screen session**:

   To keep the node running even if your terminal disconnects (especially useful on a VPS), use the `screen` utility.

   If `screen` is not installed, install it with:
   ```bash
   sudo apt-get install -y screen
   ```

   Then, start a new session:
   ```bash
   screen -S gensyn-node
   ```

3. **Run the Docker Compose setup**:

   Build and start the container:
   ```bash
   docker compose up --build
   ```

   This will:
   - Build the Docker image using the Dockerfile.
   - Clone the Gensyn rl-swarm repository.
   - Set up dependencies and run the `run_rl_swarm.sh` script.
   - Expose the node on port 3200 of your VPS/machine.

   To run it in the background without a screen session, use:
   ```bash
   docker compose up --build -d
   ```

---

## Step 3: Complete the Setup

Once the container is running, wait for the logs to display the following message:
```
Waiting for userData.json to be created...
```

When you see this, open a browser and go to:

- **If on a VPS**: `http://<VPS_PUBLIC_IP>:3200`
- **If on a local machine**: `http://localhost:3200`

Log in using your email or Google account to complete the node setup. This will generate the `userData.json` file and allow the node to proceed.

---

## Additional Notes

- **Accessing the node**:  
  The service is exposed on port 3200 and bound to `0.0.0.0`, making it accessible from any network interface.  
  Ensure your firewall allows inbound traffic on port 3200:
  ```bash
  sudo ufw allow 3200
  ```

- **Stopping the node**:  
  To stop the container, press `Ctrl+C` (if running in the foreground) or use:
  ```bash
  docker compose down
  ```

- **Reattaching to screen**:  
  If you detach from the screen session (with `Ctrl+A, D`), reattach later with:
  ```bash
  screen -r gensyn-node
  ```

---

## Troubleshooting

- If the container fails to build, check the logs for errors and ensure all dependencies are available.
- If port 3200 is not accessible externally, verify your VPS firewall or network security settings.
```

Este archivo está correctamente formateado para que sea claro y fácil de seguir. Contiene bloques de código, encabezados organizados, listas y explicaciones claras. Si necesitas más modificaciones o personalización, avísame. ¡Espero que sea útil! 🚀
