@echo off
REM 针对本程序斑驳不担保任何责任，欲知详细请查看 GPL.txt
REM 这是一个自由的程序，欢迎您在特定条件下再次发布本程序。
REM
REM 再次感谢您使用本脚本
REM 斑驳敬上
REM

set /p HTML_TITLE=请输入 HTML 标题，默认 [设计模式]: 
if not defined HTML_TITLE set HTML_TITLE=设计模式
set /p FOOTER_TITLE=请输入 footer 标题，默认 [设计模式]: 
if not defined FOOTER_TITLE set FOOTER_TITLE=设计模式
set FOOTER_INFO=%date:~0,-4% @ %username%
set /p OUTPUT=请输入生成文件名称，默认 [out]: 
if not defined OUTPUT set OUTPUT=out
set /p IS_RELEASE=是否要发布，默认 [No]: 
if not defined IS_RELEASE set S5_PATH=md5s/dist/default/
echo Release.%IS_RELEASE% | find /i "Y" 2> nul > nul
if not errorlevel 1 (
	set S5_PATH=http://222.134.70.138:30086/neo/utils/s5/
) else (
	set S5_PATH=md5s/dist/default/
)

set MD_FILE=todo\todo.markdown
set MARKDOWN_CALL=dist\md5s.me\md5s.me.exe

if not exist %MD_FILE% (
	echo MD_FILE ^(%MD_FILE%^) 文件不存在
	goto err
)

if not exist %MARKDOWN_CALL% (
	echo MARKDOWN_CALL ^(%MARKDOWN_CALL%^) 文件不存在
	goto err
)

set DUMMY_PATH=%S5_PATH:md5s/=%
if not exist %DUMMY_PATH:/=\%nul (
	if not %S5_PATH%==http://222.134.70.138:30086/neo/utils/s5/ (
		echo S5_PATH ^(%DUMMY_PATH%^) 目录不存在
		goto err
	)
)

REM header
set /p=正在生成 header . . < nul
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
set /p=正在生成 slider . < nul
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
set /p=正在生成 footer . . < nul
echo.	^</div^>> %tmp%\%OUTPUT%.footer
echo.>> %tmp%\%OUTPUT%.footer
echo.^</body^>>> %tmp%\%OUTPUT%.footer
echo.^</html^>>> %tmp%\%OUTPUT%.footer
echo.>> %tmp%\%OUTPUT%.footer
echo..

type %tmp%\%OUTPUT%.header %tmp%\%OUTPUT%.slide %tmp%\%OUTPUT%.footer > ..\%OUTPUT%.html 2> nul
echo 完成
ping -n 3 127.0.0.1 2> nul > nul
goto :eof

:err
ping -n 3 127.0.0.1 2> nul > nul
exit /b 404

