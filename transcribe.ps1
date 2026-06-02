$WHISPER    = "$HOME\Desktop\whisper.cpp\build\bin\whisper-cli.exe"
$MODEL      = "$HOME\Desktop\whisper.cpp\models\ggml-base.en.bin"

$SOURCE     = "$HOME\Videos\Windows Privilege Escalation\Not Done"
$TRANSCRIPT = "$HOME\Videos\Windows Privilege Escalation\Transcripts"
$COMPLETED  = "$HOME\Videos\Windows Privilege Escalation\Completed"

# Create folders if they don't exist
New-Item -ItemType Directory -Force -Path $TRANSCRIPT | Out-Null
New-Item -ItemType Directory -Force -Path $COMPLETED  | Out-Null

Get-ChildItem "$SOURCE\*.mp4" | ForEach-Object {

    $mp4       = $_.FullName
    $baseName  = $_.BaseName

    $wav       = Join-Path $SOURCE "$baseName.wav"
    $txtOutput = Join-Path $TRANSCRIPT $baseName

    Write-Host "`n>>> Converting: $($_.Name)"

    ffmpeg -y -i $mp4 -ar 16000 -ac 1 -c:a pcm_s16le $wav

    Write-Host ">>> Transcribing: $baseName.wav"

    & $WHISPER `
        -m $MODEL `
        -f $wav `
        -otxt `
        -of $txtOutput `
        -t 8 `
        -p 1 `
        -fa `
        -bs 5

    # Remove temporary WAV
    Remove-Item $wav -Force

    # Move completed video
    Move-Item $mp4 -Destination (Join-Path $COMPLETED $_.Name)

    Write-Host ">>> Done: $baseName.txt"
    Write-Host ">>> Video moved to Completed"
}

Write-Host "`nAll done."