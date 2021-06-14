@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo Mencari Admin Akses!
goto UACPrompt
) else ( goto KetemuAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:KetemuAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSmallIcons /t REG_DWORD /d 1 /f
powershell -Command "& {Invoke-WebRequest https://drive.google.com/u/0/uc?id=1lLAAItvJDwREs_Kk0VKvK7l13HH3wBOX -OutFile wallpaper.zip; Expand-Archive wallpaper.zip; Remove-Item wallpaper.zip}"
@D:\a\wallpaper\wallpaper.exe D:\a\wallpaper\wallpaper.bgi /timer:0
@RD /S /Q wallpaper
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
taskkill /f /im explorer.exe
start explorer.exe
