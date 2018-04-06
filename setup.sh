#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo/root"
  exit
fi

cd "$( dirname "${BASH_SOURCE[0]}" )"

SYSTEMD_UNIT="dnsmasq-log-anonymiser"
DNSMASQ_PIPE="/var/log/dnsmasq.log.pipe"

# create log file if not exist
if [[ ! -p ${DNSMASQ_PIPE} ]]; then
    rm -f ${DNSMASQ_PIPE}
    mkfifo ${DNSMASQ_PIPE}
fi

# set ownership of log file
chown dnsmasq:root "${DNSMASQ_PIPE}"

# do not clobber an existing config file
cp -n ${SYSTEMD_UNIT}.conf /etc/

# modify pihole dnsmasq configuration to send dnsmasq log to new file
sed -i -E "s:^(log-facility=).*:\1${DNSMASQ_PIPE}:" /etc/dnsmasq.d/01-pihole.conf

# create systemd service
cp ${SYSTEMD_UNIT}.service /etc/systemd/system/
cp ${SYSTEMD_UNIT}/${SYSTEMD_UNIT} /usr/local/sbin/

# enable new service
systemctl daemon-reload
systemctl enable ${SYSTEMD_UNIT}.service

# start new service
systemctl restart ${SYSTEMD_UNIT}.service

# restart pihole
pihole restartdns

# wipe pihole log
pihole flush

# wipe pihole FTL database & restart
rm /etc/pihole/pihole-FTL.db
systemctl restart pihole-FTL.service
