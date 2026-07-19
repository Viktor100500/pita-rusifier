@echo off
setlocal EnableDelayedExpansion
title Rusifier installer - The Path Into The Abyss
set "PAK=%~dp0AbyssGame-Windows_RU_P.pak"
set "SUBPATH=steamapps\common\The Path Into The Abyss Demo\Windows\AbyssGame\Content\Paks"

if not exist "%PAK%" (
  echo [ERROR] AbyssGame-Windows_RU_P.pak not found next to install.bat
  pause
  exit /b 1
)

set "TARGET="

rem -- 1. Steam path from registry --
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul ^| find "SteamPath"') do set "STEAM=%%b"
if defined STEAM (
  set "STEAM=!STEAM:/=\!"
  if exist "!STEAM!\%SUBPATH%" set "TARGET=!STEAM!\%SUBPATH%"
)

rem -- 2. Common locations --
if not defined TARGET (
  for %%d in ("C:\Program Files (x86)\Steam" "C:\Steam" "C:\SteamLibrary" "D:\Steam" "D:\SteamLibrary" "E:\Steam" "E:\SteamLibrary" "F:\Steam" "F:\SteamLibrary") do (
    if not defined TARGET if exist "%%~d\%SUBPATH%" set "TARGET=%%~d\%SUBPATH%"
  )
)

rem -- 3. Ask the user --
if not defined TARGET (
  echo Game folder not found automatically.
  echo Enter full path to "The Path Into The Abyss Demo" folder,
  echo for example: D:\Games\Steam\steamapps\common\The Path Into The Abyss Demo
  set /p "GAMEDIR=Path: "
  if exist "!GAMEDIR!\Windows\AbyssGame\Content\Paks" set "TARGET=!GAMEDIR!\Windows\AbyssGame\Content\Paks"
)

if not defined TARGET (
  echo [ERROR] Game folder not found. Copy the pak file manually, see README.txt
  pause
  exit /b 1
)

copy /y "%PAK%" "%TARGET%\" >nul
if errorlevel 1 (
  echo [ERROR] Copy failed. Try running install.bat as administrator.
  pause
  exit /b 1
)

echo.
echo Done. Rusifier installed to:
echo   %TARGET%
echo Uspeshno ustanovleno. Zapuskaite igru.
pause
