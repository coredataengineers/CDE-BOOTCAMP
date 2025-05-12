# Kafka Cluster

A **Kafka cluster** is a network of one or more broker nodes that work together to provide fault-tolerant, high-throughput messaging.

## Key Components

- **Brokers**  
  - Handle read/write of messages  
  - Store partitions on disk  
- **ZooKeeper (legacy)**  
  - Coordinates cluster membership, leader election  
- **Controller**  
  - One broker elected to manage partition leaders  
- **Confluent Control Center** (optional)  
  - GUI for monitoring, managing topics, ACLs, and connectors  

## Cluster Deployment Models

1. **Self-Managed On-Prem**  
2. **Self-Managed Cloud (IaaS)**  
3. **Confluent Cloud (Managed)**  

## High-Availability & Scaling

- **Replicas & ISR**  
- **Automatic Leader Rebalancing**  
- **Rack-Aware Placement**  

Sorry if all these sounded too complex, they'll be broken down shortly

## Kafka Cluster: The Core Building Block
A Kafka cluster is a group of machines working together to handle large-scale, real-time data streams. It forms the core infrastructure behind Kafka’s ability to store, scale, and stream data reliably.

But before we dive into the components, here’s a simple analogy:

* Think of a Kafka cluster as a postal system:
   * You have post offices (brokers),
   * mailboxes (topics),
   * letters (messages),
   * and senders/receivers (producers/consumers).

Let’s further break down the pieces one by one.

