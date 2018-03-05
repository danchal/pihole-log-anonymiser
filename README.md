# Pihole Log Anonymiser
A systemd service to anonymise the logs of pihole in real time.

## Features
  * Anonymises all the client request domains and IP address
  * Pi-Holed domains and IP addresses are left visible for statists

## References
[Pi-Hole](https://pi-hole.net/)

[Dnsmasq-log-anonymiser](https://github.com/danchal/dnsmasq-log-anonymiser)

## Requirements
        Systemd
        Pihole
        Dnsmasq-log-anonymiser

## Install
        $ sudo ./setup.sh

## Setup
1. Edit the configuration file, /etc/dnsmasq-log-anonymiser.conf

2. Start the dnsmasq-log-anonymiser Systemd service

        $ sudo systemctl restart dnsmasq-log-anonymiser.service