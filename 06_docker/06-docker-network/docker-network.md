# <span style='color:lightblue'>Docker Networking
___
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
![alt text](image-1.png)

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

For instance, if the host is on a network of <span style='color:lightgreen'>__16.0.0.7__ IP address </span> while the containers are on network of <span style='color:lightgreen'>__19.0.0.10__ IP address</span>, communication would never occur as long as the <span style='color:lightgreen'>uniform is different</span> and there is nothing connecting them to <span style='color:lightgreen'>_bridge_</span> the communication gap.

Due to this isolation, docker creates a virtual network type called <span style='color:lightgreen'>__bridge__</span> which is the medium of connecting the host/server to the container.

### <span style='color:lightblue'>Host Network
Contrary to the concept of isolation between the host and docker containers, the Docker host network, just as the name implies maps the containers to whatever network the host/server is on, hence the containers are on the same IP range as the host.

For example: a server running on<span style='color:lightgreen'> __16.0.0.2__ IP </span> will have its docker containers on the <span style='color:lightgreen'>same network of IPs __16.0.0.<any number between 1 and 254>__</span> if the host network is assigned to the container upon creation. See code below:

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
![docker network illustration](image-4.png)
