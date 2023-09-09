source common.sh
component=backend

echo Install NodeJS repos for backend.sh
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &&>>$log_file

echo Install NodeJS
dnf install nodejs -y &>>$log_file

echo Copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo add application user
useradd expense &>>$log_file

echo clean app content
# sudo rm -rf expense-shell/
rm -rf /app &>>$log_file
mkdir /app
cd /app

download_and_extract

echo Download dependencies
npm install &&>>$log_file

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

echo install MySQL client
dnf install mysql -y &>>$log_file

echo Load the schema
mysql -h mysql.ashudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file