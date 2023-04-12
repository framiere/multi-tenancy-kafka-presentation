#/bin/env bash

set -Eeuo pipefail

export PATH=/home/fteychene/kafka/bin:$PATH

echo "> kafka-console-consumer.sh --bootstrap-server localhost:7070 --topic test"
kafka-console-consumer.sh --bootstrap-server localhost:7070 --topic test