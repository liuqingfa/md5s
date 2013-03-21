@echo off
REM ��Ա�����߲��������κ����Σ���֪��ϸ��鿴 GPL.txt
REM ����һ�����ɵĳ��򣬻�ӭ�����ض��������ٴη���������
REM
REM �ٴθ�л��ʹ�ñ��ű�
REM �߲�����
REM

set /p HTML_TITLE=������ HTML ���⣬Ĭ�� [���ģʽ]: 
if not defined HTML_TITLE set HTML_TITLE=���ģʽ
set /p FOOTER_TITLE=������ footer ���⣬Ĭ�� [���ģʽ]: 
if not defined FOOTER_TITLE set FOOTER_TITLE=���ģʽ
set FOOTER_INFO=%date:~0,-4% @ %username%

REM ���Ʊ���
set IS_START_NEW=%2
set OUT_FOLDER=C:\AppServ\www\md5s
set BROWSER_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe
set OPEN_PATH=http://localhost/md5s
set OUTPUT=%~n1
set S5_PATH=s5/
set MD_FILE="%~dpnx1"
set MARKDOWN_CALL=Markdown.pl

if not exist %MD_FILE% (
	echo MD_FILE ^(%MD_FILE%^) �ļ�������
	goto err
)

REM header
set /p=�������� header . . < nul
echo ^<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"^>> %tmp%\%OUTPUT%.header
echo ^<!-- All contents under GPL license. loving Delly, NEO's Edition is Okay~ --^>>> %tmp%\%OUTPUT%.header
echo.^<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" xml:lang="zh-CN"^>>> %tmp%\%OUTPUT%.header
echo.^<head^>>> %tmp%\%OUTPUT%.header
echo.	^<meta http-equiv="Content-type" content="text/html; charset=GBK"^>>> %tmp%\%OUTPUT%.header
echo.	^<title^>%HTML_TITLE%^</title^>>> %tmp%\%OUTPUT%.header
echo.	^<meta name="generator" content="%~n0 v0.2"^>>> %tmp%\%OUTPUT%.header
echo.	^<meta name="version" content="S5 1.1"^>>> %tmp%\%OUTPUT%.header
echo.	^<meta name="author" content="Neo"^>>> %tmp%\%OUTPUT%.header
echo.	^<meta name="company" content="NEO's Edition is Okay~"^>>> %tmp%\%OUTPUT%.header
echo.>> %tmp%\%OUTPUT%.header
echo.	^<meta name="defaultView" content="slideshow" /^>>> %tmp%\%OUTPUT%.header
echo.	^<meta name="controlVis" content="hidden" /^>>> %tmp%\%OUTPUT%.header
echo.	^<link rel="stylesheet" href="%S5_PATH%slides.css" type="text/css" media="projection" id="slideProj" /^>>> %tmp%\%OUTPUT%.header
echo.	^<link rel="stylesheet" href="%S5_PATH%outline.css" type="text/css" media="screen" id="outlineStyle" /^>>> %tmp%\%OUTPUT%.header
echo.	^<link rel="stylesheet" href="%S5_PATH%print.css" type="text/css" media="print" id="slidePrint" /^>>> %tmp%\%OUTPUT%.header
echo.	^<link rel="stylesheet" href="%S5_PATH%opera.css" type="text/css" media="projection" id="operaFix" /^>>> %tmp%\%OUTPUT%.header
echo.>> %tmp%\%OUTPUT%.header
echo.	^<style^>img { width: 100%%; border: 1px solid black; }^</style^>>> %tmp%\%OUTPUT%.header
echo.>> %tmp%\%OUTPUT%.header
echo.	^<script src="%S5_PATH%slides.js" type="text/javascript"^>^</script^>>> %tmp%\%OUTPUT%.header
echo.^</head^>>> %tmp%\%OUTPUT%.header
echo.^<body^>>> %tmp%\%OUTPUT%.header
echo.	^<div class="layout"^>>> %tmp%\%OUTPUT%.header
echo.		^<div id="controls"^>^</div^>>> %tmp%\%OUTPUT%.header
echo.		^<div id="currentSlide"^>^</div^>>> %tmp%\%OUTPUT%.header
echo.		^<div id="header"^>^</div^>>> %tmp%\%OUTPUT%.header
echo.		^<div id="footer"^>>> %tmp%\%OUTPUT%.header
echo.			^<h1^>%FOOTER_TITLE%^</h1^>>> %tmp%\%OUTPUT%.header
echo.			^<h2^>%FOOTER_INFO%^</h2^>>> %tmp%\%OUTPUT%.header
echo.		^</div^>>> %tmp%\%OUTPUT%.header
echo.	^</div^>>> %tmp%\%OUTPUT%.header
echo.>> %tmp%\%OUTPUT%.header
echo.	^<div class="presentation"^>>> %tmp%\%OUTPUT%.header
echo.>> %tmp%\%OUTPUT%.header
echo..

REM slider
set /p=�������� slider . < nul
call %MARKDOWN_CALL% %MD_FILE% > %tmp%\%OUTPUT%.markdown.html
set /p=. < nul
REM div.slide>ul.incremental>li*4
echo.		^<div^>> %tmp%\%OUTPUT%.slide
for /f "tokens=*" %%i in (%tmp%\%OUTPUT%.markdown.html) do (
	echo "%%i" | find "h1" 2> nul > nul
	if not errorlevel 1 (
		echo.		^</div^>>> %tmp%\%OUTPUT%.slide
		echo.>> %tmp%\%OUTPUT%.slide
		echo.		^<div class="slide"^>>> %tmp%\%OUTPUT%.slide
	)
	echo.			%%i>> %tmp%\%OUTPUT%.slide
)
echo.		^</div^>>> %tmp%\%OUTPUT%.slide
echo..

REM footer
set /p=�������� footer . . < nul
echo.	^</div^>> %tmp%\%OUTPUT%.footer
echo.>> %tmp%\%OUTPUT%.footer
echo.^</body^>>> %tmp%\%OUTPUT%.footer
echo.^</html^>>> %tmp%\%OUTPUT%.footer
echo.>> %tmp%\%OUTPUT%.footer
echo..

type %tmp%\%OUTPUT%.header %tmp%\%OUTPUT%.slide %tmp%\%OUTPUT%.footer > "%OUT_FOLDER%\%OUTPUT%.html" 2> nul
if not defined IS_START_NEW (
	echo ���
) else (
	"%BROWSER_PATH%" "%OPEN_PATH%/%OUTPUT%.html"
)

goto :eof

:err
ping -n 3 127.0.0.1 2> nul > nul
exit /b 404

