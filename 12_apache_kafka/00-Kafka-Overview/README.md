# Introduction

If you are here, I want to give you a heartwarming congratulations, because you are about to explore and understand the beautiful world of `Apache Kafka`. The contents of the entire Kafka module is based on [Confluent Kafka](https://docs.confluent.io/), the original creators of Apache Kafka.

## Table of Contents

1. [Kafka Overview](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md)  
2. [Kafka Cluster](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/01-Kafka-Cluster/README.md)  
3. [Topics & Configuration](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/03-Kafka-topic-and-configurations/README.md)  
4. [Partitions & Offsets](docs/04-partitions-and-offsets.md)  
5. [Serialization & Deserialization](docs/05-serialization-and-deserialization.md)  
6. [Producers & Configurations](docs/06-producers-and-configuration.md)  
7. [Consumers & Configurations](docs/07-consumers-and-configuration.md)  
8. [Consumer Groups](docs/08-consumer-groups.md)  
9. [Consumer Group Protocol](docs/09-consumer-group-protocol.md)  
10. [Schema Registry](docs/10-schema-registry.md)  
11. [Production Kafka Clusters](docs/11-production-kafka-clusters.md) 


Here, we would be discussing the following topics:
- [Life Without Kafka: The Problem Kafka Solves](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md##Life-Without-Kafka:-The-Problem-Kafka-Solves)
  - [Option 1: Direct Communication Between Systems](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md###Option-1:-Direct-Communication-Between-Systems)
  - [Option 2: Traditional Message Queues](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md###Option-2:-Traditional-Message-Queues)
  - [Option 3: Batch Processing](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md###Option-3:-Batch-Processing)
- [Problems with Batch Processing](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md##Problems-with-Batch-Processing)
- [Kafka: The Real-Time Streaming Solution](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md##Kafka:-The-Real-Time-Streaming-Solution)
- [How Kafka Solves These Problems](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md###How-Kafka-Solves-These-Problems)
- [Kafka: The Real-Time Streaming Solution](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/00-Kafka-Overview/README.md##Kafka:-The-Real-Time-Streaming-Solution)


We won't go straight into it, I would like you to understand what happened before event streaming as we know it today.

## Life Without Kafka: The Problem Kafka Solves
Before Kafka, organizations often relied on direct communication between services or traditional data pipelines. These setups were hard to manage, unreliable, and not designed for real-time needs.

Let’s explore what life looked like without Kafka — and why even batch processing couldn’t solve the full picture.

### Option 1: Direct Communication Between Systems
Each service is wired to talk directly to another.

<img width="400" alt="Screenshot 2025-05-05 at 8 40 23 AM" src="https://github.com/user-attachments/assets/21caa313-cdd7-40f2-b6a3-e202b18217bf" />

**Problems**:
* Tightly coupled: Changes in one service break the others.
* Fragile: If the destination is down, messages are lost or delayed.
* Complex: Adding a new consumer means touching the producer code.


### Option 2: Traditional Message Queues
Message queues (like RabbitMQ or ActiveMQ) improved decoupling but still had limits:

* Messages are often removed after being read.
* Not built for high throughput or large-scale replay.
* Lacked storage—used for moving data, not persisting it.

### Option 3: Batch Processing
Some teams turned to batch processing pipelines, like using cron jobs or ETL tools (Extract, Transform, Load) to move data periodically:

<img width="540" alt="Screenshot 2025-05-05 at 8 41 36 AM" src="https://github.com/user-attachments/assets/de244e88-bc4a-4673-83b0-13dd3e0e503e" />

## Problems with Batch Processing:

| Issue                         | Why It's a Problem                                                |
| ----------------------------- | ----------------------------------------------------------------- |
| **Delayed Data**            | Batches often run every hour or daily. You get outdated insights. |
| **Rigid Scheduling**       | Missed jobs = missed data. Dependencies are brittle.              |
| **Poor Real-Time Support** | No way to react instantly to new events.                          |
| **Not Scalable**           | Moving millions of rows in batches causes spikes and failures.    |
| **Replay is Hard**         | You can’t “go back” unless you re-run the entire job.             |
| **No Streaming**            | Not suitable for dashboards, alerts, or event-driven systems.     |


**Example:**
<br> Imagine you work at a ride-sharing company.
<br> Riders open the app. Drivers complete trips.
<br> A dashboard shows active drivers in real time.

If you use batch processing, you’ll only update the dashboard every 15 minutes. That’s too late as users expect instant updates.


## Kafka: The Real-Time Streaming Solution
Kafka is built to solve these limitations. It acts as a central pipeline where producers publish events and consumers subscribe to them.

Here’s what it looks like with Kafka

<img width="668" alt="Screenshot 2025-05-05 at 8 49 36 AM" src="https://github.com/user-attachments/assets/5890e930-2cb9-496c-aa9c-f3a910ba3075" />

**What now happens**
* Producers write events to Kafka.
* Consumers read at their own speed, even replaying old messages if needed.

### How Kafka Solves These Problems

| Problem                       | Kafka’s Answer                            |
| ----------------------------- | ----------------------------------------- |
| Delayed batch insights        | Streams data in real time                 |
| Fragile point-to-point links  | Centralized topic-based communication     |
| Consumers blocked by failures | Kafka stores data until consumer is ready |
| Difficult scaling             | Horizontal scaling with partitions        |
| No historical data in queues  | Kafka retains messages for days/weeks     |
| Replay not possible           | Consumers can replay by resetting offsets |

## Kafka vs Batch: A Quick Comparison

| Feature             | Batch Processing        | Kafka Streaming                         |
| ------------------- | ----------------------- | --------------------------------------- |
| Data delivery speed | Delayed (minutes/hours) | Near real-time                          |
| Processing method   | Periodic jobs           | Continuous stream                       |
| Replayability       | Complex/manual          | Simple (via offsets)                    |
| Scalability         | Often brittle           | Built-in partitioning                   |
| Use case fit        | Reports, backups        | Dashboards, alerts, real-time services  |
| Failure handling    | Retry whole batch       | Consumer resumes from last known offset |

**With Kafka:**

* Systems are loosely coupled.
* Data is streamed continuously.
* Consumers can act in real-time or replay the past.

# Apache Kafka Overview

Apache Kafka is a distributed event streaming platform designed for high-throughput, fault-tolerant, and scalable real-time data pipelines. Originally developed at LinkedIn and later open-sourced, Kafka has become the de facto standard for building modern data streaming architectures.

Confluent Kafka is an enterprise-grade distribution of Apache Kafka that adds additional tools, services, and APIs to simplify deployment, monitoring, security, and integration.

## What is Kafka?
Kafka is fundamentally a publish-subscribe messaging system based on distributed commit logs. It enables applications to:

* Publish (write) streams of data (events, logs, metrics, etc.)
* Subscribe (read) those data streams in real-time
* Store data durably and reliably
* Process streams either in real-time or batch

Kafka can handle trillions of events per day across thousands of clients.

**Conclusion**

Kafka replaces rigid, slow, and fragile communication pipelines with a fast, scalable, and reliable event streaming platform.



# Confluent Kafka Concepts Guide

A comprehensive walk-through of core Apache Kafka (Confluent) concepts.


