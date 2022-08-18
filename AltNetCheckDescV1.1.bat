@echo off
title Network Diagnostic

echo Input target resource for diagnostic (URL):
set /p UrlVar=Enter URL WITHOUT https://

echo From Location:
set /p LocationVar=Enter Your Location:

echo PLEASE DO NOT TOUCH THE KEYBOARD! SCRIPT IS WORKING AND CLOSE BY ITSELF/NE TROGAITE KLAVIATURU, ONO SAMO SHLOPNETSA

mkdir Report & cd .\Report

::Time information
echo TIME INFORMATION: > 01TimeFile.txt   
powershell Get-Date -Format "dd.mm.yyyy_HH.mm.ss" >TmpTimeFile.txt
set /p TimeVar= < TmpTimeFile.txt 
echo %TimeVar% >>01TimeFile.txt
echo ________________________________________ >>01TimeFile.txt
del TmpTimeFile.txt

::Info about office location
echo OFFICE LOCATION: >02LocationFile.txt
echo %LocationVar% >>02LocationFile.txt
echo ________________________________________ >>02LocationFile.txt

::Info about URL
echo WEBSITE URL: >03UrlFile.txt 
echo %UrlVar% >>03UrlFile.txt
echo WEBSITE STATUS CODE: >>03UrlFile.txt
powershell "Invoke-WebRequest -uri %UrlVar% | Select-Object   "StatusCode"" >>03UrlFile.txt
echo ________________________________________ >>03UrlFile.txt

::Info about PC
echo USER AND DOMAIN INFO: >04IpconfigFile.txt
whoami >>04IpconfigFile.txt
echo: >>04IpconfigFile.txt
echo ________________________________________ >>04IpconfigFile.txt
echo PC INFO IPCONFIG RESULT: >>04IpconfigFile.txt
ipconfig >>04IpconfigFile.txt
echo ________________________________________ >>04IpconfigFile.txt

::Info about Public IP
echo PUBLICK IP: >05PublicIpFile.txt
curl 2ip.com.ua >>05PublicIpFile.txt
echo ________________________________________ >>05PublicIpFile.txt

::Info about PING
echo PING RESULT: >06PingFile.txt
ping -w 1000 %UrlVar% >>06PingFile.txt
echo ________________________________________ >>06PingFile.txt

::Info ablot TRASERT
echo TRASERT RESULT: >07TrasertFile.txt
tracert -d -w 1000 %UrlVar% >>07TrasertFile.txt
echo ________________________________________ >>07TrasertFile.txt

::Info about DNS
echo NSLOOKUP RESULT: >08NslookupFile.txt
nslookup %UrlVar% >>08NslookupFile.txt
echo ________________________________________ >>08NslookupFile.txt

::Info about All Intefaces 
echo IPCONFIGALL RESULT: >09IpconfigallFile.txt
ipconfig /all >>09IpconfigallFile.txt
echo ________________________________________ >>09IpconfigallFile.txt

::Creation one file with all information
copy *.txt NetCheckReport.txt

::Cleaning all temp file excluding NetCheckReport.txt
del 01TimeFile.txt 02LocationFile.txt 03UrlFile.txt 04IpconfigFile.txt 05PublicIpFile.txt 06PingFile.txt 07TrasertFile.txt 08NslookupFile.txt 09IpconfigallFile.txt timetmpFile.txt 

::Copy and rename report file and delete temp folder
cd ..\
copy .\Report\NetCheckReport.txt NetCheckReport_%UrlVar%_%TimeVar%.txt
rmdir /Q /S Report 

exit