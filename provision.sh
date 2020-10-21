#!/bin/bash
# assign variables
#!/bin/bash
# assign variables
ACTION=${1:-launch}
function start() {
sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install nginx1.12 -y
sudo service nginx start
ps ax | grep nginx | grep -v grep
sudo chkconfig nginx on
cd /usr/share/nginx/html
sudo aws s3 cp s3://hold4477-assignment-webserver/index.html /usr/share/nginx/html/index.html
}
if [ -z "$1" ]
then
echo "No argument supplied, default action is: $ACTION"
start
else
echo "Initiating $ACTION."
fi
function stop() {
sudo service nginx stop
sudo rm -rf /usr/share/nginx/html/*
sudo yum remove nginx -y
}
function version() {
cat << EOF
1.0.0
EOF
}
function help() {
aws help
}
case "$ACTION" in
-r|--remove)
stop
;;
-h|--help)
help
;;
-v|--version)
version
;;
*)
exit 1
esac
