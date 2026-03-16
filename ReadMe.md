# Ansible Multi-Tier Infrastructure Lab

A simulated multi-tier infrastructure environment built using Docker containers and automated with Ansible.
This project demonstrates how configuration management tools can be used to provision and manage infrastructure components such as load balancers, web servers, and databases in a controlled lab environment.
The lab replicates a simplified production-style architecture while running entirely on a single machine.

## Architecture Overview

The system simulates a layered infrastructure environment.

```text
                 +--------------------+
                 |    Ansible Host    |
                 |    Control Node    |
                 +----------+---------+
                            |
                     SSH / Automation
                            |
          +-----------------+-----------------+
          |                                   |
          v                                   v
+-------------------+               +-------------------+
|   Load Balancer   |-------------->|    Web Server     |
|      (Nginx)      |               |   Application     |
+---------+---------+               +---------+---------+
          |                                   |
          |                                   |
          +-----------------+-----------------+
                            |
                            v
                  +-------------------+
                  |      Database     |
                  |      Service      |
                  +-------------------+
```

## Infrastructure Layers

### Control Layer

The Ansible control node manages and configures all infrastructure components.

### Load Balancer Layer

Distributes incoming requests to backend services.

### Application Layer

Handles application logic and processes client requests.

### Database Layer

Stores application data and provides backend persistence.

## Project Structure

```bash
ansible-lab
│
├── db
│   └── Dockerfile
│
├── host
│   └── Dockerfile
│
├── load_balancer
│   └── Dockerfile
│
├── web
│   └── Dockerfile
│
├── docker-compose.yml
└── README.md
```

## Component Description

### `host`

Acts as the Ansible control node responsible for running automation playbooks and managing the environment.

### `load_balancer`

Represents the traffic routing layer responsible for distributing incoming requests.

### `web`

Application server responsible for handling requests and communicating with the database.

### `db`

Database service used by the application layer.

### `docker-compose.yml`

Defines and orchestrates the multi-container infrastructure environment.

## Technologies Used

| Technology         | Purpose                                                |
| ------------------ | ------------------------------------------------------ |
| **Docker**         | Containerized infrastructure simulation                |
| **Docker Compose** | Multi-container orchestration                          |
| **Ansible**        | Infrastructure automation and configuration management |
| **Linux**          | Base operating system                                  |
| **SSH**            | Remote automation and configuration                    |

## What This Project Demonstrates

This lab demonstrates several important DevOps and Infrastructure Engineering concepts:

- Infrastructure automation using Ansible
- Multi-tier architecture design
- Containerized infrastructure environments
- Configuration management workflows
- Infrastructure simulation for safe experimentation

## Why This Project Was Built

Testing automation tools such as Ansible often requires multiple servers.
This lab provides a safe and reproducible environment where infrastructure automation can be practiced without needing multiple physical or cloud machines.
By simulating infrastructure using Docker containers, the project allows experimentation with:

- Configuration management
- Service orchestration
- Infrastructure provisioning
- Network communication between services

## How to Run the Lab

Clone the repository:

```bash
git clone https://github.com/anubhavbuildz/ansible-lab.git
cd ansible-lab
```

Build and start the infrastructure:

```bash
docker-compose up --build
```

Docker will build all service containers and start the infrastructure environment.

## Key Learning Outcomes

Through this project I practiced:

- Designing multi-tier infrastructure
- Using Ansible for automation
- Simulating infrastructure using containers
- Managing service dependencies
- Understanding infrastructure communication patterns

## Possible Future Improvements

Potential improvements to extend this lab:

- Add multiple web servers for load balancing
- Implement Nginx reverse proxy configuration
- Integrate monitoring tools (Prometheus, Grafana)
- Add CI/CD automation pipelines
- Deploy the architecture on Kubernetes

## Author

**Anubhav Sharma**  
Cloud • DevOps • Systems Engineering
