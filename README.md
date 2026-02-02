# InfraCraft: Scalable Django Dashboard Deployment

A full-stack DevOps project demonstrating the containerization, scaling, and automated infrastructure provisioning of a Django-based administrative dashboard.



## Project Architecture
This project was built and tested on **RHEL 9.6** using a three-phase approach:

### Phase 1: Containerization (Podman)
- Successfully containerized the Django application using a custom `Dockerfile`.
- Integrated **Gunicorn** for high-performance process management.
- Configured rootless execution for enhanced security.

### Phase 2: High Availability & Load Balancing
- Orchestrated a cluster of **3 application replicas** using `podman-compose`.
- Deployed an **Nginx** reverse proxy to act as a Load Balancer on port `8080`.
- Ensured fault tolerance; if one container fails, the dashboard remains live.

### Phase 3: Infrastructure as Code (Terraform)
- Created a modular **Terraform** blueprint for **AWS (ap-south-1 Mumbai)**.
- Provisioned a secure VPC with public/private subnets and an Application Load Balancer.
- Utilized **Spot Instances** within a Launch Template for cost optimization.


## Technical Decisions & Challenges
- Port 8080 vs 80: Chose port 8080 for the host mapping to satisfy RHEL's non-privileged port requirements for rootless users.

- Persistent Storage: Utilized Podman volumes with the :Z flag to manage SELinux labeling on RHEL.

- Mumbai Region: Standardized on ap-south-1 to ensure low latency and regional compliance.

Author: Jithin Joseph John

Project: InfraCraft

