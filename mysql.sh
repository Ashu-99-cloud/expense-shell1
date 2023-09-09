source common.sh

echo Disable MySQL 8 version
dnf module disable mysql -y &>>$log_file

echo Copy MySQL repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file

echo Install MySQL Server
dnf install mysql-community-server -y &>>$log_file

echo Start MySQL Service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file

echo Setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file