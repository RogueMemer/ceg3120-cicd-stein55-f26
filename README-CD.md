# README-CD

# Part 1 - Script a Refresh

## EC2 Instance Details

### AMI Information
Ubuntu Server 24.04 LTS

### Instance Type
t2.micro

### Recommended Volume Size
8 GB gp3 EBS Volume

### Security Group Configuration

| Port | Protocol | Source | Purpose |
|--------|----------|----------|----------|
| 22 | TCP | Home IP /32 | SSH Access |
| 22 | TCP | 130.108.0.0/16 | Wright State Access |
| 80 | TCP | 0.0.0.0/0 | Web Traffic |
| 9000 | TCP | GitHub Webhook IPs | Webhook Access |
| 9000 | TCP | Home IP /32 | Webhook Testing |

### Security Group Justification

Port 22 is restricted to trusted administrators.

Port 80 is open so that users can access the deployed website.

Port 9000 is used by the webhook listener to receive GitHub webhook requests and allows testing from my home IP.

---

## Docker Setup on the EC2 Instance

### Install Docker

```bash
sudo apt update
sudo apt install docker.io -y
```

Enable Docker:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Allow the ubuntu user to run Docker commands:

```bash
sudo usermod -aG docker ubuntu
```

### Additional Dependencies

No additional dependencies were required beyond the Docker package provided by Ubuntu.

### Verify Installation

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

- Interactive mode
- Used for testing and debugging
- Stops when the terminal session ends

#### -d

```bash
docker run -d IMAGE_NAME
```

- Detached mode
- Runs in the background
- Recommended for production deployments

### Verify the Web Application

Check that the container is running:

```bash
docker ps
```

Verify that the web page is being served:

```bash
curl localhost
```

The application can also be viewed from the EC2 instance public IP address.

---

## Scripting Container Application Refresh

### Description of the Bash Script

The deployment script:

1. Stops the currently running container.
2. Removes the old container.
3. Pulls the latest image from Docker Hub.
4. Starts a new container from the latest image.
5. Runs the container in detached mode.
6. Configures the container to restart automatically after reboots using `--restart always`.

### Testing the Script

Run:

```bash
./deployment/refresh.sh
```

Verify:

```bash
docker ps
```

Verify the website:

```bash
curl localhost
```

### Link to Bash Script

```text
deployment/refresh.sh
```

---

# Part 2 - Listen

## Configuring a Webhook Listener on EC2 Instance

### Install Webhook

```bash
sudo apt update
sudo apt install webhook -y
```

### Verify Installation

```bash
webhook -version
```

### Summary of the Webhook Definition File

The file `deployment/hooks.json` defines a hook named `docker-refresh`.

The hook:

- Executes `refresh.sh`
- Verifies GitHub requests using the `X-Hub-Signature-256` header
- Uses a shared secret for validation
- Triggers only when an image is ready to be pulled

### Verify Definition File Loaded

Start webhook:

```bash
webhook -hooks deployment/hooks.json -verbose -port 9000
```

A successful load displays:

```text
loaded: docker-refresh
```

### Verify Webhook Receives Payloads

Monitor logs:

```bash
journalctl -u webhook -f
```

Webhook events will appear in the log output when payloads are received.

### Monitoring Logs

```bash
journalctl -u webhook -f
```

### Docker Process Verification

```bash
docker ps
```

A successful webhook trigger should refresh the running container.

### Link to Definition File

```text
deployment/hooks.json
```

---

## Configure a Webhook Service on EC2 Instance

### Summary of Service File

The service file automatically starts webhook at system boot.

The service:

- Loads `deployment/hooks.json`
- Listens on port 9000
- Restarts automatically if it stops unexpectedly

### Enable and Start Service

Reload systemd:

```bash
sudo systemctl daemon-reload
```

Enable:

```bash
sudo systemctl enable webhook
```

Start:

```bash
sudo systemctl start webhook
```

### Verify Service Operation

Check service status:

```bash
sudo systemctl status webhook
```

Expected output:

```text
Active: active (running)
```

Monitor logs:

```bash
journalctl -u webhook -f
```

Verify container activity:

```bash
docker ps
```

### Link to Service File

```text
deployment/webhook.service
```

# Part 3 - Send a Payload

## Configuring a GitHub Webhook

### Enabling GitHub to Send Payloads

A GitHub webhook was configured in the repository settings.

Payload URL:

```text
http://100.55.188.60:9000/hooks/docker-refresh
```

Content Type:

```text
application/json
```

Secret:

```text
Same shared secret configured in deployment/hooks.json
```

### Selected Event

Selected Event:

```text
Workflow Runs
```

The webhook is configured to trigger when a workflow run completes.

The event payload contains:

```json
"action": "completed"
```

and

```json
"conclusion": "success"
```

### Why This Event Was Chosen

I selected the Workflow Run event because it occurs after the GitHub Actions workflow has completed.

My deployment process depends on the latest Docker image already existing in Docker Hub before the deployment server executes the refresh script.

I did not choose the Push event because a push occurs immediately when code is pushed to GitHub and may happen before the Docker image has finished building and uploading to Docker Hub.

Using Workflow Run Completed ensures that the deployment server pulls the newest available image.

### Verifying Successful Payload Delivery

Webhook deliveries can be viewed in:

```text
Repository Settings → Webhooks → Recent Deliveries
```

Successful delivery was verified using:

```text
Response: 200
```

indicating that GitHub successfully contacted the EC2 webhook listener.

Webhook activity can also be monitored using:

```bash
journalctl -u webhook -f
```

### Validating Requests Come From GitHub

The webhook listener validates incoming requests using:

```text
X-Hub-Signature-256
```

and a shared secret configured in:

```text
deployment/hooks.json
```

Requests that do not provide a valid signature fail validation and do not execute the deployment script.

Testing with curl resulted in:

```text
Hook rules were not satisfied.
```

demonstrating that unauthorized requests do not trigger deployment actions.

---

## GitHub Webhooks vs DockerHub Webhooks

### Event Generation

GitHub Webhooks send payloads when repository events occur.

For this project, the selected event was:

```text
workflow_run.completed
```

which occurs after the GitHub Actions workflow finishes.

DockerHub Webhooks send payloads when repository image events occur, such as image pushes.

### Sender Verification

GitHub Webhooks support validation using:

```text
X-Hub-Signature-256
```

and a shared secret.

DockerHub Webhooks can notify external systems when images are updated, but GitHub provides stronger integration with GitHub Actions workflows.

### Preferred Solution

I would use GitHub Webhooks for this deployment because they integrate directly with the CI/CD pipeline and can be configured to trigger only after successful workflow completion.

This ensures that deployments occur only after the latest image has been built and pushed to Docker Hub.

# CEG3120 CI/CD Project

This repository contains the work completed for the CEG 3120 Continuous Integration and Continuous Deployment project.

## Project Files

### README-CI.md

Documentation for the Continuous Integration portion of the project.

Topics include:

- GitHub Actions configuration
- Docker image building
- Docker image publishing
- CI workflow implementation

### README-CD.md

Documentation for the Continuous Deployment portion of the project.

Topics include:

- EC2 deployment
- Docker deployment
- Webhook listener setup
- GitHub webhook configuration
- Automated container refresh
- Deployment architecture diagram
- CI/CD workflow explanation

## Deployment Files

Located in:

```text
deployment/
```

Contents:

- `refresh.sh` - refresh deployment script
- `hooks.json` - webhook hook definition
- `webhook.service` - systemd service configuration

## Creator

Liam Stein
