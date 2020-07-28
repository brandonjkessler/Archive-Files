Param(
    [string][parameter(mandatory=$true)]$Path
)


Get-ChildItem -Path $Path | ForEach-Object{
    if(!($_.FullName -like "*.7z")){
        Write-Output "Archiving $($_.Fullname)"
        cmd /c "`"$PSScriptRoot\7za.exe`" a -slp -t7z $($_.FullName).7z $($_.FullName)\ -mx=9"
        Remove-Item -Path $_.FullName -Recurse -Force -Verbose
    }
    
}

