@echo off
setlocal EnableDelayedExpansion
title Rusifier uninstaller - The Path Into The Abyss
set "SUBPATH=steamapps\common\The Path Into The Abyss Demo\Windows\AbyssGame\Content\Paks"
set "TARGET="

for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul ^| find "SteamPath"') do set "STEAM=%%b"
if defined STEAM (
  set "STEAM=!STEAM:/=\!"
  if exist "!STEAM!\%SUBPATH%\AbyssGame-Windows_RU_P.pak" set "TARGET=!STEAM!\%SUBPATH%"
)
if not defined TARGET (
  for %%d in ("C:\Program Files (x86)\Steam" "C:\Steam" "C:\SteamLibrary" "D:\Steam" "D:\SteamLibrary" "E:\Steam" "E:\SteamLibrary" "F:\Steam" "F:\SteamLibrary") do (
    if not defined TARGET if exist "%%~d\%SUBPATH%\AbyssGame-Windows_RU_P.pak" set "TARGET=%%~d\%SUBPATH%"
  )
)
if not defined TARGET (
  echo Rusifier pak not found - maybe already removed.
  pause
  exit /b 0
)

del /f /q "%TARGET%\AbyssGame-Windows_RU_P.pak"
echo Rusifier removed. The game is back to original languages.
pause
