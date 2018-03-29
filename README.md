# Pi-hole Log Anonymiser
A systemd service to anonymise the logs of pihole in real time.

## Features
  * Anonymises all the allowed client request domains and IP address
  * Blocked Pi-holed domains and IP addresses are left visible

## Why?
Pi-hole allows you to monitor the performance and statistics on your network. However, in order to do this you must enable logging which exposes not only the blocked domains but also the allowed domains.

For the privacy conscious, this provides an alternative to disabling the logging altogether.

## References
[Pi-hole](https://pi-hole.net/)

[Dnsmasq-log-anonymiser](https://github.com/danchal/dnsmasq-log-anonymiser)

## Requirements
        Systemd
        Pi-hole

## Install
        $ git clone https://github.com/danchal/pihole-log-anonymiser.git
        $ cd pihole-log-anonymiser
        $ git submodue init
        $ git submodule update
        $ sudo ./setup.sh

## Setup
1. Edit the configuration file, /etc/dnsmasq-log-anonymiser.conf

2. Start the dnsmasq-log-anonymiser Systemd service

        $ sudo systemctl restart dnsmasq-log-anonymiser.service

3. Restart Pi-hole

        $ pihole restartdns

