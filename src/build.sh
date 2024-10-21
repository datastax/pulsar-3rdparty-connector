#!/bin/bash
base_connectors_count=28
camel_connectors_count=164
build_base_connectors() {
    mvn -B install -N
    mvn -B install -f shaded-dependencies
    mvn -B package -f pulsar-connectors/splunk
    mvn -B package -f pulsar-connectors/redis
    count=2
    for conn in pulsar-connectors/*; do
        if [[ ! -d "$conn" ]]; then continue; fi
        if [[ ! -f "${conn}/pom.xml" ]]; then continue; fi
        if [[ "$conn" == *"camel-"* ]]; then echo "skipping $conn"; continue; fi
        # /template is not in the build
        if [[ "$conn" == *"/template" ]]; then echo "skipping $conn"; continue; fi
        mvn -B clean package -f "$conn"
        count=$(( count + 1 ))
    done
    if [[ "$count" != "$base_connectors_count" ]]; then
        echo "Expected to build $base_connectors_count connectors, instead built only $count"
        exit 1
    fi

}

build_camel_connectors() {
    mvn -q install -N
    mvn -q install -f shaded-dependencies
    count=0
    for conn in pulsar-connectors/*; do
        if [[ ! -d "$conn" ]]; then continue; fi
        if [[ ! -f "${conn}/pom.xml" ]]; then continue; fi
        if [[ "$conn" != *"camel-"* ]]; then echo "skipping $conn"; continue; fi
        mvn -q -B clean package -f "$conn"
        count=$(( count + 1 ))
    done
    if [[ "$count" != "$camel_connectors_count" ]]; then
        echo "Expected to build $camel_connectors_count connectors, instead built only $count"
        exit 1
    fi
}
