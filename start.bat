@echo off
setlocal
cd /d "%~dp0"

echo ============================================
echo   Go-Ai-Studio launcher
echo ============================================

where go >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Go not found. Please install Go and add it to PATH.
    pause
    exit /b 1
)

where node >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Node.js not found. Please install Node.js.
    pause
    exit /b 1
)

if not exist "frontend\node_modules" (
    echo [1/3] Installing frontend dependencies...
    pushd frontend
    call npm install
    if errorlevel 1 (
        echo [ERROR] npm install failed.
        pause
        exit /b 1
    )
    popd
) else (
    echo [1/3] Frontend dependencies already installed, skip.
)

echo [2/3] Building frontend...
pushd frontend
call npm run build
if errorlevel 1 (
    echo [ERROR] Frontend build failed.
    pause
    exit /b 1
)
popd

echo [3/3] Starting Go-Ai-Studio server...
echo The browser will open automatically (default port 8389).
echo Press Ctrl+C to stop the server.
echo ============================================
go run .
if errorlevel 1 (
    echo [ERROR] Server failed to start.
    pause
    exit /b 1
)

endlocal