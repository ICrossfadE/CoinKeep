@echo off
:: Check if JAVA_HOME is set and use it
if defined JAVA_HOME (
  set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
  if not exist "%JAVA_EXE%" (
    echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
    exit /b 1
  )
) else (
  set "JAVA_EXE=java"
  for /F %%i in ('where java') do set "JAVA_EXE=%%i"
  if not exist "%JAVA_EXE%" (
    echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
    exit /b 1
  )
)

:: Find the absolute path of the script directory
setlocal
set "DIR=%~dp0"
cd /d "%DIR%" >nul 2>nul
set "DIR=%CD%"
endlocal & set "DIR=%DIR%"

set "APP_HOME=%DIR%"
set "GRADLE_HOME=%APP_HOME%"

set CLASSPATH=%GRADLE_HOME%\gradle-wrapper.jar
"%JAVA_EXE%" -Dorg.gradle.appname=gradlew -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*
