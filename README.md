# Gensyn Testnet Node Setup

This repository provides a simple way to run a Gensyn testnet node using Docker and Docker Compose. Follow the instructions below to set up and run the node on your machine or VPS.

## Prerequisites

- A Linux-based system (e.g., Ubuntu) is recommended.
- Docker and Docker Compose installed (see installation instructions below).
Install required packages:
sudo apt-get install -y ca-certificates curl gnupg lsb-release

## Step 1: Install Docker and Docker Compose

If you already have Docker and Docker Compose installed, skip to [Step 2](#step-2-clone-the-repository-and-run-the-node).

### Install Docker
Follow the official Docker installation guide for your system. For Ubuntu, you can use these steps:

Update your package index:
   sudo apt-get update
   
Add Docker’s official GPG key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
Set up the Docker repository:

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

Install Docker Engine:
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
Verify Docker is installed:
sudo docker --version

Install Docker Compose
Install Docker Compose using the official instructions:

Download the latest version of Docker Compose:

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
Apply executable permissions:

sudo chmod +x /usr/local/bin/docker-compose

Verify installation:
docker-compose --version



## Step 2: Clone the Repository and Run the Node
Clone this repository:

git clone https://github.com/edwinosky/gensyn-testnet.git
cd gensyn-testnet
Create a screen session:
To keep the node running even if your terminal disconnects (especially useful on a VPS), use the screen utility. 
If screen is not installed, install it with:
sudo apt-get install -y screen

Then start a new session:

screen -S gensyn-node
Run the Docker Compose setup:
Build and start the container:

docker compose up --build

This will:

Build the Docker image using the Dockerfile.
Clone the Gensyn rl-swarm repository.
Set up dependencies and run the run_rl_swarm.sh script.
Expose the node on port 3200 of your VPS/machine.

If you want to run it in the background without screen session, use:

docker compose up --build -d

## Step 3: Complete the Setup
Once the container is running, wait for the logs to display the following message:

Waiting for userData.json to be created...


When you see this:

Open a browser

Go to:
If on a VPS: http://<VPS_PUBLIC_IP>:3200
If on a local machine: http://localhost:3200

Log in using your email or Google account to complete the node setup. This will generate the userData.json file and allow the node to proceed.
Additional Notes
Accessing the node: The service is exposed on port 3200 and bound to 0.0.0.0, making it accessible from any network interface. Ensure your firewall allows inbound traffic on port 3200 (e.g., sudo ufw allow 3200 on Ubuntu).
Stopping the node: To stop the container, press Ctrl+C (if running in the foreground) or use:
docker compose down

Reattaching to screen: If you detach from the screen session (with Ctrl+A, D), reattach later with:
bash

screen -r gensyn-node


## Troubleshooting
If the container fails to build, check the logs for errors and ensure all dependencies are available.
If port 3200 is not accessible externally, verify your VPS firewall or network security settings.
