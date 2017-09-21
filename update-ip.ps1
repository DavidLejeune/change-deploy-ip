pwd
cd D:\DaLe\David\GIT\angular-client
git diff
git checkout develop
git pull origin develop
rm deploy-to-ip.txt
Set-Content .\deploy-to-ip.txt "192.168.0.92"
git add .
git commit -a -m "Deployment ip is now 192.168.0.92"
git push origin develop
echo "------------------------------------"
pwd
cd D:\DaLe\David\GIT\django-mqtt-server
git diff
git checkout develop
git pull origin develop
rm deploy-to-ip.txt
Set-Content .\deploy-to-ip.txt "192.168.0.92"
git add .
git commit -a -m "Deployment ip is now 192.168.0.92"
git push origin develop
echo "------------------------------------"
pwd
cd D:\DaLe\David\GIT\vmnengine
git diff
git checkout develop
git pull origin develop
rm deploy-to-ip.txt
Set-Content .\deploy-to-ip.txt "192.168.0.92"
git add .
git commit -a -m "Deployment ip is now 192.168.0.92"
git push origin develop
echo "------------------------------------"
