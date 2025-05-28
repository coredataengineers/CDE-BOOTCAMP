## Docker Architecture

The architecture of Docker explains how Docker works under the hood using a client-server architecture. If you’ve ever run a container with `docker run`, this guide will help you understand what’s happening behind the scenes.
## Docker Architecture Diagram
Docker employs a client-server architecture, where the Docker Client communicates with the Docker Daemon (also known as the Docker Engine) to build, run, and manage containers.

![Docker Architecture Diagram](docker_architecture_diagram.png)

The diagram above shows how Docker components interact. This interaction can happen on the same host or across different hosts.

##  Docker Components Explained

### 1. Docker Client

This is the Command Line Interface (CLI) tool where you run `docker build`, `docker run`, or `docker pull`.
### For Example:
```bash
docker run hello-world
```
This command is issued from the Docker Client. It sends a request to the Docker Daemon to run the hello-world container.

### Key Functions:
* Command Execution: Translates user commands (e.g., `docker run`, `docker build`, `docker pull`) into API requests.
* Communication with Daemon: Sends API requests to the Docker Daemon.
* Output Display: Displays the output from the Docker Daemon to the user.

### 2. Docker Daemon (dockerd)
This background process receives requests from the client and handles container lifecycle: building images, starting/stopping containers, etc.

When the client sends `docker run hello-world`, the daemon:
* Checks if the image exists locally
* Pulls it from Docker Hub if needed
* Creates and runs a container from it

### Key Responsibilities:
* Image Management: Stores, pulls, and pushes Docker images to and from registries.
* Container Lifecycle Management: Creates, starts, stops, moves, copies, and deletes containers.
* Network Management: Manages virtual networks for containers to communicate with each other and the outside world.
* Volume Management: Handles data persistence for containers.
* API Exposure: Exposes a RESTful API for the Docker Client to interact with it.

### 3. Docker Images
A Docker image is a read-only template that includes the application code, libraries, dependencies, etc.
### For Example, when you run:
```bash
docker pull python:3.10
```

This pulls a Python image from Docker Hub. You can then run a container from this image.

### Key Characteristics:
* Layered File System: Images are built from layers, where each layer represents a change to the filesystem. This makes them efficient to store and transmit.
* Immutable: Once an image is created, it cannot be changed. Any changes create a new layer on top.
* Portable: Images can be easily shared and run on any system with Docker installed.
* Creation: Images are typically built using a Dockerfile, which is a text file containing a set of instructions for building an image.

### 4. Docker Containers
A container is a runnable instance of an image. It is isolated and lightweight.
```bash
docker run -it python:3.10
```
This runs a Python shell in an isolated container.

### Key Characteristics:
* Isolated: Containers are isolated from each other and from the host system.
* Lightweight: Compared to virtual machines, containers are much lighter as they don't include a full operating system.
* Portable: Can be run consistently across different environments.
* Lifecycle: Containers can be started, stopped, paused, restarted, and removed.

### 5. Docker Registries (like Docker Hub)
Registries are storage and distribution systems for Docker images.
```bash
docker push yourname/myapp
```
This pushes a custom image to your Docker Hub account, making it available for others (or yourself) to pull from anywhere

### Types of Registries:
* Docker Hub: The default and most popular public registry, hosted by Docker. It contains a vast collection of public and official images.
* Private Registries: Organizations can set up their own private registries (e.g., Docker Registry, Artifactory, Nexus) to store internal images.

### Key Operations:
* `docker pull`: Downloads an image from a registry to your local machine.
* `docker push`: Uploads an image from your local machine to a registry.

 ## Real-World Analogy

Think of Docker as a shipping company:
- *Image*: A packaged good with instructions
- *Container*: A delivery truck carrying the good
- *Daemon*: The warehouse manager who dispatches trucks
- *Registry*: The storage depot of all packaged goods
- *Client*: The customer placing an order

## Summary of the Flow (Behind docker run)
1.	You run `docker run hello-world` on the Docker Client
2.	The Client sends the command to the Docker Daemon
3.	The Daemon checks local images
4.	If missing, it pulls from Docker Hub
5.	The Daemon uses the image to create and start a Container
6.	You see the container output on your terminal.



