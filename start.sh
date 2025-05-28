#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Start tmate session in background
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# Show SSH and Web URLs
echo "SSH Access:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
echo "Web (read-write):"
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'

# Keep-alive: Send 'echo "Nav Is Bestt"' to tmate every 60s
while true; do
  tmate -S /tmp/tmate.sock send-keys -t 0 "echo 'Nav Is Bestt'" C-m
  sleep 60
done &

# Start dummy HTTP server to keep Render container active
python3 -m http.server 8080
