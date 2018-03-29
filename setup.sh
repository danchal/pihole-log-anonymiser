#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo/root"
  exit
fi

cd "$( dirname "${BASH_SOURCE[0]}" )"

SYSTEMD_UNIT="dnsmasq-log-anonymiser"
DNSMASQ_LOG="/var/log/dnsmasq.log"

# create log file if not exist
if [[ ! -f ${DNSMAS_LOG} ]]; then
    touch ${DNSMASQ_LOG}
fi

# do not clobber an existing config file
cp -n ${SYSTEMD_UNIT}.conf /etc/

# modify pihole dnsmasq configuration to send dnsmasq log to new log file
sed -i -E "s:^(log-facility=).*:\1${DNSMASQ_LOG}:" /etc/dnsmasq.d/01-pihole.conf

# create systemd service
cp ${SYSTEMD_UNIT}.service /etc/systemd/system/
cp ${SYSTEMD_UNIT}/${SYSTEMD_UNIT} /usr/local/sbin/

systemctl daemon-reload
systemctl enable ${SYSTEMD_UNIT}.service
