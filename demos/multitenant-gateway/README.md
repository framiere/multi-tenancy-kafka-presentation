

```
docker compose up -d
kafka-topics.sh --bootstrap-server localhost:6970 --command-config francois.properties --topic test --create
kafka-topics.sh --bootstrap-server localhost:6970 --command-config florent.properties --topic test --create


kafka-topics.sh --bootstrap-server localhost:6970 --command-config francois.properties --list
kafka-topics.sh --bootstrap-server localhost:6970 --command-config francois.properties --list


kafka-console-consumer.sh --bootstrap-server localhost:6970 --consumer.config florent.properties --topic test
kafka-console-consumer.sh --bootstrap-server localhost:6970 --consumer.config francois.properties --topic test

kafka-console-producer.sh --bootstrap-server localhost:6970 --producer.config florent.properties --topic test
kafka-console-producer.sh --bootstrap-server localhost:6970 --producer.config francois.properties --topic test
```