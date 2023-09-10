source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ]; then
  echo success
else
  echo failed
  exit 1
fi

echo placing expense config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf  &>>$log_file
check_status

echo removing old Nginx content
rm -rf /usr/share/nginx/html/*  &>>$log_file
check_status

cd /usr/share/nginx/html

download_and_extract

echo starting Nginx services
systemctl enable  nginx &>>$log_file
systemctl restart nginx  &>>$log_file
check_status
