# Partitions and Offsets in Kafka
To understand how Kafka organizes data, let’s revisit topics briefly.
A topic is like a folder where related events (messages) are stored. But inside a topic, data isn’t just thrown into one big pile — it is divided into partitions.

# What is a Partition?
A partition is a smaller chunk of a topic that holds a sequence of events (messages).

* Each partition is an ordered log, meaning new messages are always added at the end.
* Once written, messages never change (they are immutable).
* Partitions make topics scalable and distributed because data can be spread across multiple brokers (servers) in a Kafka cluster.
