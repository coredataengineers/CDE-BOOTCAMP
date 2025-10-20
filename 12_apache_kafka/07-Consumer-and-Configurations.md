# Kafka Producers and Configurations

Producers put data into Kafka topics, and consumers take it out to process, analyze, or store somewhere else. You can also think of this as an input and output system/architecture where you put information. 

A good illustration is when you are out of water, you need to have your bath, and luckily for you, there's light. What do you do? You immediately pump water, but you also turn on the tap so you can have your bath with whatever water has now been added to the tank. The pumping machine in this case is the producer, your tank is the broker, and the tap is the consumer, which is channeling all the water out as soon as it gets to the tank.

Simply put, if a producer is the writer in Kafka, then a `consumer` is the reader.

In this module, we will be covering the following topics:

[What is a Consumer?]()
[How Consumers work]()


## What is a Consumer?

* A consumer is an application that reads (or subscribes to) messages from one or more Kafka topics.
* It connects to the Kafka cluster.
* Reads data from topics (partition by partition).
* Keeps track of what it has already read using something called an offset.

