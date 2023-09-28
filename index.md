**[ --- LinkedIn profile --- ](https://www.linkedin.com/in/brent-conner)**

![Photo of Me](https://brent-conner.github.io/Me.jpg)

[ --- Photo of my family --- ](https://brent-conner.github.io/Fam.jpg)



## Simple Powershell Script Examples

### Satellite forced check-in
```
$cmd = Get-ItemPropertyValue "HKLM:\SOFTWARE\WOW6432Node\Epic Systems Corporation\Satellite" -Name Path
$arg = "/F"
# Commands are run twice to account for Satellite updates
Start-Process -FilePath $cmd -ArgumentList $arg -Verb RunAs -Wait
Start-Process -FilePath $cmd -ArgumentList $arg -Verb RunAs -Wait
```

### Install and bind a cert
```
$servers = Get-Content D:\Scripts\_Servers\AzurePOC.txt 
foreach($server in $servers) {
Write-Host "***************** $server start ********************"
Invoke-Command -ComputerName $server { New-Item -Path C:\Certs\ -Type Directory -Force }
$s = New-PSSession $server
Copy-Item -Path "\\epicfileshare\Brent\Cert\star.pfx" -Destination C:\Certs\ -Force -recurse -ToSession $s
Invoke-Command -cn $server {
    Import-PfxCertificate -FilePath "C:\Certs\star.pfx" -Password (ConvertTo-SecureString -String "password" -AsPlainText -Force) -CertStoreLocation Cert:\LocalMachine\My -Exportable
    New-WebBinding -Name "Default Web Site" -Port 443 -Protocol https;
    $cert = Get-ChildItem -Path Cert:\LocalMachine\My | where-Object {$_.subject -like "*.domain.org*"};
    (Get-WebBinding -Port 443).AddSslCertificate($cert.Thumbprint,"My")
    }
Write-Host "***************** $server end ********************"
}
```

### Install Server pre-reqs requiring sxs files
```
$servers = Get-Content -path D:\scripts\servers.txt

foreach($server in $servers) {
$s = New-PSSession $server
Copy-Item -Path '\\epicfileshare\Brent\Server2019\sources\sxs\' -Destination 'D:\sources\sxs' -Force -recurse -ToSession $s
Copy-Item -Path '\\epicfileshare\Brent\Server2019\sources\PreReq.xml' -Destination 'D:\sources\' -Force -recurse -ToSession $s
Invoke-Command -ComputerName $server {
Set-ExecutionPolicy RemoteSigned -Force
	Add-LocalGroupMember -Group "Administrators" -Member "domain\user"
	Enable-NetFirewallRule -DisplayName "Remote Scheduled Tasks Management (RPC)"
	Enable-NetFirewallRule -DisplayName "Windows Management Instrumentation (DCOM-In)"
	Enable-NetFirewallRule -DisplayName "Windows Management Instrumentation (WMI-In)"
	Set-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)" -Profile Domain, Private
	powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
	Install-WindowsFeature -ConfigurationFilePath "D:\sources\PreReq.xml" -source "D:\sources\sxs\" }
}
```

### Create task on remote server to purge IIS logs
```
$servers = Get-Content D:\scripts\_Servers\HSW.txt
foreach($server in $servers) {
Invoke-Command -ComputerName $server { New-Item -Path D:\Scripts\ -Type Directory -Force }
$s = New-PSSession $server
Copy-Item -Path "\\epicfileshare\Brent\IIS\PurgeIIS.ps1" -Destination D:\Scripts\ -Force -recurse -ToSession $s
Copy-Item -Path "\\epicfileshare\Brent\IIS\DPurgeIIS.xml" -Destination D:\Scripts\ -Force -recurse -ToSession $s
Invoke-Command -cn $server { Register-ScheduledTask -TaskName "Purge IIS" -Xml (Get-Content "D:\Scripts\DPurgeIIS.xml" | out-string) -User domain\user -Password UTMB –Force }
}
```

### Open PS ISE as another user
```
$a = "bconner"
$c = Get-Credential $a
Start-Process $PsHome\powershell.exe -Credential $c -ArgumentList “-Command Start-Process $PSHOME\powershell_ise.exe -Verb Runas” -Wait
```

