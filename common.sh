log_file=/tmp/expense.log

download_and_extract() {
  echo download $component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip  &>>$log_file
    if [ $? -eq 0 ]; then
      echo - e "\e[32mSuccess\e[0m"
    else
      echo -e "\e[31mFailed\e[0m"
    fi

  echo extracting $component code
  unzip /tmp/$component.zip  &>>$log_file
  if [ $? -eq 0 ]; then
    echo - e "\e[32mSuccess\e[0m"
  else
    echo -e "\e[31mFailed\e[0m"
  fi
}