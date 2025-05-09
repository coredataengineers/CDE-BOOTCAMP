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

