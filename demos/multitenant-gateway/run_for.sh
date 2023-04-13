#/bin/env bash

set -Eeuo pipefail

export PATH=/home/fteychene/kafka/bin:$PATH

alacritty msg config "font.size=20"  --window-id "$ALACRITTY_WINDOW_ID"

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

name=$1

run() {
  command=$@
  echo -n "> $command"
  read -n 1
  $command
}


cd $script_dir

echo "List topics for $name"
run kafka-topics.sh --bootstrap-server localhost:6970 --command-config $name.properties --list
echo

if [ $name == "florent" ]; then
  echo "List topics for $name"
  run kafka-topics.sh --bootstrap-server localhost:6970 --command-config $name.properties --list
  echo
fi

echo "Create topic test for $name"
run kafka-topics.sh --bootstrap-server localhost:6970 --command-config $name.properties --topic test --create
echo

echo "List topics for $name"
run kafka-topics.sh --bootstrap-server localhost:6970 --command-config $name.properties --list
echo

echo "Consume on test for $name"
kafka-console-consumer.sh --bootstrap-server localhost:6970 --consumer.config $name.properties --topic test
echo