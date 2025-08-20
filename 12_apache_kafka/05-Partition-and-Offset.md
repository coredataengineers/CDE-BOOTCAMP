# Partitions and Offsets in Kafka
To understand how Kafka organizes data, let’s revisit topics briefly.
A topic is like a folder where related events (messages) are stored. But inside a topic, data isn’t just thrown into one big pile; it is divided into partitions.

- [What is a Partition?](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/05-Partition-and-Offset.md#what-is-a-partition)
- [What is an Offset?](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/05-Partition-and-Offset.md#what-is-an-offset)

## What is a Partition?
A partition is a smaller chunk of a topic that holds a sequence of events (messages).

* Each partition is an ordered log, meaning new messages are always added at the end.
* Once written, messages never change (they are immutable).
* Partitions make topics scalable and distributed because data can be spread across multiple brokers (servers) in a Kafka cluster.

Think of a partition like a page in a notebook: each new line you write is the next message. If the notebook is too small, you can add more pages (partitions).

**Example:**
Imagine a topic called user-signups, where:

* Partition 0 might store signups from users A–M.
* Partition 1 might store signups from users N–Z.
This way, data is balanced and can be processed in parallel.

**NOTE:** It doesn't always work like this, as there are different partition strategies, but that is outside the scope of this lesson.


## What is an Offset?
Inside a partition, each message is given a unique number called an `offset`.

* The offset is like the line number on a notebook page.
* It tells Kafka (and consumers) the exact position of a message in a partition.
* Offsets start at 0 and increase by 1 for each new message.

Offsets are local to a partition, not global to the topic.

* For example, Partition 0 might have messages with offsets 0, 1, 2...
* Partition 1 also starts at offset 0, 1, 2... independently.

## Why Partitions and Offsets Matter
1. Scalability: Partitions let Kafka spread topic data across multiple brokers, enabling it to efficiently handle massive volumes of messages/events.











