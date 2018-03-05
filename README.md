# Pi-hole Log Anonymiser
A systemd service to anonymise the logs of pihole in real time.

## Features
  * Anonymises all the client request domains and IP address
  * Pi-holed domains and IP addresses are left visible

## References
[Pi-hole](https://pi-hole.net/)

[Dnsmasq-log-anonymiser](https://github.com/danchal/dnsmasq-log-anonymiser)

## Requirements
        Systemd
        Pi-hole

## Install
        $ git clone https://github.com/danchal/pihole-log-anonymiser.git
        $ git submodue init
        $ git submodule update
        $ sudo ./setup.sh

## Setup
1. Edit the configuration file, /etc/dnsmasq-log-anonymiser.conf

2. Restart Pi-hole

        $ pihole restartdns

3. Start the dnsmasq-log-anonymiser Systemd service

        $ sudo systemctl restart dnsmasq-log-anonymiser.service