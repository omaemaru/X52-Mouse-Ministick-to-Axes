@echo off

REM Get the directory of the script
set scriptDir=%~dp0
cd /d "%scriptDir%"

REM Check for administrator privileges
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo.
	echo Please run "Installer" instead.
    echo.
	ping -n 3 127.0.0.1 > NUL
    exit /b
)

type stick.txt

echo.
echo.

REM Choose device type
:menu
echo.
echo 1. X52 H.O.T.A.S.
echo 2. X52 PROFESSIONAL H.O.T.A.S.
echo.
set /p device="Select your device type (1 or 2): "

if "%device%"=="1" goto X52
if "%device%"=="2" goto X52_PRO
echo Invalid choice. Please select 1 or 2.
ping -n 3 127.0.0.1 > NUL
goto menu

:X52
cls
echo.
echo.
echo Choose which Axis you wish to sacrifice or if you want to restore:
echo 1. Restore (Default)
echo 2. Rudder
echo 3. Bottom Rotary
echo 4. Top Rotary
echo 5. Slider
echo.
set /p axis="Type in your selection: "

if "%axis%"=="1" goto Restore
if "%axis%"=="2" goto Rudder
if "%axis%"=="3" goto Bottom_Rotary
if "%axis%"=="4" goto Top_Rotary
if "%axis%"=="5" goto Slider

echo Invalid choice. Please select the correct one.
ping -n 3 127.0.0.1 > NUL
goto X52

:Restore
regedit /s "X52\Restore.reg"
goto Calibrate

:Rudder
regedit /s "X52\Rudder.reg"
goto Disable_Mouse_Driver

:Bottom_Rotary
regedit /s "X52\Bottom Rotary.reg"
goto Disable_Mouse_Driver

:Top_Rotary
regedit /s "X52\Top Rotary.reg"
goto Disable_Mouse_Driver

:Slider
regedit /s "X52\Slider.reg"
goto Disable_Mouse_Driver

:X52_PRO
cls
echo.
echo.
echo Choose which Axis you wish to sacrifice or if you want to restore:
echo 1. Restore (Default)
echo 2. Rudder
echo 3. Bottom Rotary
echo 4. Top Rotary
echo 5. Slider
echo.
set /p axis="Type in your selection: "

if "%axis%"=="1" goto Restore
if "%axis%"=="2" goto Rudder
if "%axis%"=="3" goto Bottom_Rotary
if "%axis%"=="4" goto Top_Rotary
if "%axis%"=="5" goto Slider

echo Invalid choice. Please select the correct one.
ping -n 3 127.0.0.1 > NUL
goto X52_PRO

:Restore
regedit /s "X52 Pro\Restore.reg"
goto Calibrate

:Rudder
regedit /s "X52 Pro\Rudder.reg"
goto Disable_Mouse_Driver

:Bottom_Rotary
regedit /s "X52 Pro\Bottom Rotary.reg"
goto Disable_Mouse_Driver

:Top_Rotary
regedit /s "X52 Pro\Top Rotary.reg"
goto Disable_Mouse_Driver

:Slider
regedit /s "X52 Pro\Slider.reg"
goto Disable_Mouse_Driver

:Disable_Mouse_Driver
cls
echo.
echo.
echo Registry changes applied. Disabling Mouse Driver...
echo.
ping -n 2 127.0.0.1 > NUL
pnputil /disable-device "HID\SAITEKMOUSE\2&FB7B623&0&0000"
echo.
echo Mouse Driver disabled. Installation completed.
echo.
echo Calibrating now...
ping -n 5 127.0.0.1 > NUL
goto Calibrate

:Calibrate
cls
echo.
echo Unplug your H.O.T.A.S USB cable from your computer, press any key to continue.
pause 
regedit /s "X52_Pro\Clear Calibration.reg"
regedit /s "X52\Clear Calibration.reg"

cls
echo.
echo Reconnect your H.O.T.A.S USB cable to the computer.
pause

cls
echo.
echo Select H.O.T.A.S, click properties and move all axes to their full range of motion four times to rebuild data range.
ping -n 6 127.0.0.1 > NUL
start control.exe joy.cpl

:waitloop
tasklist /FI "IMAGENAME eq rundll32.exe" 2>NUL | find /I /N "rundll32.exe">NUL
if "%ERRORLEVEL%"=="0" (
    timeout /T 1 /NOBREAK >NUL
    goto waitloop
)

echo.
echo Calibration completed, exiting...
echo.
type leaving.txt
ping -n 6 127.0.0.1 > NUL

exit