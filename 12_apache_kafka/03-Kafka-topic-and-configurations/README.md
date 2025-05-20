## What is a Kafka Topic?

A Kafka topic is like a named folder where messages are stored.
Producers send messages into a topic, and consumers read messages from it.
Topics live inside Kafka clusters, which are grouped into larger environments.


<br> Imagine you have a notebook where you write down everything that happens in your day: every single event, from waking up to going to bed.

That’s exactly what a Kafka topic is:

A place where Kafka writes down every event, in the order it happened — like a diary.

## How Kafka Writes Events

<br> Every time something happens, like a temperature sensor sending a new reading, Kafka writes it as a new line in the notebook.
It never erases or overwrites old lines. It just keeps adding new ones at the bottom.
