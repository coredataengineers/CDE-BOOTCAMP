# Installing Kafka

Confluent Kafka has been chosen for use during this bootcamp, and this is due to its easy setup. This way, you are free from technical and financial debt that would otherwise be accrued by other available options of setting up a Kafka cluster. 

## Prerequisites
To run this quick start, you will need Git, Docker Desktop, and Docker Compose installed on a computer with a supported Operating System. Make sure you have Docker Desktop running.

## Windows Users
To set up your Confluent Kafka cluster on Windows, click [here](https://www.confluent.io/blog/set-up-and-run-kafka-on-windows-linux-wsl-2/)

## Mac/Linux Users

**Step 1: Download and start Confluent Platform**

In this step, you start by cloning a GitHub repository. This repository contains a Docker compose file and some required configuration files. The docker-compose.yml file sets ports and Docker environment variables such as the replication factor and listener properties for Confluent Platform and its components. To learn more about the settings in this file, see [Docker Image Configuration Reference for Confluent Platform](https://docs.confluent.io/platform/current/installation/docker/config-reference.html#config-reference).

Clone the Confluent Platform all-in-one example repository, for example:

```bash 
git clone https://github.com/confluentinc/cp-all-in-one.git
```

Change to the cp-all-in-one directory. The default branch that is checked out is the latest version of Confluent Platform:

cd cp-all-in-one/cp-all-in-one
Start the Confluent Platform stack with the -d option to run in detached mode:

docker compose up -d
Note

If you using an Docker Compose V1, you need to use a dash in the docker compose commands. For example:

docker-compose up -d
To learn more, see Migrate to Compose V2.

Each Confluent Platform component starts in a separate container. Your output should resemble the following. Your output may vary slightly from these examples depending on your operating system.

✔ Container flink-jobmanager   Started         37.9s
✔ Container broker             Started         37.8s
✔ Container prometheus         Started         37.9s
✔ Container flink-taskmanager  Started         34.2s
✔ Container flink-sql-client   Started         34.3s
✔ Container alertmanager       Started         34.5s
✔ Container schema-registry    Started         34.3s
✔ Container rest-proxy         Started         34.7s
✔ Container connect            Started         34.8s
✔ Container ksqldb-server      Started         35.1s
✔ Container ksqldb-cli         Started         35.6s
✔ Container control-center     Started         35.9s
✔ Container ksql-datagen       Started         35.7s

Verify that the services are up and running:

docker compose ps
Your output should resemble:

NAME                IMAGE                                                       COMMAND                  SERVICE             CREATED              STATUS              PORTS
alertmanager        confluentinc/cp-enterprise-alertmanager:2.0.0               "alertmanager-start …"   alertmanager        2 minutes ago        Up About a minute   0.0.0.0:9093->9093/tcp
broker              confluentinc/cp-server:7.9.0                                "/etc/confluent/dock…"   broker              2 minutes ago        Up About a minute   0.0.0.0:9092->9092/tcp, 0.0.0.0:9101->9101/tcp
connect             cnfldemos/cp-server-connect-datagen:0.6.4-7.6.0             "/etc/confluent/dock…"   connect             2 minutes ago        Up About a minute   0.0.0.0:8083->8083/tcp, 9092/tcp
control-center      confluentinc/cp-enterprise-control-center-next-gen:2.0.0    "bash -c 'dub templa…"   control-center      About a minute ago   Up About a minute   0.0.0.0:9021->9021/tcp
flink-jobmanager    cnfldemos/flink-kafka:1.19.1-scala_2.12-java17              "/docker-entrypoint.…"   flink-jobmanager    2 minutes ago        Up About a minute   6123/tcp, 8081/tcp, 0.0.0.0:9081->9081/tcp
flink-sql-client    cnfldemos/flink-sql-client-kafka:1.19.1-scala_2.12-java17   "/docker-entrypoint.…"   flink-sql-client    2 minutes ago        Up About a minute   6123/tcp, 8081/tcp
flink-taskmanager   cnfldemos/flink-kafka:1.19.1-scala_2.12-java17              "/docker-entrypoint.…"   flink-taskmanager   2 minutes ago        Up About a minute   6123/tcp, 8081/tcp
ksql-datagen        confluentinc/ksqldb-examples:7.9.0                          "bash -c 'echo Waiti…"   ksql-datagen        About a minute ago   Up About a minute
ksqldb-cli          confluentinc/cp-ksqldb-cli:7.9.0                            "/bin/sh"                ksqldb-cli          About a minute ago   Up About a minute
ksqldb-server       confluentinc/cp-ksqldb-server:7.9.0                         "/etc/confluent/dock…"   ksqldb-server       About a minute ago   Up About a minute   0.0.0.0:8088->8088/tcp
prometheus          confluentinc/cp-enterprise-prometheus:2.0.0                 "prometheus-start --…"   prometheus          2 minutes ago        Up About a minute   0.0.0.0:9090->9090/tcp
rest-proxy          confluentinc/cp-kafka-rest:7.9.0                            "/etc/confluent/dock…"   rest-proxy          2 minutes ago        Up About a minute   0.0.0.0:8082->8082/tcp
schema-registry     confluentinc/cp-schema-registry:7.9.0                       "/etc/confluent/dock…"   schema-registry     2 minutes ago        Up About a minute   0.0.0.0:8081->8081/tcp

After a few minutes, if the state of any component isn’t Up, run the docker compose up -d command again, or try docker compose restart <image-name>, for example:

docker compose restart control-center
