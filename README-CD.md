# README-CD

## EC2 Instance Details

### AMI Information
Ubuntu Server 24.04 LTS

### Instance Type
t2.micro

### Recommended Volume Size
8 GB gp3 EBS Volume

### Security Group Configuration

| Port | Protocol | Source | Purpose |
| ------ | ------ | ------ | ------ |
| 22 | TCP | Home IP /32 | SSH Access |
| 22 | TCP | 130.108.0.0/16 | Wright State Access |
| 80 | TCP | 0.0.0.0/0 | Web Traffic |
| 9000 | TCP | GitHub Webhook IPs | Webhook Access |
| 9000 | TCP | Home IP /32 | Webhook Testing |

### Security Group Justification

Port 22 is restricted to trusted networks for administration of the EC2 instance.

Port 80 is open to the public so users can access the deployed website.

Port 9000 is reserved for GitHub webhook communication and testing of webhook functionality.

---

## Docker Setup on the EC2 Instance

### Install Docker

Update package lists:

```bash
sudo apt update
```

Install Docker:

```bash
sudo apt install docker.io -y
```

Enable Docker at startup:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Allow the ubuntu user to run Docker commands:

```bash
sudo usermod -aG docker ubuntu
```

### Verify Installation

Check Docker version:

```bash
docker --version
```

Run a test container:

```bash
docker run hello-world
```

---

## Testing on the EC2 Instance

### Pull Container Image from Docker Hub

```bash
docker pull roguememer/ceg3120-cicd-stein55-f26:latest
```

### Run Container from Image

```bash
docker run -d \
  --name myapp \
  -p 80:80 \
  roguememer/ceg3120-cicd-stein55-f26:latest
```

### Difference Between -it and -d

#### -it

```bash
docker run -it IMAGE_NAME
```

- Interactive terminal session
- Useful for troubleshooting and testing
- Stops when the terminal session ends

#### -d

```bash
docker run -d IMAGE_NAME
```

- Runs the container in detached mode
- Continues running in the background
- Recommended for production deployments

### Verify the Application

Verify the container is running:

```bash
docker ps
```

Verify the web page is being served:

```bash
curl localhost
```

The application may also be viewed by visiting the EC2 instance's public IP address in a web browser.

---

## Configuring a Webhook Listener on EC2

- Installed webhook via apt
- Verified installation using `webhook -version`
- Created `deployment/hooks.json`
- Configured GitHub signature validation using X-Hub-Signature-256
- Verified hook loaded successfully using webhook verbose output

Link:
deployment/hooks.json

## Configuring a Webhook Service on EC2

- Created systemd service file
- Enabled service with `systemctl enable webhook`
- Started service with `systemctl start webhook`
- Verified with `systemctl status webhook`
- Monitored logs with `journalctl -u webhook -f`

Link:
deployment/webhook.service
