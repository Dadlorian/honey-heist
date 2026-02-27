#!/usr/bin/env bash
set -euo pipefail

echo "Stopping and removing honey-heist service..."
sudo systemctl stop honey-heist || true
sudo systemctl disable honey-heist || true
sudo rm -f /etc/systemd/system/honey-heist.service
sudo systemctl daemon-reload
echo "Done."
