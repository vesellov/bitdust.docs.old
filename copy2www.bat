@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

IF "%~1" == "" GOTO COPY_ALL

set fmd=%~1
set fhtml=!fmd:~0,-3!.html
@echo !fhtml! 

cp -rfv @build\!fhtml! ../bitdust.www.english
GOTO END

:COPY_ALL


cp -rfv @build/*.html ../bitdust.www.english
           

REM cp -rfv @build/automats         ../bitdust.www.english
cp -rfv @build/chat             ../bitdust.www.english
cp -rfv @build/customer         ../bitdust.www.english
cp -rfv @build/main             ../bitdust.www.english
cp -rfv @build/p2p              ../bitdust.www.english
cp -rfv @build/raid             ../bitdust.www.english
cp -rfv @build/services         ../bitdust.www.english
cp -rfv @build/storage          ../bitdust.www.english
cp -rfv @build/stun             ../bitdust.www.english
cp -rfv @build/supplier         ../bitdust.www.english
cp -rfv @build/transport        ../bitdust.www.english
cp -rfv @build/userid           ../bitdust.www.english


:END

@echo [DONE!]
