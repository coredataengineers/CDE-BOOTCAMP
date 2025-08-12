# Kafka Topic and Configurations

Here, we are going to be covering the basics of Kafka Topics and Configurations under the following titles:

- [Kafka Topic](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#what-is-a-kafka-topic)
  - [How Kafka Writes Events](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#how-kafka-writes-events)
  - [Not a Queue](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#not-a-queue)
  - [What if the Notebook Gets Too Full?](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#what-if-the-notebook-gets-too-full)
- [Kafka Topic Configuration](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#Kafka-Topic-Configuration)
  - [cleanup.policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#cleanuppolicy--what-to-do-with-old-pages)
  - [compression.type](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#compressiontype--How-to-Pack-Each-Note)
  - [default.replication.factor](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#default-replication-factor-–How-to-Pack-Each-Note)
  - [file.delete.delay.ms](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#filedeletedelayms--delay-before-erasing-a-page)
  - [flush.messages/flush.ms](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#flushmessages--flushms--when-to-force-save)
  - [index.interval.bytes](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#indexintervalbytes--how-often-to-add-page-markers)
  - [max.message.bytes](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#maxmessagebytes--max-size-of-one-note)
  - [max.compaction.lag.ms](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#maxcompactionlagms--wait-time-before-cleaning)
  - [message.downconversion.enable](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#messagedownconversionenable--support-for-old-formats)
  - [message.timestamp.*](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#messagetimestamp--rules-for-time-differences)
  - [message.timestamp.type](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#messagetimestamptype--when-was-the-note-written)
  - [min.cleanable.dirty.ratio](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#mincleanabledirtyratio--when-to-clean)
  - [min.compaction.lag.ms](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/12_apache_kafka/04-Kafka-Topic-and-Configurations.md#mincompactionlagms--wait-before-allowing-cleanup)

## Kafka Topic

A Kafka topic is like a named folder where messages are stored.
Producers send messages into a topic, and consumers read messages from it.
Topics live inside Kafka clusters, which are grouped into larger environments.

Imagine you have a notebook where you write down everything that happens in your day: every single event, from waking up to going to bed.

That’s exactly what a Kafka topic is:

A place where Kafka writes down every event, in the order it happened — like a diary.

### How Kafka Writes Events

Every time something happens, like a temperature sensor sending a new reading, Kafka writes it as a new line in the notebook.
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

<br> 

## Kafka Topic Configuration: Configuring Your Kafka Notebook
Imagine you’re using a shared digital notebook to track important events (like messages from a sensor or app). Now, you want to customize how this notebook works.


Think of each setting below as a notebook rule or behavior switch you can adjust.

 ### `cleanup.policy` – What to Do With Old Pages

Do you want to delete old notes or keep only the latest version of each key?

* `delete`: Throw away old pages after a while.
* `compact`: Clean the notebook but keep only the latest info per key.

NOTE: To switch to `compact`, `delete`, you must go through `compact` first.

* Default setting: delete
* Is this configuration editable after a Topic has been created?: Yes


### `compression.type` – How to Pack Each Note

Do you let the sender decide how to pack notes (like zipping them)?

* `producer`: Use the sender's packing choice.

* Default setting: producer
* Is this configuration editable after a Topic has been created?: No

### `default.replication.factor` – How Many Copies of the Notebook?

How many backup copies do we make of each notebook?

More copies = safer, but more storage is used.

* Default: 3
* Is this configuration editable after a Topic has been created?: No

### `file.delete.delay.ms` – Delay Before Erasing a Page?
After deciding to delete a page, how long should we wait before really removing it?

* Default: 60 seconds
* Is this configuration editable after a Topic has been created?: No

### `flush.messages / flush.ms` – When to Force Save?

Only save your notebook when forced — usually never, unless set manually.

* Default: Never
* Is this configuration editable after a Topic has been created?: No

### `index.interval.bytes` – How Often to Add Page Markers?

Every 4KB, add a sticky note so you can quickly jump to that spot later.

* Default: 4096 bytes
* Is this configuration editable after a Topic has been created?: No

### `max.message.bytes` – Max Size of One Note

What’s the biggest message you can write on a single page?

* Default: ~2MB
* Is this configuration editable after a Topic has been created?: Yes

### `max.compaction.lag.ms` – Wait Time Before Cleaning?

Wait this long before even considering cleaning a message.

* Default: Very long (practically unlimited)
* Is this configuration editable after a Topic has been created?: Yes

### `message.downconversion.enable` – Support for Old Formats?

Can older readers get converted versions of new notes?

* Default: true
* Is this configuration editable after a Topic has been created?: No


### `message.timestamp.*` – Rules for Time Differences
How strict should we be if a note says it was written way in the future or past?

* Default: Unlimited
* Is this configuration editable after a Topic has been created?: Yes

### `message.timestamp.type` – When Was the Note Written?

There are two modes:
* `CreateTime`: Use the time the sender wrote it.
* `LogAppendTime`: Use the time it got into Kafka.

Also,
* Default: CreateTime
* Is this configuration editable after a Topic has been created?: Yes

### `min.cleanable.dirty.ratio` – When to Clean?
Only start cleaning when at least 50% of the notebook is outdated junk.

* Default: 0.5
* Is this configuration editable after a Topic has been created?: No

### `min.compaction.lag.ms` – Wait Before Allowing Cleanup?
Minimum age of a note before it's eligible to be cleaned.

* Default: 0
* Is this configuration editable after a Topic has been created?: Yes

### `min.insync.replicas` – Minimum Notebooks That Must Be Updated
How many notebook copies must confirm the update before it counts?

* Default: 2
* Is this configuration editable after a Topic has been created?: Yes (only 1 or 2)

