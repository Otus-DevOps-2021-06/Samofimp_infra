git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sudo mv ~/puma-reddit.service /etc/systemd/system/puma-reddit.service
sudo systemctl daemon-reload
sudo systemctl start puma-reddit
sudo systemctl enable puma-reddit
