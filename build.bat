@echo off

SETLOCAL ENABLEDELAYEDEXPANSION


IF "%~1" == "" GOTO BUILD_ALL

set fmd=%~1
set fhtml=!fmd:~0,-3!.html
@echo !fhtml! 
python md2html.py !fmd! > !fhtml!
python fix_html.py !fhtml! !fhtml! styles.css    
GOTO END

:BUILD_ALL

rm -rf Home.md

for %%i in (*.md) DO (
    set fmd=%%i
    set fhtml=!fmd:~0,-3!.html
    @echo !fhtml! 
    python md2html.py !fmd! > !fhtml!
    python fix_html.py !fhtml! !fhtml! styles.css    
)

cp index.md Home.md

rem python build_html.py services ../bitpie/services
rem python build_html.py p2p ../bitpie/p2p

rem @echo services.pdf
rem cp ../bitpie/services/services.pdf .
rem @echo services.png
rem cp ../bitpie/services/services.png .

:END
