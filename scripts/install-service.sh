#!/usr/bin/env bash
set -euo pipefail

cat > /tmp/honey-heist.service << 'EOF'
[Unit]
Description=Honey Heist Game Server
After=network.target

[Service]
Type=simple
User=corey
WorkingDirectory=/home/corey/honey-heist
ExecStart=/usr/bin/npx serve --listen tcp://0.0.0.0:8000 .
Restart=always
RestartSec=3
Environment=PATH=/usr/local/bin:/usr/bin:/bin

[Install]
WantedBy=multi-user.target
EOF

echo "Installing honey-heist service..."
sudo cp /tmp/honey-heist.service /etc/systemd/system/honey-heist.service
sudo systemctl daemon-reload
sudo systemctl enable honey-heist
sudo systemctl restart honey-heist
sleep 2
echo ""
echo "=== Status ==="
sudo systemctl status honey-heist --no-pager
