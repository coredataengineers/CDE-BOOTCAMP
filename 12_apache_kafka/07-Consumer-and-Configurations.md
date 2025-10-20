# Kafka Producers and Configurations

Producers put data into Kafka topics, and consumers take it out to process, analyze, or store somewhere else. You can also think of this as an input and output system/architecture where you put information. 

A good illustration is when you are out of water, you need to have your bath, and luckily for you, there's light. What do you do? You immediately pump water, but you also turn on the tap so you can have your bath with whatever water has now been added to the tank. The pumping machine in this case is the producer, your tank is the broker, and the tap is the consumer, which is channeling all the water out as soon as it gets to the tank.

Simply put, if a producer is the writer in Kafka, then a `consumer` is the reader.

In this module, we will be covering the following topics:

- [What is a Consumer?](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/07-Consumer-and-Configurations.md#what-is-a-consumer)
- [How Consumers work](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/07-Consumer-and-Configurations.md#how-consumers-work)


## What is a Consumer?

* A consumer is an application that reads (or subscribes to) messages from one or more Kafka topics.
* It connects to the Kafka cluster.
* Reads data from topics (partition by partition).
* Keeps track of what it has already read using something called an offset.


Example:

* A dashboard that reads real-time user activity.
* A fraud detection system that consumes payment events.
* A database sync service that consumes topic data and writes it into a table.

## How Consumers Work

When a consumer subscribes to a topic:

* Kafka assigns one or more **partitions** from that topic to the consumer.
* The consumer reads messages in order (based on **offsets**).
* After processing each message, it can commit the offset, meaning “*I’ve read this message; move to the next.*”

If a consumer crashes and restarts, it resumes reading from the last committed offset, not from the beginning.



