#!/usr/bin/env bash

# Aktualizace balíčků a instalace základních nástrojů
sudo apt-get update
sudo apt-get install -y wget gnupg net-tools

# Stažení a instalace Zabbix repozitáře pro Debian 11 (Bullseye)
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.0+debian11_all.deb
sudo dpkg -i zabbix-release_latest_7.0+debian11_all.deb
sudo apt-get update

# Instalace Zabbix agent2 a pluginů
sudo apt-get install -y zabbix-agent2 zabbix-agent2-plugin-*

# Povolení a spuštění služby
sudo systemctl enable zabbix-agent2
sudo systemctl restart zabbix-agent2
