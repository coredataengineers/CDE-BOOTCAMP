# <span style='color:lightblue'>Docker Networking
___

## Contents
- [Introduction](#introduction)
- [Types of Networks in docker](#types-of-networks-in-docker)
    - [Bridge](#bridge-network)
    - [Host](#host-network)
    - [Custom](#custom-network)
- [Illustration](#illustration)
- [Summary](#summary)

## Introduction

Networking in simple terms is the process of building relationships and connection with others.

Let's relate this concept to processes (containers) in Docker.
Docker container networking is the means by which docker containers connect to and communicate with each other or the host they are running on.

When a container is created, a network interface with an IP address is assigned to it. This network interface will be the one to send traffic to or receive traffic from other network interface of other containers or non-containers.

<span style='color:lightgreen'>_In layman term, see the network interface as the maid in __coloured uniform__ (IP Address)_.

___

___
## <span style='color:lightblue'>Types of Networks in Docker

Docker comes with 3 different networks which can be confirmed by running the command below:
```bash
docker network ls # List networks
```
<img width="367" alt="image-1" src="https://github.com/user-attachments/assets/635bcbd5-b3f8-46ed-81d5-4dcd8af3749c" />


### <span style='color:lightblue'>Network drivers
| <code>Driver | <code>Description|
| --- | --- |
<code>bridge	| The default network driver.
<code>host	| Remove network isolation between the container and the Docker host.
<code>none	|Completely isolate a container from the host and other containers.
<code>overlay	| Overlay networks connect multiple Docker daemons together.
<code>ipvlan	| IPvlan networks provide full control over both IPv4 and IPv6 addressing.
<code>macvlan	| Assign a MAC address to a container.
[source](https://docs.docker.com/engine/network/drivers/)


### <span style='color:lightblue'>Bridge Network</span>
The bridge network is a type of network that allows communication to occur between the host's network (on a more granular level, IP address) and the container(s) network. This is also the default network that Docker maps new containers that are not assigned any network to.

For instance, if the host is on a network of <code>__16.0.0.7__ IP address </code> while the containers are on network of <code>__19.0.0.10__ IP address</code>, communication would never occur as long as the <code>uniform is different</code> and there is nothing connecting them to <code>_bridge_</code> the communication gap.

Due to this isolation, docker creates a virtual network type called <code>__bridge__</code> which is the medium of connecting the host/server to the container.

### <span style='color:lightblue'>Host Network
Contrary to the concept of isolation between the host and docker containers, the Docker host network, just as the name implies maps the containers to whatever network the host/server is on, hence the containers are on the same IP range as the host.

For example: a server running on<code> __16.0.0.2__ IP </code> will have its docker containers on the <code>same network of IPs __16.0.0.<any number between 1 and 254>__</code> if the host network is assigned to the container upon creation. See code below:

```
docker run -d --name container_using_hostnetwork --network host myimage
```

However, let's keep in mind that this is a bad practice as security will not be as strong because containers will share the host’s namespace, increasing risk exposure.

### <span style='color:lightblue'>_Custom_ Network
A custom network is a user-defined network in Docker. It allows better control over container communication. Containers on the same custom network can easily communicate with each other, while those on different networks are isolated by default — which is useful for segmenting sensitive services like databases from the rest of the application stack. 

To create a custom network:
```bash
docker network create my-custom-network
```

Map a new container to the custom network created:

```
docker run -d --name container_using_customnetwork --network custom_network myimage
```

Detach an existing container from its network:
```bash
docker network disconnect host container_using_hostnetwork
```
and attach to another network:
```bash
docker network connect custom_network container_using_hostnetwork
```

```
docker run -d --name container_using_customnetwork --network custom_network myimage 
```

### <span style='color:lightblue'>Illustration
Let's assume we have a server/virtual machine hosting 3 containers:
One conatiner is a database of sensitive information that needs to be tightly secured while the other containers do not need the same of security.
![docker-networrking-illustration](https://github.com/user-attachments/assets/6b7eb04e-2de1-4883-8a8a-93e04bf5d407)


### Summary
- Networking is the means of connection and communication between containers.
- Understanding the concept of networking is crucial in knowing how to isolate containers from each other.
- Unless explicitly defined, all containers will be mapped to the <code>bridge</code> network by default.
