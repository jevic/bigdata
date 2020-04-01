#!/bin/bash
Limits="/etc/security/limits.conf"
\cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.back

curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

yum install -y epel-release
rpmList="
wget
git
bc
jq
lrzsz
unzip
fping
ntpdate
rsync
traceroute
telnet
sysstat
socat
pstree
lftp
"

yum install -y $rpmList
yum -y install bind-utils sysstat perl-devel gcc mtr traceroute iputils glibc.i686 lrzsz iftop ntpdate libselinux-python screen htop bzip2 openssl-devel openssh-clients perl-ExtUtils-CBuilder perl-Test-Simple perl-Test-Harness telnet lsscsi dmidecode unzip vim  net-tools rdate wget lrzsz epel-release dstat lsof iotop


systemctl stop firewalld
systemctl disable firewalld


cat > /etc/sysctl.conf <<EOF
vm.swappiness=0
net.netfilter.nf_conntrack_max=1048576
net.netfilter.nf_conntrack_max=1048576
net.ipv4.tcp_wmem = 4096  87380   4194304
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_rmem = 4096  87380   15564800
net.ipv4.tcp_retries2 = 5
net.ipv4.tcp_retries1 = 2
net.ipv4.tcp_orphan_retries = 2
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_tw_buckets = 2000000
net.ipv4.tcp_max_syn_backlog = 2000000
net.ipv4.tcp_max_orphans = 327680
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 65
net.ipv4.tcp_fin_timeout = 1
net.ipv4.ip_local_port_range = 5000 65000
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.core.wmem_max = 16777216
net.core.wmem_default = 8388608
net.core.somaxconn = 65535
net.core.rmem_max = 16777216
net.core.rmem_default = 8388608
net.core.netdev_max_backlog =  327680
kernel.sysrq = 0
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.core_uses_pid = 1
EOF

sysctl -p

echo "* soft nofile 524288
* hard nofile 524288
* soft nproc unlimited
* hard nproc unlimited" >> $Limits

sed -i 's%#PermitEmptyPasswords no%PermitEmptyPasswords no%' /etc/ssh/sshd_config
sed -i 's%GSSAPIAuthentication yes%GSSAPIAuthentication no%' /etc/ssh/sshd_config
sed -i 's%#UseDNS yes%UseDNS no%' /etc/ssh/sshd_config
sed -i 's#SELINUX=enforcing#SELINUX=disabled#' /etc/selinux/config
setenforce 0

yum -y install ntp
systemctl enable ntpd
systemctl restart ntpd
systemctl restart crond
