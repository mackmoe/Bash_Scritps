#!/bin/sh

echo -e "Setting the local date and time for the server:\n"; sleep 3;
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
echo -e "Done\n"; sleep 3;

echo -e "Installing all the packages\n" && sleep 3;
yum install -y mysql mysql-server httpd php php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy curl curl-devel php-pecl-apc; echo -e "Done\n"; sleep 3;

echo -e "Enableing Serveices on boot\n";
chkconfig httpd on && chkconfig mysqld on; sleep 3;
echo -e "Done\n"; sleep 3;

echo -e "Starting Services"
service mysqld start; service httpd start; sleep 3;
echo -e "Done\n";

echo -e "Kicking off the MySQL Server Install\n"; sleep 3;
mysql_secure_installation; echo -e "Done\n";

echo -e "Performing post installation services re-kick for MySQL and Apache\n";
service mysqld restart; service httpd restart; sleep 3;
echo -e "Done with your LampStack! Now installing PHPMyAdmin\n"; sleep 3;

echo -e "Setting up the RPMforge Repo for PHPMyAdmin\n"; sleep 3;
rpm --import http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt;
echo -e "Done\n";

echo -e "Installing PHPMyAdmin\n"
yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm; yum -y install phpmyadmin; echo -e "Go to: http://www.howtoforge.com/apache_php_mysql_on_centos_6.5_lamp and pick up from section 7 - PHPMyAdmin Install\n";
