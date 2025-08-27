# Kafka Producers and Configurations
So far, we know that a Kafka topic is like a notebook (or diary) where events are written, and partitions are like the pages that keep data organized. 

But who actually writes into this notebook?

That is the `Producer`.

[What is a Producer?](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/06-Producer-and%20Configurations.md#what-is-a-producer)



## What is a Producer?

A producer is any application that sends (produces) messages to a Kafka topic.

* Producers decide which topic to send data to.
* They can also decide which partition in the topic gets the message.
* Producers are stateless — they don’t keep old data; they just send new events into Kafka.

Example:

* A mobile app sending user clicks to Kafka.
* A payment service sending transaction logs.
* An IoT device sending temperature readings.

## How a Producer Works

When a producer sends a message:

* It connects to a Kafka broker (server).
* Kafka assigns the message to a topic partition.
* The message is stored with a unique offset.

## Producer Configurations (Key Settings)

Producers in Kafka are very configurable. Here are the most important beginner-friendly ones:

### 1. `bootstrap.servers`

* The address of the Kafka brokers (default address/port is localhost:9092).
* This is how the producer knows where to send data.

### 2. `key.serializer & value.serializer`

* Kafka messages have a key and a value.
* Both need to be converted into bytes before sending.
* Serializers handle this conversion.

  Some Common options:

* StringSerializer (for text data)
* IntegerSerializer (for numbers)
* Avro / JSON Serializer (for structured data)

### 3. `acks (Acknowledgments)`

  This controls how "safe" message delivery is:

* acks=0 → Fire-and-forget (producer doesn’t wait for confirmation). Fast, but risky.
* acks=1 → Waits for leader partition to confirm. Balanced.
* acks=all → Waits for all replicas to confirm. Safest, but slower.

### 4. `retries & retry.backoff.ms`

* If a message fails to send, how many times should Kafka retry?
* This also helps to handle temporary network issues.

5. `linger.ms & batch.size`












