@echo off

color B0
mode con cols=50 lines=10
title 切换DNS

echo 1. 公司DNS
echo 2. 谷歌DNS
echo 3. 阿里DNS

set choice=
set /p choice=  请输入选项(1/2/3)：
goto %choice%
exit

:1
netsh interface ip set dns "以太网" source=dhcp
pause
exit

:2
netsh interface ip set dns "以太网" static 8.8.4.4 primary
netsh interface ip add dns "以太网" 8.8.8.8 2
pause
exit


:3
netsh interface ip set dns "以太网" static 223.5.5.5 primary
netsh interface ip add dns "以太网" 223.6.6.6 2
pause
exit
