

yum install epel-release -y
yum install ntp -y
yum install net-tools tcpdump -y
yum install bash-completion bash-completion-extras -y 

timedatectl set-timezone Europe/Athens
ntpd -qg
systemctl enable ntpd
#systemctl start ntpd

yum update -y





FRRVER="frr-stable"
curl -O https://rpm.frrouting.org/repo/$FRRVER-repo-1-0.el7.noarch.rpm
sudo yum install ./$FRRVER* -y
sudo yum install frr frr-pythontools -y

sudo yum install telnet nc -y 

