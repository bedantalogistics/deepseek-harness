@echo off
setlocal

rem One-click launcher for DeepSeek Harness Web UI (Windows)
set "ROOT=%~dp0.."
cd /d "%ROOT%"

title DeepSeek Harness

where pnpm >nul 2>&1
if errorlevel 1 (
  echo pnpm was not found. Install Node.js and run: npm install -g pnpm
  goto :fail
)

if not exist "apps\cli\lib\bin.js" (
  echo First run: building project. This may take several minutes...
  call pnpm run build
  if errorlevel 1 goto :fail
)

echo Starting DeepSeek Harness Web UI...
echo Close this window or press Ctrl+C to stop the server.
echo.

call pnpm dsh web
if errorlevel 1 goto :fail
exit /b 0

:fail
echo.
echo DeepSeek Harness did not start successfully.
pause
exit /b 1
