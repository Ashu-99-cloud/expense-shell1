source common.sh

echo Disable MySQL 8 version
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSuccess\e[0m"
else
  echo -e "\e[31mFailed\e[0m"
  exit 1
fi

echo Copy MySQL repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSuccess\e[0m"
else
  echo -e "\e[31mFailed\e[0m"
  exit 1
fi

echo Install MySQL Server
dnf install mysql-community-server -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSuccess\e[0m"
else
  echo -e "\e[31mFailed\e[0m"
  exit 1
fi

echo Start MySQL Service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSuccess\e[0m"
else
  echo -e "\e[31mFailed\e[0m"
  exit 1
fi

echo Setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSuccess\e[0m"
else
  echo -e "\e[31mFailed\e[0m"
  exit 1
fi
