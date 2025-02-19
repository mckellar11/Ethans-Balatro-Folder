# Get the current user's profile directory
$userProfile = $env:USERPROFILE

# Define the base path to Balatro using the user's profile directory
$basePath = Join-Path $userProfile "AppData\Roaming\Balatro"

# List of directories to create
$directoriesToCreate = @(
    "nativefs",
    "SMODS"
)

# Create directories if they don't exist
foreach ($dir in $directoriesToCreate) {
    $dirPath = Join-Path $basePath $dir
    if (-not (Test-Path -Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath
        Write-Host "Created directory: $dirPath"
    } else {
        Write-Host "Directory already exists: $dirPath"
    }
}

Write-Host "All directories have been checked/created."
