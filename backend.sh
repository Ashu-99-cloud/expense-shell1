source common.sh
component=backend

type npm &>>$log_file
if [ $? -ne 0 ]; then
  echo Install NodeJS repos for backend.sh
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  check_status

  echo Install NodeJS
  dnf install nodejs -y &>>$log_file
  check_status
fi

echo Copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
check_status


echo add application user
id expense &>>$log_file
if [ $? -ne 0 ]; then
  useradd expense &>>$log_file
fi
check_status


echo clean app content
# sudo rm -rf expense-shell/
rm -rf /app &>>$log_file
check_status


mkdir /app
cd /app

download_and_extract

echo Download dependencies
npm install &>>$log_file
check_status


echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
check_status


echo install MySQL client
dnf install mysql -y &>>$log_file
check_status


echo Load the schema
mysql_root_password=$1
mysql -h mysql.ashudevops.online -uroot -p$mysql_root_password < /app/schema/backend.sql &>>$log_file
check_status