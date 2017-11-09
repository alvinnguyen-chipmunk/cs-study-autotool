;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

   !include "MUI2.nsh"
   !include "EnvVarUpdate.nsh" #download http://nsis.sourceforge.net/mediawiki/images/a/ad/EnvVarUpdate.7z

;   !include "StrFunc.nsh"
 ;  !include "WordFunc.nsh"
 ;  !include "registry.nsh"
 ;  !include "LogicLib.nsh"
 ;  !include "WinVer.nsh"
;--------------------------------
;General

;------------------------------
;Include Mime Type
 ;   !include "FileAssociation.nsh"
;

Name "Autotool Demo"
SetCompressor /SOLID bzip2
OutFile "styl_autotool_demo.exe"
;Default installation folder
InstallDir $PROGRAMFILES\styl\autotool
LicenseText "License"
LicenseData "license.txt"

!define VERSION  ${__DATE__}
!define PATH	$R8
!define SETUP_NAME "STYL Autotool"
!define TEMP1 $R0 ;Temp variable
!define PACKAGE "AutotoolDemo" ;Temp variable
!define DIR_REGISTRY "SOFTWARE\styl\autotool_demo"
!define DIR_UNINSTALL_REGISTRY "Software\Microsoft\Windows\CurrentVersion\Uninstall\autotool_demo"
;------------------------------------------------------------


BrandingText "STYL Autotool Demo Installer"
;Icon "C:\Program Files (x86)\NSISPortable\App\NSIS\Contrib\Graphics\Icons\arrow2-install.ico"
; MUI Settings / Icons
!define MUI_ICON  "light.ico"
!define MUI_UNICON  "light.ico"
CRCCheck          on
ShowInstDetails   show
VIProductVersion  0.0.0.1

VIAddVersionKey   ProductName    StylAutotoolDemoSetup
VIAddVersionKey   ProductVersion  "${VERSION}"
VIAddVersionKey   CompanyName     "styl"
VIAddVersionKey   FileVersion     "${VERSION}"
VIAddVersionKey   FileDescription "STYL autotool demo"
VIAddVersionKey   LegalCopyright  ""


ShowInstDetails show

XPStyle on


;--------------------------------
;Interface Settings
 !define MUI_ABORTWARNING
 ;Show all languages, despite user's codepage
 !define MUI_LANGDLL_ALLLANGUAGES
;--------------------------------
;Language Selection Dialog Settings
  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY ${DIR_REGISTRY}
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Install software"

;--------------------------------
;Pages



!define MUI_LICENSEPAGE_RADIOBUTTONS
!insertmacro MUI_PAGE_WELCOME
	!insertmacro MUI_PAGE_LICENSE $(license)
	!insertmacro MUI_PAGE_COMPONENTS
	!insertmacro MUI_PAGE_DIRECTORY
        !insertmacro MUI_PAGE_INSTFILES
	!insertmacro MUI_PAGE_FINISH
	!insertmacro MUI_UNPAGE_WELCOME
	!insertmacro MUI_UNPAGE_CONFIRM
	!insertmacro MUI_UNPAGE_INSTFILES
	!insertmacro MUI_UNPAGE_FINISH
;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English" ;first language is the default language
  


;--------------------------------
;Reserve Files

  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.

  

LicenseLangString license  ${LANG_ENGLISH} "license.txt"

;--------------------------------

Section "-${SETUP_NAME}' Files" SecDummy

        SetOutPath "$INSTDIR"
	File /r ${PACKAGE}\bin
	File /r ${PACKAGE}\include
        File /r ${PACKAGE}\lib
        ${EnvVarUpdate} $0 "PATH" "A" "HKLM" $INSTDIR\bin
	WriteUninstaller $INSTDIR\Uninstall.exe
	; Write the installation path into the registry
	WriteRegStr HKLM ${DIR_REGISTRY} "Install_Dir" "$INSTDIR"
	; Write the uninstall keys for Windows
	WriteRegStr HKLM ${DIR_UNINSTALL_REGISTRY} "UninstallString" '$INSTDIR\Uninstall.exe'
	WriteRegDWORD HKLM ${DIR_UNINSTALL_REGISTRY} "NoModify" 1
	WriteRegDWORD HKLM ${DIR_UNINSTALL_REGISTRY} "NoRepair" 1
	# later, inside a section:
	;${registerExtension} "$INSTDIR\bin\StylSheelExample.exe" ".StylSheelExample" "STYL Autotool Demo File"
SectionEnd


Section "Links in Start Menu"
	CreateDirectory "$SMPROGRAMS\StylAutotoolDemo"
	CreateShortCut "$SMPROGRAMS\StylAutotoolDemo\StylAutotoolDemo.lnk" "$INSTDIR\bin\StylAutotoolDemo.exe"
	CreateShortCut "$SMPROGRAMS\StylAutotoolDemo\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Links in Desktop"
	CreateShortCut "$DESKTOP\StylAutotoolDemo.lnk" "$INSTDIR\bin\StylAutotoolDemo.exe"
SectionEnd
;Function LaunchLink
;   ExecShell "" "$DESKTOP\StylAutotoolDemo.lnk"
;FunctionEnd
;--------------------------------
;Installer Functions
Function .onInit
     ;process exists
		;Processes::FindProcess "StylAutotoolDemo.exe"
		;StrCmp $R0 "1" pro_equal pro_no_equal

		;pro_equal:
		;	MessageBox MB_YESNO|MB_ICONQUESTION "StylAutotoolDemo is already running. Do you want to exit the program to continue setup?$\n Warring: your project may be lost, you should backup before setup." IDNO NoAbort_pro
		;		Processes::KillProcess "StylAutotoolDemo.exe"
		;		Goto pro_no_equal
		;	NoAbort_pro:
		;		Quit

		;pro_no_equal:
	;--------------------
        ReCheckUninstall:
	ReadRegStr $1 HKLM "${DIR_REGISTRY}\" "Install_Dir"
	${If} '$1' != ""
	    IfFileExists "$1\Uninstall.exe"  msgUninstall continue
	    msgUninstall:
                        MessageBox MB_YESNO "Do you want to uninstall the available StylAutotoolDemo software and continue to setup $1?" IDNO NoAbort1
			ExecWait  '"$1\Uninstall.exe" _?=$1' $0
			;MessageBox MB_OK "result= $0"
			${If} $0 <> 0
				MessageBox MB_OK "Error: uninstall StylAutotoolDemo"
			        goto  continue
                        ${EndIf}
                                ;goto  continue
                                goto ReCheckUninstall
                                
	     NoAbort1:
		Quit
         ${EndIf}
         continue:
FunctionEnd


;--------------------------------
;Uninstaller Section

Section "Uninstall"
	MessageBox MB_YESNO "Do you want to uninstall ${SETUP_NAME}?" IDYES NoAbort
		Quit
NoAbort:
	; ------------- delete file ---------------------
	RMDir /r $INSTDIR\bin
	RMDir /r $INSTDIR\include
        RMDir /r $INSTDIR\lib
        RMDir /r $INSTDIR\share
        RMDir /r "$SMPROGRAMS\StylAutotoolDemo"
	DeleteRegKey /ifempty HKCU ${DIR_REGISTRY}
	DeleteRegKey HKLM ${DIR_UNINSTALL_REGISTRY}
	DeleteRegKey HKLM ${DIR_REGISTRY}
	${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" $INSTDIR
        Delete $INSTDIR\Uninstall.exe
        ;RMDir /r $INSTDIR
	;${unregisterExtension} ".StylAutotoolDemo" "Styl Autotool Demo File"
SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit


FunctionEnd


