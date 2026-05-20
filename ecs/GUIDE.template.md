# ECS Deployment Guide

This directory holds deployment configs for each environment.

## Files

| File | Purpose |
|------|---------|
| `staging.conf` | ECS config for staging environment |
| `prod.conf` | ECS config for production environment (create when ready) |
| `.gitignore` | Excludes `*.conf` from git — configs contain account IDs |

## Config Fields

```bash
AWS_PROFILE=rayyone               # AWS CLI profile name
AWS_REGION=ap-southeast-1        # AWS region

ECR_REPO=<account>.dkr.ecr.ap-southeast-1.amazonaws.com  # ECR registry URL

ECR_APP_REPO_NAME=my-service      # ECR repo name (app image)
ECS_CLUSTER_NAME=ry-api-centre    # ECS cluster name
ECS_SERVICE_NAME=my-service       # ECS service name

IMAGE_URI=<ecr-repo>/<app-repo-name>          # App image URI (used in docker-compose)
```

---

## First-Time Setup

### 1. Fill in staging.conf

Edit `.rayyone/ecs/staging.conf` with your service name, cluster, and ECR details.

### 2. Create ECR repositories

```bash
ry ecs ecr-init -c=staging.conf
```

Creates `ECR_APP_REPO_NAME` repo. Safe to re-run (skips if already exists).

### 3. Build & push first image

```bash
ry ecs build -c=staging.conf
```

Must push at least one image before ECS can start the service.

### 4. Deploy CloudFormation stack

Done separately via `ry cf deploy` in the `aws-cf` repo. ECS service needs the image from step 3 to start successfully.

---

## Day-to-Day Deployment

```bash
# Build + push + deploy in one command
ry ecs build -c=prod.conf --deploy

# Build only (no deploy)
ry ecs build -c=prod.conf

# Deploy only (use existing ECR image)
ry ecs deploy -c=prod.conf

# Build specific images only
ry ecs build -c=prod.conf -i=app --deploy
```

## SSH into Running Task

```bash
ry ecs exec
# Interactive: select cluster → service → task → container
```
