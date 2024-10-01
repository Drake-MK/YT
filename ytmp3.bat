@echo off
:: Batch script to download MP3 audio from YouTube video using yt-dlp and clipboard link

:: Check if yt-dlp is installed
where yt-dlp >nul 2>nul
if %errorlevel% neq 0 (
    echo yt-dlp is not installed. Downloading yt-dlp...

    :: Download yt-dlp.exe
    powershell -command "Invoke-WebRequest -Uri 'https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe' -OutFile 'yt-dlp.exe'"

    :: Check if download was successful
    if exist yt-dlp.exe (
        echo yt-dlp downloaded successfully.
    ) else (
        echo Failed to download yt-dlp. Please download it manually from https://github.com/yt-dlp/yt-dlp
        pause
        exit /b
    )
)

:: Get the link from clipboard
for /f "tokens=* delims=" %%a in ('powershell -command "Get-Clipboard"') do set "videoURL=%%a"

:: Check if the clipboard is empty
if "%videoURL%"=="" (
    echo Clipboard is empty. Please copy a YouTube video link to the clipboard.
    pause
    exit /b
)

:: Download the MP3 audio
yt-dlp.exe -x --audio-format mp3 %videoURL%

:: Notify the user that the download is complete
echo Download complete!
pause
