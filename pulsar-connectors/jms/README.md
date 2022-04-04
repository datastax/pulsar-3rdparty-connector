## JMS Source and Sink

Name: JMS

Original Developer: Lenses.io

Link to Github: https://github.com/lensesio/stream-reactor/

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

### Sink configuration

Sample config for the sink:
```yaml
processingGuarantees: "EFFECTIVELY_ONCE"
configs:
  topic: "jms-test01"
  kafkaConnectorSinkClass: "com.datamountaineer.streamreactor.connect.jms.sink.JMSSinkConnector"
  offsetStorageTopic: "jms-sink-offsets01"
  batchSize: "10"
  lingerTimeMs: "10"
  sanitizeTopicName: "true"
  kafkaConnectorConfigProperties:
    name: "jms-test01"
    connector.class: "com.datamountaineer.streamreactor.connect.jms.sink.JMSSinkConnector"
    tasks.max: "1"
    # sanitizeTopicName results in non-alphanumeric characters being replaced by "_"
    topics: "persistent___public_default_jms_test01"
    # JMS Sink specific configs, see
    # https://docs.lenses.io/5.0/integrations/connectors/stream-reactor/sinks/jmssinkconnector/
    connect.jms.url: "tcp://localhost:61616"
    connect.jms.initial.context.factory: "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    connect.jms.connection.factory: "ConnectionFactory"
    # sanitizeTopicName results in non-alphanumeric characters being replaced by "_"
    connect.jms.kcql: "INSERT INTO test-q SELECT * FROM persistent___public_default_jms_test01 WITHTYPE QUEUE WITHFORMAT JSON"
    connect.jms.subscription.name: "test-sub"
    connect.jms.password: "admin"
    connect.jms.username: "admin"
```

Please refer to the Sink's
[documentation](https://docs.lenses.io/5.0/integrations/connectors/stream-reactor/sinks/jmssinkconnector/) 
for details on additional supported parameters

### Source configuration

Sample config for the source:

```yaml
schemaType: AUTO_CONSUME
configs:
    json-with-envelope: "true"
    tasks.max: "1"
    task.class: "com.datamountaineer.streamreactor.connect.jms.source.JMSSourceTask"
    pulsar.service.url: "pulsar://127.0.0.1:6650"
    offset.storage.topic: "source-jms-offsets-topic4"
    topic.namespace: "public/default"
    
    value.converter: "org.apache.kafka.connect.json.JsonConverter"
    key.converter: "org.apache.kafka.connect.json.JsonConverter"
    typeClassName: "org.apache.pulsar.common.schema.KeyValue"

    connect.jms.kcql: "INSERT INTO pulsar-topic-jms2 SELECT * FROM test_q_out WITHTYPE QUEUE WITHCONVERTER=`com.datamountaineer.streamreactor.connect.converters.source.JsonSimpleConverter`"
    connect.jms.initial.context.factory: "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    connect.jms.url: "tcp://localhost:61616"
    connect.jms.connection.factory: "ConnectionFactory"
```

Please refer to the Source's
[documentation](https://docs.lenses.io/5.0/integrations/connectors/stream-reactor/sources/jmssourceconnector/)
for details on additional supported parameters

NOTE: JMS source queue or topic name (`test_q_out` in example above) should use only 
alphanumeric characters and underscore (`_`).

### Running locally for testing

#### Prepare ActiveMQ

The connector has been tested with ActiveMQ running locally as described below.

To run ActiveMQ locally:
```shell
docker run -p 61616:61616 -p 8161:8161 rmohr/activemq
```

Now you can navigate to http://localhost:8161/admin to create queues,
browse the queues, or send messages to the queues.

Alternatively, you can use CLI:

```shell
$ curl -L https://github.com/antonwierenga/amazonmq-cli/releases/download/v0.2.2/amazonmq-cli-0.2.2.zip
# unpack downloaded file, update the config

$ cat conf/amazonmq-cli.config:
----------
    broker {
        my-aws-broker {
            web-console = "http://localhost:8161/admin/"
            amqurl = "tcp://localhost:61616"
            username = "admin"
            password = "admin"
            prompt-color = "light-blue" // Possible values: "gray", "red", "light-red", "light-green", "green", "light-yellow", "yellow", "light-blue", "blue", "light-purple", "purple", "light-cyan", "cyan", "light-white", "white"
        }
    	// add additional brokers here
    }

    command {
    	list-queues {
    		order {
    			field = "Pending" // Possible values: "Queue Name", "Pending", "Enqueued" and "Dequeued"
    			direction = "" // Possible value: "reverse"
    		}
    	}
    	list-topics {
    		order {
    			field = "Topic Name" // Possible values: "Topic Name", "Enqueued" and "Dequeued"
    			direction = "" // Possible value: "reverse"
    		}
    	}
    	browse-messages {
    		timestamp-format = "yyyy-MM-dd'T'HH:mm:ss"
    	}
    	export-messages {
    		timestamp-format = "yyyy-MM-dd'T'HH:mm:ss"
    	}
    }

    messages {
        receive {
            timeout = 2000 // receive timeout in milliseconds (used in move-messages, copy-messages and export-messages)
            batch-size = 200 // number of messages processed in 1 batch (used in move-messages, copy-messages and export-messages)
        }
    }

    web-console {
        pause = 100 // milliseconds paused between multiple web-console operations (used in purge-all-queues, remove-all-queues and remove-all-topics)
        timeout = 300000 // web-console operation timeout in milliseconds
    }

$ bin/amazonmq-cli
    connect --broker my-aws-broker
    browse-messages --queue test-q
```
Please refer to the [CLI tool documentation](https://github.com/antonwierenga/amazonmq-cli/)
for details.

#### Prepare Pulsar

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

$ in/pulsar-admin schemas upload --filename ~/schema_sf_js.json jms-test01
```

#### Test Sink

Start the connector

```shell
$ bin/pulsar-admin sinks \
   localrun -a ~/src/pulsar-3rdparty-connector/pulsar-connectors/jms/target/pulsar-3rdparty-pulsar-connectors-jms-0.1.0-SNAPSHOT.nar \
   --name jms-sink --parallelism 1 -i jms-test01 --sink-config-file ~/jms.yaml
```

Make sure that connector started normally.

Send messages to Pulsar

```shell
$ cat ~/a.json
{"col1": "val1", "col2": "val2"}

bin/pulsar-client produce jms-test01 -f ~/a.json -n 2 -vs json:"{\"type\":\"record\",\"name\":\"SnowflakeTestSchema\",\"namespace\":\"com.foo\",\"fields\":[{\"name\":\"col1\",\"type\":[\"null\",\"string\"]},{\"name\":\"col2\",\"type\":[\"null\",\"string\"]}]}"
```

Please note that `-vs` (pass schema for the value) parameter is not supported by some earlier
version of Pulsar 2.8.x

Check the messages in ActiveMQ.

#### Test Source

Start the connector
```shell
bin/pulsar-admin source \
   localrun --archive ~/src/pulsar-3rdparty-connector/pulsar-connectors/jms/target/pulsar-3rdparty-pulsar-connectors-jms-0.1.0-SNAPSHOT.nar \
   --name jms-source --destination-topic-name pulsar-topic-jms2 --tenant public --namespace default --source-config-file ~/jms_source.yaml
```

Send a message to the JMS queue (e.g. using the web UI).

Consume the message from Pulsar:

```shell
bin/pulsar-client consume persistent://public/default/pulsar-topic-jms2 -s test -p Earliest -n 0 -m NonDurable
```
