@echo off
title Network Diagnostic

echo Input target resource for diagnostic (URL):
set /p url=Enter URL:

echo From Location:
set /p location=Enter Your Location:

echo PLEASE DO NOT TOUCH THE KEYBOARD! SCRIPT IS WORKING AND CLOSE BY ITSELF/NE TROGAITE KLAVIATURU, ONO SAMO SHLOPNETSA

mkdir Report & cd .\Report

echo %location% >alocation.txt

nslookup %url% >bnslookup.txt

ping %url% >cping.txt

tracert %url% >dtracert.txt

powershell tnc %url% >etncr.txt

powershell tnc %url% -port 80 >ftncr2.txt

powershell tnc %url% -port 443 >gtncr3.txt

ipconfig /all >hipconfig.txt

copy *.txt NetCheckReport.txt

del alocation.txt bnslookup.txt cping.txt dtracert.txt etncr.txt ftncr2.txt gtncr3.txt hipconfig.txt

cd ..\

copy .\Report\NetCheckReport.txt NetCheckReport_%url%_%date:~-7,2%.%date:~-10,2%.%date:~-4,4%_%time:~0,2%.%time:~3,2%.txt

rmdir /Q /S Report 

exit
