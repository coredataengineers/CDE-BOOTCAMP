# Installing Kafka

Confluent Kafka has been chosen for use during this bootcamp, and this is due to its easy setup. This way, you are free from technical and financial debt that would otherwise be accrued by other available options of setting up a Kafka cluster. 

## Prerequisites
To run this quick start, you will need Git, Docker Desktop, and Docker Compose installed on a computer with a supported Operating System. Make sure you have Docker Desktop running.

## Windows Users
To set up your Confluent Kafka cluster on Windows, click [here](https://www.confluent.io/blog/set-up-and-run-kafka-on-windows-linux-wsl-2/)

## Mac/Linux Users
</br>
**Step 1**: Download and start Confluent Platform

In this step, you start by cloning a GitHub repository. This repository contains a Docker compose file and some required configuration files. The docker-compose.yml file sets ports and Docker environment variables such as the replication factor and listener properties for Confluent Platform and its components. To learn more about the settings in this file, see [Docker Image Configuration Reference for Confluent Platform](https://docs.confluent.io/platform/current/installation/docker/config-reference.html#config-reference).

Clone the Confluent Platform all-in-one example repository, for example:

```bash 
git clone https://github.com/confluentinc/cp-all-in-one.git
```

**Step 2**: Change to the `cp-all-in-one` directory.

 The default branch that is checked out is the latest version of Confluent Platform:

```bash
cd cp-all-in-one/cp-all-in-one
```
**Step 3**: Start the Confluent Platform stack with the `-d` option to run in detached mode:

```bash
docker compose up -d
```

**Note**: If you are using Docker Compose V1, you need to use a dash in the Docker Compose commands. For example:

```bash
docker-compose up -d
```
To learn more, see Migrate to Compose V2.

Each Confluent Platform component starts in a separate container. Your output should resemble the following. Your output may vary slightly from these examples depending on your operating system.

<img width="1118" height="159" alt="Screenshot 2025-07-23 at 9 50 08 PM" src="https://github.com/user-attachments/assets/29e99c57-a49c-43f9-8a6b-77c53ecb22a2" />

**Step 4**: Verify that the services are up and running:

```bash
docker compose ps
```
Your output should resemble:

<img width="1415" height="145" alt="Screenshot 2025-07-23 at 9 54 16 PM" src="https://github.com/user-attachments/assets/20a71701-8244-42ff-892b-b3c78ee722ac" />

After a few minutes, if the state of any component isn’t **Up**, run the `docker compose up -d` command again, or try `docker compose restart <image-name>`, for example:
```bash
docker compose restart control-center
```
