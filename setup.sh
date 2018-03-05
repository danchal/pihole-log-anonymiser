#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo/root"
  exit
fi

cd "$( dirname "${BASH_SOURCE[0]}" )"

SYSTEMD_UNIT="dnsmasq-log-anonymiser"

# do not clobber an existing config file
cp -n ${SYSTEMD_UNIT}.conf /etc/

# create fifo named pipe to send dnsmasq log
mkfifo /var/log/pihole.log.pipe

# modify pihole dnsmasq configuration to send dnsmasq log to named pipe
sed -E 's:^(log-facility=).*:\1/var/log/pihole.log.pipe:' /etc/dnsmasq.d/01-pihole.conf

# create systemd service
cp ${SYSTEMD_UNIT}.service /etc/systemd/system/
cp ${SYSTEMD_UNIT}/${SYSTEMD_UNIT} /usr/local/sbin/

systemctl daemon-reload
systemctl enable ${SYSTEMD_UNIT}.service
