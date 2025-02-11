@echo off
setlocal enabledelayedexpansion

:loop
cls
color 0c
:: Ask for target IP
set /p targetIP=Enter the target IP address: 

:: List of ports to check
set ports=21 22 23 25 53 69 80 110 143 161 162 389 443 445 1194 1433 1521 3389

echo Checking open ports on !targetIP!..

:: Loop through each port and check connectivity
for %%p in (!ports!) do (
    echo Checking port %%p...
    powershell -command "$t = New-Object System.Net.Sockets.TcpClient; try { $t.Connect('!targetIP!', %%p); if($t.Connected) { echo Port %%p is OPEN; $t.Close() } } catch { echo Port %%p is CLOSED }" 2>nul | find "OPEN" >nul
    if not errorlevel 1 (
        echo Port %%p is OPEN >> [open].txt
		color 0a
        echo Port %%p is [OPEN]
    ) else (
		echo port %%p is closed >> [closed].txt		
        echo Port %%p is [CLOSED]
		
    )	
)

echo Scan complete! Results saved in open And closed files
pause
goto loop
