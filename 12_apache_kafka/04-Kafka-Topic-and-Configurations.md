# Kafka Topic and Configurations

Here, we are going to be covering the basics of Kafka Topics and Configurations under the following titles:

- [Kafka Topic](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#what-is-a-kafka-topic)
  - [How Kafka Writes Events](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#how-kafka-writes-events)
  - [Not a Queue](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/12_apache_kafka/03-Kafka-topic-and-configurations/README.md###Not-a-Queue)
  - [What if the Notebook Gets Too Full?](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/12_apache_kafka/03-Kafka-topic-and-configurations/README.md###What-if-the-Notebook-Gets-Too-Full?)


## Kafka Topic

A Kafka topic is like a named folder where messages are stored.
Producers send messages into a topic, and consumers read messages from it.
Topics live inside Kafka clusters, which are grouped into larger environments.

Imagine you have a notebook where you write down everything that happens in your day: every single event, from waking up to going to bed.

That’s exactly what a Kafka topic is:

A place where Kafka writes down every event, in the order it happened — like a diary.

### How Kafka Writes Events

<br> Every time something happens, like a temperature sensor sending a new reading, Kafka writes it as a new line in the notebook.
It never erases or overwrites old lines. It just keeps adding new ones at the bottom.


Each line (or message) in this notebook has:

* Key – Who or what it's about (e.g., “Sensor 12”)
* Value – What happened (e.g., “Temperature is 23°C”)
* Timestamp – When it happened (e.g., “9:35 AM”)

### Not a Queue
Kafka topics aren’t like queues, where once you read a message, it's gone.

Instead:

* Everyone gets to read the same notebook
* Messages stay there for as long as you want
* If someone needs to read it again (maybe they missed a part), they can go back and re-read old pages

This makes Kafka great for apps that need to:

* Process data at different speeds
* Recover from a crash
* Or replay past events

### What if the Notebook Gets Too Full?
Kafka lets you control how long you keep the notebook pages:

* **Retention:** Keep data for 1 day, 7 days, or forever
* **Compaction:** If you only care about the latest info, Kafka can clean up old entries with the same key

Example: You only want the latest location of a delivery truck. Kafka can remove old locations and keep just the newest one.


## Kafka Topic Configuration
