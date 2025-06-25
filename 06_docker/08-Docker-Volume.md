## Docker containers are not designed for long term storage

When you run an application inside a Docker container, any data that the application generates is written to a location inside the container's filesystem. This may seem fine but there is a critical limitation that you should be aware of. 

The filesystem of a Docker container is **ephemeral** by nature i.e It’s not designed for storage. If the container crashes or gets deleted, All data that is stored inside it cannot be recovered. This makes realying on the container's internal storage risky for anything you want to keep. 

Consider this scenario: 
You have an application running inside a container. It generates log files and saves them to a directory like `/app/logs` inside the container. These logs may contain valuable information (e.g debug messages,user activity information, etc) that you may need to analyze later to improve your app. But if the container goes down, those logs are gone along with it.

That’s why it’s important to treat a container’s filesystem as a temporary storage. You should never assume that anything written inside a container today will still be there tomorrow.

To avoid any potential data loss, you need a reliable way to store data so that it does not go down with the container. "This where **Docker Volumes** come in"

## What is a Docker Volume?

A Docker volume is a persistent storage mechanism in Docker that allows you to store data that is generated inside a container to a location on the **HOST** machine. This ensures that the data is not lost when the container stops, restarts, or is removed.

> HOST: The machine that is running the Docker engine (i.e The machine that is creating the containers). It can be your local computer, virtual machine or a server on the cloud

## How volumes work

A docker volume in it's essence is just a directory on the **host machine**  that is mounted into another directory inside a container. Now any data that is written to the mount point inside the container is stored on the host machine inside the corresponding volume directory.  
This setup ensures that the data is safe even if the container is stopped deleted.

> Docker volumes are managed completely by Docker** and is typically stored at `/var/lib/docker/volumes/` on the host machine

Let’s break this down with an example:  
You have an app that generates data and write them to `/app/data` inside your container. If you mount a volume named `my-vol` to that directory, Docker will map it to a `/var/lib/docker/volumes/my-vol/_data` directory on the host. 

This means that any data that is written to `/app/data` inside the container will be automatically stored at `/var/lib/docker/volumes/my-vol/_data` on the host machine.

## Common commands in docker volumes

**To create a volume**

```bash
docker volume create my-vol
```

This creates a new Docker-managed volume named `my-vol`.

> Note: If you don’t specify a name, Docker will generate one automatically.

**To list all volumes**

```bash
docker volume ls
```

This command returns a list of all volumes currently on your system

``` bash
DRIVER    VOLUME NAME
local     my-vol
local     another-vol
```

**To inspect a specific volume**

```bash
docker volume inspect volume-name
```

This command returns detailed information about the volume in JSON format

For example: 
```bash
docker volume inspect my-vol
```

Output:

```json
[
    {
        "CreatedAt": "2025-06-18T14:28:37+01:00",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
        "Name": "my-vol",
        "Options": null,
        "Scope": "local"
    }
]
```

What the fields mean: 

| Field | Meaning | 
| ------ | ----- |
| `CreatedAt` | The date and time the volume was created |
| `Driver` | The driver used to manage the volume. By default, this is `local`. |
| `Mountpoint` | The actual location on the host machine where the volume data is stored. For `local` volumes, this is usually somewhere like `/var/lib/docker/volumes/<volume-name>/_data`. |
| `Name` | The name of the volume (`my-vol` in this  case). |
| `Labels` | Optional metadata.  You can add labels using `--label` flag while creating the volume |
| `Options` | This field indicate driver specific options used when the volume was created. It is empty unless specified |
| `Scope` | Thid field Indicates where the volume is accessible from. For `local` volumes, this is typically `local`, meaning the volume is only usable on the HOST machine |

**To delete a volume**

```bash
docker volume rm my-vol
```
> Note: A volume **cannot** be deleted if it is currently in use by a container.

## Benefits of Docker Volumes

1. **Persistence Beyond Container Lifecycle**   
   Docker volumes are independent of the containers which they are attached to. This means that if you delete a container or if it crashes, the data stored in the mounted volume remains intact because the volume is stored on the host system outside of the container.    
   This behaviour is useful when you have
   + An app that generates data (e.g logs, photos, files, etc) that you dont want to lose.
   + An app that writes data to a databaase. When you mount the database to a Docker volume, you ensure that your data persists on the host.

2. **Data Sharing between containers**  
   You can mount the **same** named volume into multiple containers at once. Every container can see and can modify the same files in real time. This setup makes is easy to
   
   * Share configuration files or resource caches.
   * Coordinate work: one container writes data, another reads or processes it without complicated copy operations

## Illustration of Docker volumes

You can mount a Docker volume into a container using the `-v` (or `--volume`) flag.  
This is the syntax

```bash
docker run -v <volume-name>:<container-path> <image-name>
```

* `docker run`: Starts a new container.
* `-v`: Tells Docker to mount a volume into the container.
* `<volume-name>`: The name of the Docker volume. If it doesn’t already exist, Docker will create it automatically.
* `<container-path>`: The directory inside the container where the volume will be mounted.
* `<image-name>`: The Docker image to base the container on (e.g., `ubuntu:24.04`).


**Example**

```bash
docker run -it -v mydata:/app/data ubuntu:24.04 bash
```

This command will 
+ mount the volume named `mydata` to the `/app/data` directory inside the container.
+ Launch an interactive Bash shell using the Ubuntu 24.04 image.

Now, anything you write to `/app/data` inside the container will be stored in the `mydata` volume on the host machine.

Even if the container stops or gets deleted, the volume and its data will persist. You can reuse the volume by creating another container and map the the same volume to a directory on that container.

> NOTE: You can even go  further by creating multiple containers and mounting the **same volume** into each of them. Any changes made by one container (i.e. writing or deleting files) are immediately visible to the others.

## Mount Options

When you mount a volume into a container using the `-v` flag, you can control how the container accesses that volume using mount options.

This is the syntax:

```bash
docker run -v <volume-name>:<container-path>:<options> <image-name>
```

As you can see, in addition to providing the volume name and container path, you can also provide options to define how your container should interact with the volume.Here are Common volume mount options

| Option | Description |
| ------ | ----------- |
| `ro`, `readonly` | Mounts the volume as **read-only**. The container can **read** data but **cannot write** to it. |
| `volume-nocopy`  | Prevents Docker from copying the existing content from the container's target directory into the volume on first mount (if the volume is empty).   

> By default, if no options is specified, the volume is mounted as `read-write` i.e containers can read and write to it freely.   

**For example:**

```bash
docker run -it -v myvolume:/app/data:ro ubuntu:24.04 bash
```
This command mounts `myvolume` into `/app/data` in the container as **read only** i.e you will only be able to read the data in the `/app/data` inside the container but you will not be able to write to it.