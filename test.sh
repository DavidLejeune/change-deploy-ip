#!/usr/bin/env bash
echo "SSH and SCP"
echo "Working directory : "
pwd

my_var=$(head -n 1 deploy-to-ip.txt)


echo "***************************"
echo " SSH to "$my_var
echo "***************************"



ssh pi@$my_var << EOF
pwd

EOF
