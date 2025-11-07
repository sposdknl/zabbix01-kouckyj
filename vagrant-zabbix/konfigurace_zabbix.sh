#!/usr/bin/env bash

UNIQUE_HOSTNAME="debian-kouckyj"
SHORT_HOSTNAME=$(echo "$UNIQUE_HOSTNAME" | cut -d'-' -f1,2)

# Záloha původního konfiguračního souboru
sudo cp -v /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf-orig

# Nastavení hodnot – přepíše existující řádky, nebo je přidá na konec
sudo sed -i "/^Hostname=/c\Hostname=$SHORT_HOSTNAME" /etc/zabbix/zabbix_agent2.conf
grep -q "^Hostname=" /etc/zabbix/zabbix_agent2.conf || echo "Hostname=$SHORT_HOSTNAME" | sudo tee -a /etc/zabbix/zabbix_agent2.conf

sudo sed -i "/^Server=/c\Server=enceladus.pfsense.cz" /etc/zabbix/zabbix_agent2.conf
grep -q "^Server=" /etc/zabbix/zabbix_agent2.conf || echo "Server=enceladus.pfsense.cz" | sudo tee -a /etc/zabbix/zabbix_agent2.conf

sudo sed -i "/^ServerActive=/c\ServerActive=enceladus.pfsense.cz" /etc/zabbix/zabbix_agent2.conf
grep -q "^ServerActive=" /etc/zabbix/zabbix_agent2.conf || echo "ServerActive=enceladus.pfsense.cz" | sudo tee -a /etc/zabbix/zabbix_agent2.conf

sudo sed -i "/^Timeout=/c\Timeout=30" /etc/zabbix/zabbix_agent2.conf
grep -q "^Timeout=" /etc/zabbix/zabbix_agent2.conf || echo "Timeout=30" | sudo tee -a /etc/zabbix/zabbix_agent2.conf

sudo sed -i "/^HostMetadata=/c\HostMetadata=SPOS" /etc/zabbix/zabbix_agent2.conf
grep -q "^HostMetadata=" /etc/zabbix/zabbix_agent2.conf || echo "HostMetadata=SPOS" | sudo tee -a /etc/zabbix/zabbix_agent2.conf

# Zobrazení rozdílů
sudo diff -u /etc/zabbix/zabbix_agent2.conf-orig /etc/zabbix/zabbix_agent2.conf

# Restart služby
sudo systemctl restart zabbix-agent2
