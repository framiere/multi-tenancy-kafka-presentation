#/bin/env bash

set -Eeuo pipefail
trap cleanup EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  cd $script_dir
  docker compose down -v
}

wait_to_start() {
  port=$1
  while [[ $(curl -s -o /dev/null -w "%{http_code}" localhost:$port/health) != 200 ]]; do
    printf '.'
    sleep 5
  done
  echo
}

run() {
  command=$@
  echo "> $command"
  $command
}

docker compose up -d

wait_to_start 8889

figlet -w 200 "Multi tenancy demo" | lolcat
echo


i3-msg 'split v' 
sleep 0.3

alacritty msg create-window --working-directory $script_dir -e ./split.sh > /dev/null

read -n 1

run kafka-console-producer.sh --bootstrap-server localhost:6970 --producer.config multitenant-gateway/francois.properties --topic test
echo

run kafka-console-producer.sh --bootstrap-server localhost:6970 --producer.config multitenant-gateway/florent.properties --topic test
echo

read -n 1
clear

figlet -w 200 'Safeguard demo'  | lolcat


echo 'Start proxy with safeguard'
read

echo kafka-topics.sh --bootstrap-server localhost:7070 --create --topic devoxx
kafka-topics.sh --bootstrap-server localhost:7070 --create --topic devoxx


i3-msg 'split h'
sleep 0.3

alacritty msg create-window --working-directory $script_dir/safeguard -e ./run-consumer.sh > /dev/null
echo


echo -n "echo 'Ack to leaders' | kafka-console-producer.sh --topic test --bootstrap-server localhost:7070 --producer-property 'acks=1'"
read -n 1
echo "Ack to leaders" | kafka-console-producer.sh --topic devoxx --bootstrap-server localhost:7070 --producer-property 'acks=1'
echo

echo -n "echo 'Good citizen - Ack to all' | kafka-console-producer.sh --topic test --bootstrap-server localhost:7070 --producer-property 'acks=-1'"
read -n 1
echo "Good citizen - Ack to all" | kafka-console-producer.sh --topic devoxx --bootstrap-server localhost:7070 --producer-property 'acks=-1'

read -n 1

