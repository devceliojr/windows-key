::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyGY5LxJATQjCEGK5A7sP7dTZxsS7pUwJXOctd5zIzrWaJa4W8kCE
::fBE1pAF6MU+EWHreyGY5LxJATQjCEGK5A7sP7dTZxsS7sUEeGuYzdO8=
::fBE1pAF6MU+EWHreyGY5LxJATQjCEGK5A7sP7dS/wM+q5nFZEN4MfZvOyoi9I/Ia+lH3SaUowm9Ku8QBHBddahflbQIwyQ==
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJHSF91A/OyddQQO+Hnm7BbwS4Oe15umIwg==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF25
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF25
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBNQ
::cRYluBh/LU+EWAjk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsEAlTMbCXrZg==
::ZQ05rAF9IAHYFVzEqQIDIQhASQmDfG+/RpQI4f76TC0kYUJ9
::eg0/rx1wNQPfEVWB+kM9LVsJDCiLP260pXIdqMzy6OOTo0F9
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWH6W4VI/aChxZWQ=
::YQ03rBFzNR3SWATE01AlOBQUfyGrXA==
::dhAmsQZ3MwfNWATEphJie3s=
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@ECHO OFF
@echo off
@CHCP 1252 >NUL
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
mode con cols=60 lines=13
color 1f
title Pacote de Licenciamento
::===========================================================================
setlocal enabledelayedexpansion
setlocal EnableExtensions
pushd "%~dp0"
cd /d "%~dp0"
:MAINMENU
echo. :=======================================================:
echo.
Echo.     [1] Ativar Windows digitalmente
Echo.
Echo.     [2] Verificar se seu Windows est� ativo
echo. 
Echo.     [3] Outras alternativas
Echo.
echo. :=======================================================:
choice /C:123 /N /M " Escolha uma alternativa : "
if errorlevel 3 goto :OtherOptions
if errorlevel 2 goto :Check
if errorlevel 1 goto :HWIDActivate
::===========================================================================


:HWIDActivate
set slp=SoftwareLicensingProduct
FOR /F "tokens=3" %%I IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" ^| findstr CurrentVersion ^| findstr REG_SZ') DO (SET winver=%%I)
for /f "tokens=2* delims= " %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE"') do if "%%b"=="AMD64" (set vera=x64) else (set vera=x86)
for /f "tokens=2 delims== " %%A in ('"wmic path %slp% where (Name LIKE '%%Windows%%' and PartialProductKey is not null) get LicenseStatus /format:list"') do set status=%%A
FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition 2^>NUL ^| FIND /I "Current Edition :"') do set osedition=%%A

set "gatherosstate=%appdata%\gatherosstate.exe"
set "slc=%appdata%\slc.dll"

cscript /nologo c:\windows\system32\slmgr.vbs /xpr | findstr /i /c:" permanently "> NUL 2>&1
if [%errorlevel%]==[0] goto :Licensed
if [%errorlevel%]==[1] goto :GenerateHWIDA
::===============================================================================================================
:Licensed
mode con cols=68 lines=13
	 echo.
     echo  Verificando o status de ativa��o...
	 echo.
	 echo  Windows %osedition% %vera% est� permanentemente ativado.
     echo  Ativa��o n�o necess�ria.
	 echo.
     echo  Pressione qualquer tecla para continuar...
     pause >nul
	 mode con cols=60 lines=13
     goto:MainMenu
::===============================================================================================================
:GenerateHWIDA
cd /d "%~dp0"
cls
echo "LICEN�A DIGITAL DO WINDOWS [Windows %osedition% %vera%]"
echo:
if [%osedition%] == [Cloud] (
	set "edition=Cloud"
	set "key=V3WVW-N2PV2-CGWC3-34QGF-VMJ2C"
	set "sku=178"
	set "editionId=X21-32983"
	goto :parseAndPatch
)
if [%osedition%] == [CloudN] (
	set "edition=CloudN"
	set "key=NH9J3-68WK7-6FB93-4K3DF-DJ4F6"
	set "sku=179"
	set "editionId=X21-32987"
	goto :parseAndPatch
)
if [%osedition%] == [Core] (
	set "edition=Core"
	set "key=YTMG3-N6DKC-DKB77-7M9GH-8HVX7"
	set "sku=101"
	set "editionId=X19-98868"
	goto :parseAndPatch
)
if [%osedition%] == [CoreCountrySpecific] (
	set "edition=CoreCountrySpecific"
	set "key=N2434-X9D7W-8PF6X-8DV9T-8TYMD"
	set "sku=99"
	set "editionId=X19-99652"
	goto :parseAndPatch
)
if [%osedition%] == [CoreN] (
	set "edition=CoreN"
	set "key=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW"
	set "sku=98"
	set "editionId=X19-98877"
	goto :parseAndPatch
)
if [%osedition%] == [CoreSingleLanguage] (
	set "edition=CoreSingleLanguage"
	set "key=BT79Q-G7N6G-PGBYW-4YWX6-6F4BT"
	set "sku=100"
	set "editionId=X19-99661"
	goto :parseAndPatch
)
if [%osedition%] == [Education] (
	set "edition=Education"
	set "key=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY"
	set "sku=121"
	set "editionId=X19-98886"
	goto :parseAndPatch
)
if [%osedition%] == [EducationN] (
	set "edition=EducationN"
	set "key=84NGF-MHBT6-FXBX8-QWJK7-DRR8H"
	set "sku=122"
	set "editionId=X19-98892"
	goto :parseAndPatch
)
if [%osedition%] == [Enterprise] (
	set "edition=Enterprise"
	set "key=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C"
	set "sku=4"
	set "editionId=X19-99683"
	goto :parseAndPatch
)
if [%osedition%] == [EnterpriseN] (
	set "edition=EnterpriseN"
        set "key=3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT"
	set "sku=27"
	set "editionId=X19-98746"
	goto :parseAndPatch
)
if [%osedition%] == [EnterpriseS] (
	set "edition=EnterpriseS"
	set "key=NK96Y-D9CD8-W44CQ-R8YTK-DYJWX"
	set "sku=125"
	set "editionId=X21-05035"
	goto :parseAndPatch
)
if [%osedition%] == [EnterpriseSN] (
	set "edition=EnterpriseSN"
	set "key=2DBW3-N2PJG-MVHW3-G7TDK-9HKR4"
	set "sku=126"
	set "editionId=X21-04921"
	goto :parseAndPatch
)
if [%osedition%] == [Professional] (
	set "edition=Professional"
	set "key=VK7JG-NPHTM-C97JM-9MPGT-3V66T"
	set "sku=48"
	set "editionId=X19-98841"
	goto :parseAndPatch
)
if [%osedition%] == [ProfessionalEducation] (
	set "edition=ProfessionalEducation"
	set "key=8PTT6-RNW4C-6V7J2-C2D3X-MHBPB"
	set "sku=164"
	set "editionId=X21-04955"
	goto :parseAndPatch
)
if [%osedition%] == [ProfessionalEducationN] (
	set "edition=ProfessionalEducationN"
	set "key=GJTYN-HDMQY-FRR76-HVGC7-QPF8P"
	set "sku=165"
	set "editionId=X21-04956"
	goto :parseAndPatch
)
if [%osedition%] == [ProfessionalN] (
	set "edition=ProfessionalN"
	set "key=2B87N-8KFHP-DKV6R-Y2C8J-PKCKT"
	set "sku=49"
	set "editionId=X19-98859"
	goto :parseAndPatch
)
if [%osedition%] == [ProfessionalWorkstation] (
	set "edition=ProfessionalWorkstation"
	set "key=DXG7C-N36C4-C4HTG-X4T3X-2YV77"
	set "sku=161"
	set "editionId=X21-43626"
	goto :parseAndPatch
)
if [%osedition%] == [ProfessionalWorkstationN] (
	set "edition=ProfessionalWorkstationN"
	set "key=WYPNQ-8C467-V2W6J-TX4WX-WT2RQ"
	set "sku=162"
	set "editionId=X21-43644"
	goto :parseAndPatch
)
if [%osedition%] == [ServerRdsh] (
	set "edition=ServerRdsh"
	set "key=NJCF7-PW8QT-3324D-688JX-2YV66"
	set "sku=175"
	set "editionId=X21-41295"
	goto :parseAndPatch
)
::===============================================================================================================
:parseAndPatch
cls
mode con cols=97 lines=35
echo "Licen�a Digital do Windows [Windows %osedition% %vera%]"
echo:
echo Instalando a chave de produto padr�o para Windows %edition% %vera%...
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
echo:
cscript /nologo c:\windows\system32\slmgr.vbs /xpr | findstr /i /c:" permanently "> NUL 2>&1
if [%errorlevel%]==[0] goto :Activated
if [%errorlevel%]==[1] goto :GenerateTicket
:Activated
	 echo O Windows detectado %osedition% %vera% est� permanentemente ativado.
     echo A ativa��o n�o � necess�ria.
	 echo.
     echo Pressione qualquer tecla para continuar...
     pause >nul
	 mode con cols=60 lines=13
     goto:MainMenu
:GenerateTicket
echo Criando entradas de registro...
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f
echo:
echo Criar arquivo GenuineTicket.XML para Windows %edition% %vera%...
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1
echo:
echo O arquivo GenuineTicket.XML est� sendo instalado para Windows %edition% %vera%...
echo:
clipup -v -o -altto bin\
echo:
echo Windows %edition% %vera% ativando...
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ato
echo:
echo Excluindo entradas do registro...
reg delete "HKLM\SYSTEM\Tokens" /f
echo:
echo Pressione qualquer tecla para continuar...
pause >nul
CLS
mode con cols=60 lines=13
goto:MainMenu
:Check
CLS
mode con cols=70 lines=30
ECHO **********************************************************************
ECHO ***                       Windows Status                           ***
ECHO **********************************************************************
cscript //nologo %systemroot%\System32\slmgr.vbs /dli
cscript //nologo %systemroot%\System32\slmgr.vbs /xpr
ECHO ______________________________________________________________________
)
echo.
echo Pressione qualquer tecla para continuar...
pause >nul
CLS
mode con cols=60 lines=13
GOTO MAINMENU
::===============================================================================================================
:OtherOptions
CLS
mode con cols=60 lines=13
echo. :=======================================================:
Echo.
Echo.     [4] Inserir chave de produto padr�o
echo.
Echo.     [5] Ver Reposit�rio
Echo.       
Echo.     [6] V� para o menu principal
Echo.
echo. :=======================================================:
choice /C:456 /N /M "Escolha uma alternativa : "
if errorlevel 3 goto :GoToMainMenu
if errorlevel 2 goto :CheckForUpdates
if errorlevel 1 goto :InsertDefaultKey
::===========================================================================
:InsertDefaultKey
set slp=SoftwareLicensingProduct
FOR /F "tokens=3" %%I IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" ^| findstr CurrentVersion ^| findstr REG_SZ') DO (SET winver=%%I)
for /f "tokens=2* delims= " %%a in ('reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE"') do if "%%b"=="AMD64" (set vera=x64) else (set vera=x86)
for /f "tokens=2 delims== " %%A in ('"wmic path %slp% where (Name LIKE '%%Windows%%' and PartialProductKey is not null) get LicenseStatus /format:list"') do set status=%%A
FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition 2^>NUL ^| FIND /I "Current Edition :"') do set osedition=%%A

echo:
if [%osedition%] == [Cloud] (
	set "edition=Cloud"
	set "key=V3WVW-N2PV2-CGWC3-34QGF-VMJ2C"
	set "sku=178"
	set "editionId=X21-32983"
	goto :Insertkey
)
if [%osedition%] == [CloudN] (
	set "edition=CloudN"
	set "key=NH9J3-68WK7-6FB93-4K3DF-DJ4F6"
	set "sku=179"
	set "editionId=X21-32987"
	goto :Insertkey
)
if [%osedition%] == [Core] (
	set "edition=Core"
	set "key=YTMG3-N6DKC-DKB77-7M9GH-8HVX7"
	set "sku=101"
	set "editionId=X19-98868"
	goto :Insertkey
)
if [%osedition%] == [CoreCountrySpecific] (
	set "edition=CoreCountrySpecific"
	set "key=N2434-X9D7W-8PF6X-8DV9T-8TYMD"
	set "sku=99"
	set "editionId=X19-99652"
	goto :Insertkey
)
if [%osedition%] == [CoreN] (
	set "edition=CoreN"
	set "key=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW"
	set "sku=98"
	set "editionId=X19-98877"
	goto :Insertkey
)
if [%osedition%] == [CoreSingleLanguage] (
	set "edition=CoreSingleLanguage"
	set "key=BT79Q-G7N6G-PGBYW-4YWX6-6F4BT"
	set "sku=100"
	set "editionId=X19-99661"
	goto :Insertkey
)
if [%osedition%] == [Education] (
	set "edition=Education"
	set "key=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY"
	set "sku=121"
	set "editionId=X19-98886"
	goto :Insertkey
)
if [%osedition%] == [EducationN] (
	set "edition=EducationN"
	set "key=84NGF-MHBT6-FXBX8-QWJK7-DRR8H"
	set "sku=122"
	set "editionId=X19-98892"
	goto :Insertkey
)
if [%osedition%] == [Enterprise] (
	set "edition=Enterprise"
	set "key=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C"
	set "sku=4"
	set "editionId=X19-99683"
	goto :Insertkey
)
if [%osedition%] == [EnterpriseN] (
	set "edition=EnterpriseN"
        set "key=3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT"
	set "sku=27"
	set "editionId=X19-98746"
	goto :Insertkey
)
if [%osedition%] == [EnterpriseS] (
	set "edition=EnterpriseS"
	set "key=NK96Y-D9CD8-W44CQ-R8YTK-DYJWX"
	set "sku=125"
	set "editionId=X21-05035"
	goto :Insertkey
)
if [%osedition%] == [EnterpriseSN] (
	set "edition=EnterpriseSN"
	set "key=2DBW3-N2PJG-MVHW3-G7TDK-9HKR4"
	set "sku=126"
	set "editionId=X21-04921"
	goto :Insertkey
)
if [%osedition%] == [Professional] (
	set "edition=Professional"
	set "key=VK7JG-NPHTM-C97JM-9MPGT-3V66T"
	set "sku=48"
	set "editionId=X19-98841"
	goto :Insertkey
)
if [%osedition%] == [ProfessionalEducation] (
	set "edition=ProfessionalEducation"
	set "key=8PTT6-RNW4C-6V7J2-C2D3X-MHBPB"
	set "sku=164"
	set "editionId=X21-04955"
	goto :Insertkey
)
if [%osedition%] == [ProfessionalEducationN] (
	set "edition=ProfessionalEducationN"
	set "key=GJTYN-HDMQY-FRR76-HVGC7-QPF8P"
	set "sku=165"
	set "editionId=X21-04956"
	goto :Insertkey
)
if [%osedition%] == [ProfessionalN] (
	set "edition=ProfessionalN"
	set "key=2B87N-8KFHP-DKV6R-Y2C8J-PKCKT"
	set "sku=49"
	set "editionId=X19-98859"
	goto :Insertkey
)
if [%osedition%] == [ProfessionalWorkstation] (
	set "edition=ProfessionalWorkstation"
	set "key=DXG7C-N36C4-C4HTG-X4T3X-2YV77"
	set "sku=161"
	set "editionId=X21-43626"
	goto :Insertkey
)
if [%osedition%] == [ProfessionalWorkstationN] (
	set "edition=ProfessionalWorkstationN"
	set "key=WYPNQ-8C467-V2W6J-TX4WX-WT2RQ"
	set "sku=162"
	set "editionId=X21-43644"
	goto :Insertkey
)
if [%osedition%] == [ServerRdsh] (
	set "edition=ServerRdsh"
	set "key=NJCF7-PW8QT-3324D-688JX-2YV66"
	set "sku=175"
	set "editionId=X21-41295"
	goto :Insertkey
)
::===============================================================================================================
:Insertkey
CLS
mode con cols=85 lines=10
echo Instalando a chave de produto padr�o para Windows %edition% %vera%...
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%

echo Pressione qualquer tecla para continuar...
pause >nul
goto:OtherOptions
::===============================================================================================================
:CheckForUpdates
start https://github.com/devceliojr
goto:OtherOptions
::===============================================================================================================
:GoToMainMenu
CLS
mode con cols=60 lines=13
GOTO MAINMENU
::===============================================================================================================