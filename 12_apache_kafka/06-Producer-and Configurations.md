## Kafka Producers and Configurations
So far, we know that a Kafka topic is like a notebook (or diary) where events are written, and partitions are like the pages that keep data organized. 

But who actually writes into this notebook?

That’s the `Producer`.

### What is a Producer?

A producer is any application that sends (produces) messages to a Kafka topic.

* Producers decide which topic to send data to.
* They can also decide which partition in the topic gets the message.
* Producers are stateless — they don’t keep old data; they just send new events into Kafka.

Example:

* A mobile app sending user clicks to Kafka.
* A payment service sending transaction logs.
* An IoT device sending temperature readings.





