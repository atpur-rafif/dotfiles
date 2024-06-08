# Dont forget add thsi to C:\Users\USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
# * Change USERNAME respectively
# @echo off
# Powershell C:/Users/main/.config/startup.ps1

Start-Process -WindowStyle hidden Powershell.exe -ArgumentList "komorebic-start"
Start-Process -WindowStyle hidden Powershell.exe -ArgumentList "komorebic-ahk-start"
