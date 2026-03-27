$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

# Prefer a modern installed JDK and bypass legacy Oracle javapath shims.
$preferredJdks = @(
    "C:\Program Files\Java\jdk-25.0.2",
    "C:\Program Files\Java\jdk-21",
    "C:\Program Files\OpenLogic\jdk-21",
    "C:\Program Files\OpenLogic\jdk-17"
)

$resolvedJdk = $preferredJdks | Where-Object { Test-Path (Join-Path $_ "bin\javac.exe") } | Select-Object -First 1

if (-not $resolvedJdk) {
    Write-Error "No supported JDK found. Install JDK 17+ and re-run."
}

$env:JAVA_HOME = $resolvedJdk
$pathParts = $env:Path -split ';' | Where-Object {
    $_ -and ($_ -notmatch 'Oracle\\Java\\javapath')
}
$env:Path = "$env:JAVA_HOME\bin;" + ($pathParts -join ';')

Write-Host "Using JAVA_HOME=$env:JAVA_HOME"
java -version
javac -version

if (-not $env:JWT_SECRET) {
    $env:JWT_SECRET = "change-me-to-a-long-random-secret"
}

if ($env:DB_URL) {
    Write-Host "DB_URL=$env:DB_URL"
} else {
    Write-Host "DB_URL not set; using application fallback (H2 in-memory)."
}
Write-Host "Starting Spring Boot..."

.\mvnw.cmd spring-boot:run
