Param(
    [string][parameter(mandatory=$true)]$Path
)

Get-ChildItem -Recurse -depth 1 -Path $Path | ForEach-Object{
    #Check to see if the Files in a Path are a Directory
    $target = $_.FullName
    if(!(Test-Path -Path $target -PathType Leaf)){
        Write-Output "$_ is a directory. Ignoring."
    } else {
        #Verify that the file type is .extractable
        if(($_ -like "*.zip") -or ($_ -like "*.rar") -or ($_ -like "*.7z") -or ($_ -like "*.gz")){

            switch -Wildcard ($_){
                "*.zip"{cmd /c "`"$PSScriptRoot\7za.exe`" x `"$($target)`" -aoa -o`"$(($target).Substring(0,(($target).length - 4)))`""}
                "*.rar"{cmd /c "`"$PSScriptRoot\7za.exe`" x `"$($target)`" -aoa -o`"$(($target).Substring(0,(($target).length - 4)))`""}
                "*.7z"{cmd /c "`"$PSScriptRoot\7za.exe`" x `"$($target)`" -aoa -o`"$(($target).Substring(0,(($target).length - 3)))`""}
                "*.gz"{cmd /c "`"$PSScriptRoot\7za.exe`" x `"$($target)`" -aoa -o`"$(($target).Substring(0,(($target).length - 3)))`""}
    
            }
            #Remove the File after extracting
            Remove-Item -Path $target -Force -Verbose
        }
    }
}