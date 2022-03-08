## Google BigQuery Sink Connector

Name : Google BigQuery Sink Connector

Original Developer: WePay and Confluent

Link to Github: https://github.com/confluentinc/kafka-connect-bigquery

License: Apache 2.0

## Status

**TESTED**

One of:
```text
NOT TESTED - built, not tested
TESTED - tested end-to-end in limited number of usecases
MAINTAINED - tested and has unit tests or integration tests
```

## How to use

### Prepare Big Query

Follow Google's [instructions](https://cloud.google.com/docs/authentication/getting-started) to 
create an account and export json key. 

Refer to Big Query's [description](https://cloud.google.com/bigquery/docs/access-control-basic-roles) of roles and permissions 
to pick ones you require for your setup. 

Create the target dataset.

### Connector configuration

Sample config for the connector:
```yaml
processingGuarantees: "EFFECTIVELY_ONCE"
configs:
  topic: "bq-test01"
  kafkaConnectorSinkClass: "com.wepay.kafka.connect.bigquery.BigQuerySinkConnector" 
  offsetStorageTopic: "bq-sink-offsets01"
  batchSize: "10"
  lingerTimeMs: "10"
  # required to be true for the Big Query
  sanitizeTopicName: "true"
  kafkaConnectorConfigProperties:
    name: "bq-sink1"
    connector.class: "com.wepay.kafka.connect.bigquery.BigQuerySinkConnector"
    tasks.max: "1"
    topics: "bq-test01"
    project: "my-bigquery-project"
    defaultDataset: "BQ_CONNECTOR_TEST"
    keyfile: "/Users/me/my-bigquery-key.json"
    keySource: "FILE"
    kafkaDataFieldName: "topicMetaData"
    autoCreateTables: "true"
    sanitizeFieldNames: "true"
    bufferSize: "10"
    queueSize: "100"
```

Make sure you have correct topic names, project, dataset, etc.

Please refer to the connector's 
[documentation](https://docs.confluent.io/kafka-connect-bigquery/current/kafka_connect_bigquery_config.html) 
and [code](https://github.com/confluentinc/kafka-connect-bigquery/blob/master/kcbq-connector/src/main/java/com/wepay/kafka/connect/bigquery/config/BigQuerySinkConfig.java) for details on additional supported parameters

### Running locally for testing

1. Start pulsar standalone

```shell
$ bin/pulsar standalone
```

2. Set retention for the namespace:

```shell
$ bin/pulsar-admin namespaces set-retention public/default -t -1 -s 100M
```

3.Set topic schema:

```shell
$ cat ~/schema_js.json
{
    "type": "JSON",
    "schema": "{\"type\":\"record\",\"name\":\"TestSchema\",\"namespace\":\"com.foo\",\"fields\":[{\"name\":\"col1\",\"type\":[\"null\",\"string\"]},{\"name\":\"col2\",\"type\":[\"null\",\"string\"]}]}",
    "properties": {}
}

$ bin/pulsar-admin schemas upload --filename ~/schema_js.json bq-test01
```

4. Start the connector

```shell
$ bin/pulsar-admin sinks localrun \
  -a ~/src/pulsar-3rdparty-connectors/pulsar-connectors/bigquery/target/pulsar-3rdparty-pulsar-connectors-bigquery-0.1.0-SNAPSHOT.nar \ 
  --name bq-sink \
  --namespace public/default \
  --parallelism 1 \
  -i bq-test01 \
  --sink-config-file ~/bigquery.yaml
```

Make sure that connector started normally.

5. Send messages to Pulsar

```shell
$ cat ~/a.json
{"col1": "val1", "col2": "val2"}

$ bin/pulsar-client produce bq-test01 -f ~/a.json -n 20 -vs json:"{\"type\":\"record\",\"name\":\"TestSchema\",\"namespace\":\"com.foo\",\"fields\":[{\"name\":\"col1\",\"type\":[\"null\",\"string\"]},{\"name\":\"col2\",\"type\":[\"null\",\"string\"]}]}"
```

Please note that `-vs` (pass schema for the value) parameter is not supported by some earlier 
version of Pulsar 2.8.x

7. Check the messages in Big Query