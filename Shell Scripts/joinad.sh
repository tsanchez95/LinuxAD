#! /bin/bash
sudo yum -y update
sudo yum -y install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit krb5-user
systemctl disable firewalld
systemctl stop firewalld
realm permit twotronz@vault.kps-lv.com
sed -i 's/^.*use_fully_qualified_names.*$/use_fully_qualified_names False/g' /etc/sssd/sssd.conf
sudo cp /etc/hosts /etc/host_original
cat >> /etc/hosts <<EOL
10.1.200.5    vault.kps-lv.com
EOL
sudo cp /etc/sudoers /etc/sudoers_original
cat >> /etc/sudoers <<EOL
twotronz        ALL=(ALL:ALL) ALL
EOL
head -n 2 /etc/hosts > /tmp/tmp.txt && mv /tmp/tmp.txt /etc/hosts -f
sed -i 's/^.*PasswordAuthentication.*$/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd.service
cat >> /etc/security/limits.conf <<EOL
* hard core 0
EOL

cat >> /etc/ntp.conf <<EOL
restrict -4 default kod nomodify notrap nopeer noquery
OPTIONS="-u ntp:ntp -p /var/run/ntpd.pid -g"
EOL

cat >> /etc/sysctl.conf <<EOL
fs.suid_dumpable=0
kernel.randomize_va_space = 2
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
EOL
sudo chown root:root /etc/issue
sudo chmod 644 /etc/issue
grep ^gpgcheck /etc/yum.repos.d/*
rm -f /etc/issue.d/cockpit.issue /etc/motd.d/cockpit
sudo update-motd --disable
cat >> /etc/motd <<EOL
---------------------------------------------WARNING--------------------------------------------------

This system is restricted to authorized users for legitimate business purposes and is subject to audit. 
The unauthorized access, use, or modification of the computer systems, information resources, 
and/or data contained therein or in transit to/from the system is illegal and will be prosecuted. 
By using this system as an authorized user you agree to follow the Acceptable Use Policy. 
You acknowledge receipt of the above message when you login.

------------------------------------------------------------------------------------------------------
EOL