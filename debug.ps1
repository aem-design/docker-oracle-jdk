Param(
  [string]$LOG_PATH = "${PWD}\logs",
  [string]$LOG_PEFIX = "docker",
  [string]$LOG_SUFFIX = ".log",
  [string]$TAG = "jdk21",
  [string]$FILE = "Dockerfile",
  [string]$JDK_LOCAL_PATH = "C:\\data\\apps\\#dev\\jdk\\jdk-21.0.7",
  [string]$JDK_PACKAGE_FILE = "jdk-21_linux-x64_bin.tar.gz",
  [string]$JDK_URL = "https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz",
  [string]$FUNCTIONS_URI = "https://github.com/aem-design/aemdesign-docker/releases/latest/download/functions.ps1",
  [string]$COMMAND = "docker build . -f .\${FILE} -t "
)

$IMAGENAME=Select-String -path $FILE '.*imagename="(.*)".*' -AllMatches | Foreach-Object {$_.Matches} | Foreach-Object {$_.Groups[1].Value}
$IMAGEVERSION=Select-String -path $FILE '.*version="(.*)".*' -AllMatches | Foreach-Object {$_.Matches} | Foreach-Object {$_.Groups[1].Value}

$COMMAND="$COMMAND${IMAGENAME}:${IMAGEVERSION}"

$SKIP_CONFIG = $true
$PARENT_PROJECT_PATH = "."

try {
  . ([Scriptblock]::Create((([System.Text.Encoding]::ASCII).getString((Invoke-WebRequest -Uri "${FUNCTIONS_URI}").Content))))
} catch {
  if (-not (Test-Path $LOG_PATH)) { New-Item -ItemType Directory -Path $LOG_PATH -Force | Out-Null }
  $LOG_FILE = Join-Path $LOG_PATH ("{0}-{1}{2}" -f $LOG_PEFIX, (Get-Date -Format "yyyyMMdd-HHmmss"), $LOG_SUFFIX)
  function printSectionBanner { param([string]$Text) Write-Host "==== $Text ====" }
  function printSectionLine { param([string]$Text, [string]$Level) Write-Host $Text }
}

if (-not (Test-Path ".\\packages\\$JDK_PACKAGE_FILE")) {
  New-Item -ItemType Directory -Path ".\\packages" -Force | Out-Null
  if (Test-Path $JDK_LOCAL_PATH) {
    Write-Host "Packaging local JDK from ${JDK_LOCAL_PATH}..."
    tar -czf ".\\packages\\$JDK_PACKAGE_FILE" -C (Split-Path $JDK_LOCAL_PATH -Parent) (Split-Path $JDK_LOCAL_PATH -Leaf)
  } else {
    Write-Host "Downloading JDK from ${JDK_URL}..."
    Invoke-WebRequest -Uri "${JDK_URL}" -OutFile ".\\packages\\$JDK_PACKAGE_FILE"
  }
}

printSectionBanner "Loading Debug Image"
printSectionLine "$COMMAND" "warn"

# Run $COMMAND and capture output to log file
Invoke-Expression -Command "$COMMAND" | Tee-Object -Append -FilePath "${LOG_FILE}"


docker run -it --rm -v ${PWD}:/build/source:rw ${IMAGENAME}:${IMAGEVERSION} bash --login
# docker run -it --rm -v ${PWD}:/build/source:rw aemdesign/${IMAGENAME}:${IMAGEVERSION} bash --login
