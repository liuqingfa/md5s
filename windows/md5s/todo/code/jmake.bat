@echo off
REM ��Ա�����߲��������κ����Σ���֪��ϸ��鿴 GPL.txt
REM ����һ�����ɵĳ��򣬻�ӭ�����ض��������ٴη���������
REM
REM �ٴθ�л��ʹ�ñ��ű�
REM �߲�����
REM

if exist %tmp%\j.list del /f /q %tmp%\j.list 2> nul
setlocal enabledelayedexpansion
for /f "tokens=*" %%i in ('dir /s /b *.java 2^> nul') do (
	set javafile=%%i
	set javafile=!javafile:\=\\!
	echo "!javafile!">> %tmp%\j.list
)
endlocal

if not exist %tmp%\j.list (
	echo no java file found!
)

if exist ..\bin\nul (
	rd /s /q ..\bin 2> nul
)

md ..\bin
set /p=Compiling . < nul
javac -encoding gb2312 -cp . -d ..\bin @%tmp%\j.list
if %errorlevel% EQU 0 (
	echo . .
	java -cp ..\bin %*
)

del /f /q %tmp%\j.list
