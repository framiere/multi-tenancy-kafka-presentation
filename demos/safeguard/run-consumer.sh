#/bin/env bash

set -Eeuo pipefail

export PATH=/home/fteychene/kafka/bin:$PATH

alacritty msg config "font.size=20"  --window-id "$ALACRITTY_WINDOW_ID"

echo "> kafka-console-consumer.sh --bootstrap-server localhost:7070 --topic devoxx"
kafka-console-consumer.sh --bootstrap-server localhost:7070 --topic devoxx