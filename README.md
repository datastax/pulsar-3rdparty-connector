# Third Party connectors for Apache Pulsar

This project provides simple templates and instructions to build Apache Pulsar connectors on the base of 
existing Apache Kafka connectors. 

Apache Pulsar's current acceptance criteria for connectors requires a developer brave and experienced enough 
with both Pulsar and third party systems to contribute the connector and required integration tests.

This project relaxes the criteria to allow developers to quickly move connectors
they used with their Apache Kafka infrastructure into Apache Pulsar's, and incrementally work on improvements.

The project uses Apache Pulsar's Kafka Connect Adaptor (KCA). More information about KCA is available in 
[this blog post](https://www.datastax.com/blog/simplify-migrating-kafka-to-pulsar-kafka-connect-support).
KCA is used for such popular Pulsar connectors as 
[Pulsar Debezium Source Connectors](https://github.com/apache/pulsar/tree/master/pulsar-io/debezium) and
[Pulsar Snowflake Sink Connector](https://github.com/datastax/snowflake-connector).

The connectors built with this project require Datastax Pulsar Luna 2.8+ or Apache Pulsar 2.9+. 

For the details of the status of the specific connector and available connectors, navigate to 
`pulsar-connector/<connector name>` and check the readme provided by the contributor.

Added connectors, so far:

1. [Azure DocumentDB](pulsar-connectors/azure-documentdb)
2. [Apache Geode](pulsar-connectors/geode)
3. [Apache Kudu](pulsar-connectors/kudu)
4. [Apache Phoenix](pulsar-connectors/phoenix)
5. [Apache PLC4X](pulsar-connectors/plc4x)
6. [CoAP](pulsar-connectors/coap)
7. [Couchbase](pulsar-connectors/couchbase)
8. [DataDog Logs](pulsar-connectors/datadog)
9. [Diffusion](pulsar-connectors/diffusion)
10. [Google BigQuery](pulsar-connectors/bigquery)
11. [Hazelcast Jet](pulsar-connectors/hazelcast)
12. [Humio HEC](pulsar-connectors/humio)
13. [JMS](pulsar-connectors/jms)
14. [Kinetica](pulsar-connectors/kinetica)
15. [MarkLogic](pulsar-connectors/marklogic)
16. [MQTT](pulsar-connectors/mqtt)
17. [Neo4J](pulsar-connectors/neo4j)
18. [New Relic](pulsar-connectors/newrelic)
19. [OrientDB](pulsar-connectors/orientdb)
20. [Redis](pulsar-connectors/redis)
21. [SAP HANA](pulsar-connectors/sap-hana)
22. [SingleStore](pulsar-connectors/singlestore)
23. [Splunk](pulsar-connectors/splunk)
24. [XTDB](pulsar-connectors/xtdb)
25. [Zeebe](pulsar-connectors/zeebe)

The rest of this documentation will dive into details of:

* How to build connectors
* How to use connectors
* How to add a connector

## Building the connectors

Ensure you have JDK 11+ and Maven 3.8 installed.

Clone the connector's repo and run `mvn clean install` from the root. 

The connector's `.nar` files can be found at `pulsar-connectors/<connector name>>/target/pulsar-3rdparty-pulsar-connectors-<connector name>-0.1.0-SNAPSHOT.nar`

## Using the connectors

Follow [Pulsar's documentation](https://pulsar.apache.org/docs/en/io-use/) to use the packaged connector.

### Providing configuration for connectors

#### Sink Connectors

Follow the example below to create a config yaml file: 

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

Follow the example below to create a config yaml file:

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

These steps help avoid some common problems encountered while using KCA to create a new connector:

* Ensure the connector's license allows its use and redistribution. A helpful starting point is [here](https://www.apache.org/legal/resolved.html).  
* Maven dependency conflict of transitive dependencies in build time.
* Dependency conflict in runtime caused by third-party dependencies packaged with the connector.

### 1. Decide if you need to shade the original connector

Check the content of the Kafka connector's jar file. If it includes third-party dependencies, 
you may need to "shade" it (rename some classes).

To do so, copy `shaded-dependencies/template-shaded/` to `shaded-dependencies/<connector name>` 
and add the new module into `shaded-dependencies/pom.xml`.

Ensure that third-party dependencies are renamed as specified 
in `shaded-dependencies/<connector name>/pom.xml`and build (`mvn clean install`).

### 2. Add new subproject

Copy `pulsar-connectors/template/` to `pulsar-connectors/<connector name>/`, and add the new module into `pulsar-connectors/pom.xml`.

Update connector's name and description in `pulsar-connectors/<connector name>/src/main/resources/META-INF/services/pulsar-io.yaml`

Update the `pulsar-connectors/<connector name>/README.md`.

Build (`mvn clean install`). Run ` mvn dependency:tree -Dverbose` to review how Maven auto-resolved potential dependency conflicts and fix as needed.

