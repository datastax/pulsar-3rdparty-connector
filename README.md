# 3rd Party connectors for Apache Pulsar

This project provides simple templates and instructions to build Apache Pulsar connectors on base of the
existing Apache Kafka connectors. 

Apache Pulsar's high quality bar for the connectors is a blessing and a curse.
On one side, one using the connector is assured that a certain level of integration testing 
is done for each release. On another side, it requires a developer brave and experienced enough 
to contribute the connector and required integration tests.

This project relaxes initial quality guarantees to allow people to move the connectors 
they used with their Apache Kafka infrastructure into the Apache Pulsar's and incrementally work on improvements.

The project uses Apache Pulsar's Kafka Connect Adaptor (KCA). One can find more information about KCA in 
[this blog post](https://www.datastax.com/blog/simplify-migrating-kafka-to-pulsar-kafka-connect-support).
KCA is used for such popular Pulsar's connector's as 
[Pulsar Debezium Source Connectors](https://github.com/apache/pulsar/tree/master/pulsar-io/debezium) and
[Pulsar Snowflake Sink Connector](https://github.com/datastax/snowflake-connector).

The connectors built with this project require Datastax Pulsar Luna 2.8+ or Apache Pulsar 2.9+. 

For the details of the status of the specific connector and available connectors, navigate to 
`pulsar-connector/<connector name>` and check the readme provided by the contributor.

Added connectors, so far:

* [Apache Geode](pulsar-connectors/geode/)
* [Google BigQuery](pulsar-connectors/bigquery/)
* [Couchbase](pulsar-connectors/couchbase/)
* [DataDog Logs](pulsar-connectors/datadog/)
* [Diffusion](pulsar-connectors/diffusion/)
* [Hazelcast Jet](pulsar-connectors/hazelcast/)
* [Humio HEC](pulsar-connectors/humio/)
* [Kinetica](pulsar-connectors/kinetica/)
* [MarkLogic](pulsar-connectors/marklogic/)
* [Neo4J](pulsar-connectors/neo4j/)
* [New Relic](pulsar-connectors/newrelic/)
* [OrientDB](pulsar-connectors/orientdb/)
* [Apache Phoenix](pulsar-connectors/phoenix/)
* [Redis](pulsar-connectors/redis/)
* [SAP HANA](pulsar-connectors/sap-hana/)
* [SingleStore](pulsar-connectors/singlestore/)
* [Splunk](pulsar-connectors/splunk/)
* [XTDB](pulsar-connectors/xtdb/)
* [Zeebe](pulsar-connectors/zeebe/)

The rest of this documentation will dive into details of:
* how to build the connectors
* how to use the connectors
* how to add a connector

## Building the connectors

Make sure you have JDK 11+ and maven 3.8 installed.

Clone the repo and run `mvn clean install` from the root. 

The connectors' `.nar` files can be found at `pulsar-connectors/<connector name>>/target/pulsar-3rdparty-pulsar-connectors-<connector name>-0.1.0-SNAPSHOT.nar`

## Using the connectors

Follow regular Pulsar's steps to use the packaged connector: https://pulsar.apache.org/docs/en/io-use/ 

### Providing configuration for the connector

#### Sink Connectors

Follow the example below to create config yaml file: 

```yaml
# Pulsar KCA Sink expects "processingGuarantees" to be "EFFECTIVELY_ONCE"`
processingGuarantees: "EFFECTIVELY_ONCE"
configs:
  # Size of messages in bytes the sink will attempt to batch messages together before flush.
  # batchSize: 16384
  # Time interval in milliseconds the sink will attempt to batch messages together before flush.
  # lingerTimeMs: 2147483647
  # In case of Record<KeyValue<>> data use key from KeyValue<> instead of one from Record.
  # unwrapKeyValueIfAvailable: "true"
  # The Kafka topic name that passed to Kafka sink.
  topic: "my-topic"
  # Pulsar topic to store offsets at.
  offsetStorageTopic: "kafka-connect-sink-offsets"
  # A Kafka connector sink class to use.
  kafkaConnectorSinkClass: "com.third.party.CoolSinkConnector"
  # Config properties to pass to the Kafka connector.
  kafkaConnectorConfigProperties:
    # The following properties passed directly to Kafka Connect Sink and defined by it or by
    # https://github.com/apache/kafka/blob/2.7/connect/runtime/src/main/java/org/apache/kafka/connect/runtime/ConnectorConfig.java
    name: "test-sink"
    connector.class: "com.third.party.CoolSinkConnector"
    tasks.max: "1"
    topics: "my-topic"
    ...
```

#### Source Connectors

Follow the example below to create config yaml file:

```yaml
tenant: "public"
namespace: "default"
name: "test-source"
topicName: "test-topic"
parallelism: 1
# A Kafka connector source class to use.
className: "com.third.party.CoolSourceConnector"
configs:
  # Present the message only consist of payload.
  # json-with-envelope: "false"

  # Pulsar topic to store Kafka connector offsets at
  offset.storage.topic: "kafka-connect-source-offsets"
  # Pulsar namespace to store the output topics
  topic.namespace: "public/default"
  
  # Config properties to pass to the Kafka connector.
  # The following properties passed directly to Kafka Connect Sink and defined by it or by
  # https://github.com/apache/kafka/blob/2.7/connect/runtime/src/main/java/org/apache/kafka/connect/runtime/ConnectorConfig.java

  # A Kafka connector source class to use.
  task.class: "com.third.party.CoolSourceConnector"
  # The converter provided by Kafka Connect to convert record value.
  value.converter: "org.apache.kafka.connect.json.JsonConverter"
  # The converter provided by Kafka Connect to convert record key.
  key.converter: "org.apache.kafka.connect.json.JsonConverter"
  ...
```

## Adding a new connector

These steps help avoid some common problems that one can encounter while using KCA to create a new connector:
* make sure the connector's license allows its use and redistribution. Helpful starting point is https://www.apache.org/legal/resolved.html
* maven dependency conflict of transitive dependencies in build time 
* dependency conflict in runtime caused by third-party dependencies packaged with the connector 

### 1. Decide if you need to shade the original connector

Check the content of the Kafka connector's jar file. In case it includes third-party dependencies 
you may need to "shade" it (rename some classes).

To do so, copy `shaded-dependencies/template-shaded/` to `shaded-dependencies/<connector name>` 
and change its `pom.xml`, add new module into `shaded-dependencies/pom.xml`.

Build (`mvn clean install`) and make sure that third-party dependencies renamed as specified 
in `shaded-dependencies/<connector name>/pom.xml`.

### 2. Add new subproject

Copy `pulsar-connectors/template/` to `pulsar-connectors/<connector name>/` and change its `pom.xml`,
add new module into `pulsar-connectors/pom.xml`.

Update the `pulsar-connectors/<connector name>/README.md`.

Build (`mvn clean install`), resolve build problems as needed. 

Run ` mvn dependency:tree -Dverbose` and review how maven auto-resolved potential dependency conflicts, fix as needed.

