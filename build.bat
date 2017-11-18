@echo off

SETLOCAL ENABLEDELAYEDEXPANSION


IF "%~1" == "" GOTO BUILD_ALL

set fmd=%~1
set fhtml=!fmd:~0,-3!.html
@echo !fhtml! 
python md2html.py !fmd! > @build\!fhtml!
python fix_html.py @build\!fhtml! @build\!fhtml! %~2
GOTO END

:BUILD_ALL

@echo [build all, clean @build folder]
if exist @build\NUL rmdir /S /Q @build
mkdir @build

@echo [./]
for %%i in (*.md) DO (
    set fmd=%%i
    set fhtml=!fmd:~0,-3!.html
    @echo !fhtml! 
    python md2html.py !fmd! > @build\!fhtml!
    python fix_html.py @build\!fhtml! @build\!fhtml! 
)

REM rm -rf @build/index.html
REM cp -rf @build/README.html @build/index.html

@echo [./automats]
REM mkdir @build\automats
REM cp -rf automats/*.png  @build\automats
REM cp -rf automats/*.pdf  @build\automats

@echo [../bitdust.visual/chat]
mkdir @build\chat
cp -rf ../bitdust.visual/chat/*.png  @build\chat
cp -rf ../bitdust.visual/chat/*.pdf  @build\chat
cp -rf ../bitdust.visual/chat/*.vsd  @build\chat

@echo [../bitdust.visual/customer]
mkdir @build\customer
cp -rf ../bitdust.visual/customer/*.png  @build\customer
cp -rf ../bitdust.visual/customer/*.pdf  @build\customer
cp -rf ../bitdust.visual/customer/*.vsd  @build\customer

@echo [../bitdust.visual/main]
mkdir @build\main
cp -rf ../bitdust.visual/main/*.png  @build\main
cp -rf ../bitdust.visual/main/*.pdf  @build\main
cp -rf ../bitdust.visual/main/*.vsd  @build\main

@echo [../bitdust.visual/p2p]
mkdir @build\p2p
cp -rf ../bitdust.visual/p2p/*.png  @build\p2p
cp -rf ../bitdust.visual/p2p/*.pdf  @build\p2p
cp -rf ../bitdust.visual/p2p/*.vsd  @build\p2p

@echo [../bitdust.visual/raid]
mkdir @build\raid
cp -rf ../bitdust.visual/raid/*.png  @build\raid
cp -rf ../bitdust.visual/raid/*.pdf  @build\raid
cp -rf ../bitdust.visual/raid/*.vsd  @build\raid

@echo [../bitdust.visual/services]
mkdir @build\services
cp -rf ../bitdust.visual/services/*.png  @build\services
cp -rf ../bitdust.visual/services/*.pdf  @build\services
cp -rf ../bitdust.visual/services/*.vsd  @build\services

@echo [../bitdust.visual/storage]
mkdir @build\storage
cp -rf ../bitdust.visual/storage/*.png  @build\storage
cp -rf ../bitdust.visual/storage/*.pdf  @build\storage
cp -rf ../bitdust.visual/storage/*.vsd  @build\storage

@echo [../bitdust.visual/stun]
mkdir @build\stun
cp -rf ../bitdust.visual/stun/*.png  @build\stun
cp -rf ../bitdust.visual/stun/*.pdf  @build\stun
cp -rf ../bitdust.visual/stun/*.vsd  @build\stun

@echo [../bitdust.visual/supplier]
mkdir @build\supplier
cp -rf ../bitdust.visual/supplier/*.png  @build\supplier
cp -rf ../bitdust.visual/supplier/*.pdf  @build\supplier
cp -rf ../bitdust.visual/supplier/*.vsd  @build\supplier

@echo [../bitdust.visual/transport]
mkdir @build\transport
cp -rf ../bitdust.visual/transport/*.png  @build\transport
cp -rf ../bitdust.visual/transport/*.pdf  @build\transport
cp -rf ../bitdust.visual/transport/*.vsd  @build\transport

@echo [../bitdust.visual/userid]
mkdir @build\userid
cp -rf ../bitdust.visual/userid/*.png  @build\userid
cp -rf ../bitdust.visual/userid/*.pdf  @build\userid
cp -rf ../bitdust.visual/userid/*.vsd  @build\userid


:END

@echo [DONE!]

