# Define source and destination directories
$sourceDirectory = "C:\SampleProject"
$destinationDirectories = @("C:\MainApp\Project1", "C:\MainApp\Project2")

# Function to compare and copy files
function CompareAndCopyFiles($source, $destination) {
    # Get the list of files in the source directory
    $sourceFiles = Get-ChildItem -Path $source -File

    # Get the list of files in the destination directory
    $destinationFiles = Get-ChildItem -Path $destination -File

    # Compare files and copy only the different ones
    foreach ($sourceFile in $sourceFiles) {
        $destinationFile = $destinationFiles | Where-Object { $_.Name -eq $sourceFile.Name }

        if ($destinationFile -eq $null -or $sourceFile.LastWriteTime -gt $destinationFile.LastWriteTime) {
            # File is different or doesn't exist in the destination, copy it
            Copy-Item $sourceFile.FullName -Destination $destination -Force
            Write-Output "Copied $($sourceFile.FullName) to $($destination)"
        }
    }
}

# Loop through each destination directory and compare/copy files
foreach ($destinationDirectory in $destinationDirectories) {
    CompareAndCopyFiles $sourceDirectory $destinationDirectory
}
