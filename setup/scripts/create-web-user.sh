#!/usr/bin/env bash
WEB_USERNAME=$1;
sudo useradd -m $WEB_USERNAME;
sudo chsh -s /bin/bash $WEB_USERNAME
echo "$WEB_USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
