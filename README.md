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

1. [Azure Data Explorer (Kusto)](pulsar-connectors/azure-kusto)
2. [Azure DocumentDB](pulsar-connectors/azure-documentdb)
3. [Apache Geode](pulsar-connectors/geode)
4. [Apache Kudu](pulsar-connectors/kudu)
5. [Apache Phoenix](pulsar-connectors/phoenix)
6. [Apache PLC4X](pulsar-connectors/plc4x)
7. [CoAP](pulsar-connectors/coap)
8. [Couchbase](pulsar-connectors/couchbase)
9. [DataDog Logs](pulsar-connectors/datadog)
10. [Diffusion](pulsar-connectors/diffusion)
11. [Google BigQuery](pulsar-connectors/bigquery)
12. [Hazelcast Jet](pulsar-connectors/hazelcast)
13. [Humio HEC](pulsar-connectors/humio)
14. [JMS](pulsar-connectors/jms)
15. [Kinetica](pulsar-connectors/kinetica)
16. [MarkLogic](pulsar-connectors/marklogic)
17. [MQTT](pulsar-connectors/mqtt)
18. [Neo4J](pulsar-connectors/neo4j)
19. [New Relic](pulsar-connectors/newrelic)
20. [OrientDB](pulsar-connectors/orientdb)
21. [Redis](pulsar-connectors/redis)
22. [SAP HANA](pulsar-connectors/sap-hana)
23. [SingleStore](pulsar-connectors/singlestore)
24. [Splunk](pulsar-connectors/splunk)
25. [XTDB](pulsar-connectors/xtdb)
26. [Zeebe](pulsar-connectors/zeebe)
1. [camel-aws-cloudwatch-sink](pulsar-connectors/camel-aws-cloudwatch-sink)
1. [camel-aws-ddb-sink](pulsar-connectors/camel-aws-ddb-sink)
1. [camel-aws-ddb-streams-source](pulsar-connectors/camel-aws-ddb-streams-source)
1. [camel-aws-ec2-sink](pulsar-connectors/camel-aws-ec2-sink)
1. [camel-aws-eventbridge-sink](pulsar-connectors/camel-aws-eventbridge-sink)
1. [camel-aws-kinesis-firehose-sink](pulsar-connectors/camel-aws-kinesis-firehose-sink)
1. [camel-aws-kinesis-sink](pulsar-connectors/camel-aws-kinesis-sink)
1. [camel-aws-kinesis-source](pulsar-connectors/camel-aws-kinesis-source)
1. [camel-aws-lambda-sink](pulsar-connectors/camel-aws-lambda-sink)
1. [camel-aws-redshift-sink](pulsar-connectors/camel-aws-redshift-sink)
1. [camel-aws-redshift-source](pulsar-connectors/camel-aws-redshift-source)
1. [camel-aws-s3-sink](pulsar-connectors/camel-aws-s3-sink)
1. [camel-aws-s3-source](pulsar-connectors/camel-aws-s3-source)
1. [camel-aws-s3-streaming-upload-sink](pulsar-connectors/camel-aws-s3-streaming-upload-sink)
1. [camel-aws-secrets-manager-sink](pulsar-connectors/camel-aws-secrets-manager-sink)
1. [camel-aws-ses-sink](pulsar-connectors/camel-aws-ses-sink)
1. [camel-aws-sns-fifo-sink](pulsar-connectors/camel-aws-sns-fifo-sink)
1. [camel-aws-sns-sink](pulsar-connectors/camel-aws-sns-sink)
1. [camel-aws-sqs-batch-sink](pulsar-connectors/camel-aws-sqs-batch-sink)
1. [camel-aws-sqs-fifo-sink](pulsar-connectors/camel-aws-sqs-fifo-sink)
1. [camel-aws-sqs-sink](pulsar-connectors/camel-aws-sqs-sink)
1. [camel-aws-sqs-source](pulsar-connectors/camel-aws-sqs-source)
1. [camel-aws2-iam](pulsar-connectors/camel-aws2-iam)
1. [camel-aws2-kms](pulsar-connectors/camel-aws2-kms)
1. [camel-azure-cosmosdb-source](pulsar-connectors/camel-azure-cosmosdb-source)
1. [camel-azure-eventhubs-sink](pulsar-connectors/camel-azure-eventhubs-sink)
1. [camel-azure-eventhubs-source](pulsar-connectors/camel-azure-eventhubs-source)
1. [camel-azure-functions-sink](pulsar-connectors/camel-azure-functions-sink)
1. [camel-azure-servicebus-sink](pulsar-connectors/camel-azure-servicebus-sink)
1. [camel-azure-servicebus-source](pulsar-connectors/camel-azure-servicebus-source)
1. [camel-azure-storage-blob-changefeed-source](pulsar-connectors/camel-azure-storage-blob-changefeed-source)
1. [camel-azure-storage-blob-sink](pulsar-connectors/camel-azure-storage-blob-sink)
1. [camel-azure-storage-blob-source](pulsar-connectors/camel-azure-storage-blob-source)
1. [camel-azure-storage-queue-sink](pulsar-connectors/camel-azure-storage-queue-sink)
1. [camel-azure-storage-queue-source](pulsar-connectors/camel-azure-storage-queue-source)
1. [camel-beer-source](pulsar-connectors/camel-beer-source)
1. [camel-bitcoin-source](pulsar-connectors/camel-bitcoin-source)
1. [camel-cassandra-sink](pulsar-connectors/camel-cassandra-sink)
1. [camel-cassandra-source](pulsar-connectors/camel-cassandra-source)
1. [camel-ceph-sink](pulsar-connectors/camel-ceph-sink)
1. [camel-ceph-source](pulsar-connectors/camel-ceph-source)
1. [camel-chuck-norris-source](pulsar-connectors/camel-chuck-norris-source)
1. [camel-couchbase-sink](pulsar-connectors/camel-couchbase-sink)
1. [camel-cron-source](pulsar-connectors/camel-cron-source)
1. [camel-cxf](pulsar-connectors/camel-cxf)
1. [camel-cxfrs](pulsar-connectors/camel-cxfrs)
1. [camel-dropbox-sink](pulsar-connectors/camel-dropbox-sink)
1. [camel-dropbox-source](pulsar-connectors/camel-dropbox-source)
1. [camel-earthquake-source](pulsar-connectors/camel-earthquake-source)
1. [camel-elasticsearch-index-sink](pulsar-connectors/camel-elasticsearch-index-sink)
1. [camel-elasticsearch-search-source](pulsar-connectors/camel-elasticsearch-search-source)
1. [camel-exec-sink](pulsar-connectors/camel-exec-sink)
1. [camel-fhir-source](pulsar-connectors/camel-fhir-source)
1. [camel-file](pulsar-connectors/camel-file)
1. [camel-file-watch-source](pulsar-connectors/camel-file-watch-source)
1. [camel-ftp-sink](pulsar-connectors/camel-ftp-sink)
1. [camel-ftp-source](pulsar-connectors/camel-ftp-source)
1. [camel-ftps-sink](pulsar-connectors/camel-ftps-sink)
1. [camel-ftps-source](pulsar-connectors/camel-ftps-source)
1. [camel-github-commit-source](pulsar-connectors/camel-github-commit-source)
1. [camel-github-event-source](pulsar-connectors/camel-github-event-source)
1. [camel-github-pullrequest-comment-source](pulsar-connectors/camel-github-pullrequest-comment-source)
1. [camel-github-pullrequest-source](pulsar-connectors/camel-github-pullrequest-source)
1. [camel-github-tag-source](pulsar-connectors/camel-github-tag-source)
1. [camel-google-bigquery-sink](pulsar-connectors/camel-google-bigquery-sink)
1. [camel-google-calendar-source](pulsar-connectors/camel-google-calendar-source)
1. [camel-google-functions-sink](pulsar-connectors/camel-google-functions-sink)
1. [camel-google-mail-source](pulsar-connectors/camel-google-mail-source)
1. [camel-google-pubsub-sink](pulsar-connectors/camel-google-pubsub-sink)
1. [camel-google-pubsub-source](pulsar-connectors/camel-google-pubsub-source)
1. [camel-google-sheets-source](pulsar-connectors/camel-google-sheets-source)
1. [camel-google-storage-sink](pulsar-connectors/camel-google-storage-sink)
1. [camel-google-storage-source](pulsar-connectors/camel-google-storage-source)
1. [camel-hdfs](pulsar-connectors/camel-hdfs)
1. [camel-http-secured-sink](pulsar-connectors/camel-http-secured-sink)
1. [camel-http-secured-source](pulsar-connectors/camel-http-secured-source)
1. [camel-http-sink](pulsar-connectors/camel-http-sink)
1. [camel-http-source](pulsar-connectors/camel-http-source)
1. [camel-https](pulsar-connectors/camel-https)
1. [camel-infinispan-sink](pulsar-connectors/camel-infinispan-sink)
1. [camel-infinispan-source](pulsar-connectors/camel-infinispan-source)
1. [camel-jdbc](pulsar-connectors/camel-jdbc)
1. [camel-jira-add-comment-sink](pulsar-connectors/camel-jira-add-comment-sink)
1. [camel-jira-add-issue-sink](pulsar-connectors/camel-jira-add-issue-sink)
1. [camel-jira-oauth-source](pulsar-connectors/camel-jira-oauth-source)
1. [camel-jira-source](pulsar-connectors/camel-jira-source)
1. [camel-jira-transition-issue-sink](pulsar-connectors/camel-jira-transition-issue-sink)
1. [camel-jira-update-issue-sink](pulsar-connectors/camel-jira-update-issue-sink)
1. [camel-jms-amqp-10-sink](pulsar-connectors/camel-jms-amqp-10-sink)
1. [camel-jms-amqp-10-source](pulsar-connectors/camel-jms-amqp-10-source)
1. [camel-jms-apache-activemq-sink](pulsar-connectors/camel-jms-apache-activemq-sink)
1. [camel-jms-apache-activemq-source](pulsar-connectors/camel-jms-apache-activemq-source)
1. [camel-jms-apache-artemis-sink](pulsar-connectors/camel-jms-apache-artemis-sink)
1. [camel-jms-apache-artemis-source](pulsar-connectors/camel-jms-apache-artemis-source)
1. [camel-jms-ibm-mq-sink](pulsar-connectors/camel-jms-ibm-mq-sink)
1. [camel-jms-ibm-mq-source](pulsar-connectors/camel-jms-ibm-mq-source)
1. [camel-kafka-not-secured-sink](pulsar-connectors/camel-kafka-not-secured-sink)
1. [camel-kafka-not-secured-source](pulsar-connectors/camel-kafka-not-secured-source)
1. [camel-kafka-sink](pulsar-connectors/camel-kafka-sink)
1. [camel-kafka-source](pulsar-connectors/camel-kafka-source)
1. [camel-kafka-ssl-sink](pulsar-connectors/camel-kafka-ssl-sink)
1. [camel-kafka-ssl-source](pulsar-connectors/camel-kafka-ssl-source)
1. [camel-kubernetes-namespaces-source](pulsar-connectors/camel-kubernetes-namespaces-source)
1. [camel-kubernetes-nodes-source](pulsar-connectors/camel-kubernetes-nodes-source)
1. [camel-kubernetes-pods-source](pulsar-connectors/camel-kubernetes-pods-source)
1. [camel-log-sink](pulsar-connectors/camel-log-sink)
1. [camel-mail-imap-source](pulsar-connectors/camel-mail-imap-source)
1. [camel-mail-sink](pulsar-connectors/camel-mail-sink)
1. [camel-mariadb-sink](pulsar-connectors/camel-mariadb-sink)
1. [camel-mariadb-source](pulsar-connectors/camel-mariadb-source)
1. [camel-minio-sink](pulsar-connectors/camel-minio-sink)
1. [camel-minio-source](pulsar-connectors/camel-minio-source)
1. [camel-mongodb-changes-stream-source](pulsar-connectors/camel-mongodb-changes-stream-source)
1. [camel-mongodb-sink](pulsar-connectors/camel-mongodb-sink)
1. [camel-mongodb-source](pulsar-connectors/camel-mongodb-source)
1. [camel-mqtt-sink](pulsar-connectors/camel-mqtt-sink)
1. [camel-mqtt-source](pulsar-connectors/camel-mqtt-source)
1. [camel-mqtt5-sink](pulsar-connectors/camel-mqtt5-sink)
1. [camel-mqtt5-source](pulsar-connectors/camel-mqtt5-source)
1. [camel-mysql-sink](pulsar-connectors/camel-mysql-sink)
1. [camel-mysql-source](pulsar-connectors/camel-mysql-source)
1. [camel-nats-sink](pulsar-connectors/camel-nats-sink)
1. [camel-nats-source](pulsar-connectors/camel-nats-source)
1. [camel-netty-http](pulsar-connectors/camel-netty-http)
1. [camel-netty](pulsar-connectors/camel-netty)
1. [camel-oracle-database-sink](pulsar-connectors/camel-oracle-database-sink)
1. [camel-oracle-database-source](pulsar-connectors/camel-oracle-database-source)
1. [camel-postgresql-sink](pulsar-connectors/camel-postgresql-sink)
1. [camel-postgresql-source](pulsar-connectors/camel-postgresql-source)
1. [camel-pulsar-sink](pulsar-connectors/camel-pulsar-sink)
1. [camel-pulsar-source](pulsar-connectors/camel-pulsar-source)
1. [camel-rabbitmq-source](pulsar-connectors/camel-rabbitmq-source)
1. [camel-redis-sink](pulsar-connectors/camel-redis-sink)
1. [camel-redis-source](pulsar-connectors/camel-redis-source)
1. [camel-rest-openapi-sink](pulsar-connectors/camel-rest-openapi-sink)
1. [camel-salesforce-create-sink](pulsar-connectors/camel-salesforce-create-sink)
1. [camel-salesforce-delete-sink](pulsar-connectors/camel-salesforce-delete-sink)
1. [camel-salesforce-source](pulsar-connectors/camel-salesforce-source)
1. [camel-salesforce-update-sink](pulsar-connectors/camel-salesforce-update-sink)
1. [camel-scp-sink](pulsar-connectors/camel-scp-sink)
1. [camel-sftp-sink](pulsar-connectors/camel-sftp-sink)
1. [camel-sftp-source](pulsar-connectors/camel-sftp-source)
1. [camel-sjms2](pulsar-connectors/camel-sjms2)
1. [camel-slack-sink](pulsar-connectors/camel-slack-sink)
1. [camel-slack-source](pulsar-connectors/camel-slack-source)
1. [camel-solr-sink](pulsar-connectors/camel-solr-sink)
1. [camel-solr-source](pulsar-connectors/camel-solr-source)
1. [camel-splunk-hec-sink](pulsar-connectors/camel-splunk-hec-sink)
1. [camel-splunk-sink](pulsar-connectors/camel-splunk-sink)
1. [camel-splunk-source](pulsar-connectors/camel-splunk-source)
1. [camel-sqlserver-sink](pulsar-connectors/camel-sqlserver-sink)
1. [camel-sqlserver-source](pulsar-connectors/camel-sqlserver-source)
1. [camel-ssh-sink](pulsar-connectors/camel-ssh-sink)
1. [camel-ssh-source](pulsar-connectors/camel-ssh-source)
1. [camel-syslog](pulsar-connectors/camel-syslog)
1. [camel-telegram-sink](pulsar-connectors/camel-telegram-sink)
1. [camel-telegram-source](pulsar-connectors/camel-telegram-source)
1. [camel-timer-source](pulsar-connectors/camel-timer-source)
1. [camel-twitter-directmessage-source](pulsar-connectors/camel-twitter-directmessage-source)
1. [camel-twitter-search-source](pulsar-connectors/camel-twitter-search-source)
1. [camel-twitter-timeline-source](pulsar-connectors/camel-twitter-timeline-source)
1. [camel-webhook-source](pulsar-connectors/camel-webhook-source)
1. [camel-websocket-source](pulsar-connectors/camel-websocket-source)
1. [camel-wttrin-source](pulsar-connectors/camel-wttrin-source)
<!--- add new connector modules here --->

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

1. Copy `pulsar-connectors/template/` to `pulsar-connectors/<connector name>/`
2. Add the new module into `pulsar-connectors/pom.xml`
3. Update connector's name and description in `pulsar-connectors/<connector name>/src/main/resources/META-INF/services/pulsar-io.yaml`
4. Update the `pulsar-connectors/<connector name>/README.md`
5. Update the root `README.md`
6. Update `LICENSE` and `NOTICE` files
7. Build (`mvn clean install`). 
8. Run `mvn dependency:tree -Dverbose` to review how Maven auto-resolved potential dependency conflicts and fix as needed

To check the connector for CVEs:
```shell
mvn clean install verify -Powasp-dependency-check -DskipTests -f pulsar-connectors/<connector dir>/pom.xml
```
Detailed report will be at `pulsar-connectors/<connector dir>/target/dependency-check-report.html`
