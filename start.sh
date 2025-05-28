#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Check if tmate session already exists
if [ ! -S /tmp/tmate.sock ]; then
  tmate -S /tmp/tmate.sock new-session -d
fi
tmate -S /tmp/tmate.sock wait tmate-ready

echo "SSH Access:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
echo "Web (read-write):"
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'

# Send keep-alive keys periodically
while true; do
  tmate -S /tmp/tmate.sock send-keys -t 0 "echo 'Nav Is Bestt'" C-m
  tmate -S /tmp/tmate.sock send-keys -t 0 C-m
  sleep 60
done &

python3 -m http.server 8080
