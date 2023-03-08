**[Click for LinkedIn profile](https://www.linkedin.com/in/brent-conner)**

![Photo of Me](https://brent-conner.github.io/Me.jpg)

[Click for photo of my family](https://brent-conner.github.io/Fam.jpg)



## Powershell Script Examples

<details>
<summary>Preview</summary>

{% highlight %}
puts 'Expanded message'
{% endhighlight %}

</details>


<details><summary>Interconnect HA Group Enable/Disable</summary>

{% highlight %}
# Global Variables

##################

$ScriptLoc = "\\bhcs.pvt\dfsdept\EpicTech\Scripts\Interconnect\"

Function Brakes { foreach($var in $args) { If(!$var) { Write-Host -foreground red "A variable was NULL, returning to menu."; Pause; Menu } } }

Function GroupSelect {

$slist = Get-ChildItem -path $ScriptLoc"_Servers" -Recurse
$Num = 1
Write-Host -foreground Yellow "***********************"
Write-Host -foreground Yellow ">>>>Server List<<<<"
foreach($list in $slist) { Write-Host $Num - $list; $Num++ }
Write-Host -foreground Yellow "***********************"
$Choice = Read-Host "Choose server list"
Brakes $choice
$list = $slist[$Choice-1]
$Servers = Get-Content -path $ScriptLoc"_Servers\"$list
Return $Servers
}

Function StatusIC {

$ICservers = GroupSelect
foreach($server in $ICservers) {
    Write-Host -foreground Cyan ">>>>$server<<<<"
    Write-Host -foreground Cyan "***********************"
        $statuses = Get-Service -ComputerName $server -ErrorAction SilentlyContinue -Name *Interconnect*
        foreach($status in $statuses) { 
        Write-Host $status.status $status.name
        if($status.status -ne "Running") { Write-Host -foreground Red "???????????????????????" }
            else { Write-Host -foreground Green "-------------------------------" } }
    }
}

function DisableIC {

$ICservers = GroupSelect
foreach($server in $ICservers) {
    Write-Host -foreground Green "***********************"
    Write-Host -foreground Cyan "Stopping IC services on $server"
    Get-Service -ComputerName $server -Name *Interconnect* | Stop-Service -Force
    Write-Host -foreground Cyan "Setting to disabled on $server"
    Get-Service -ComputerName $server -Name *Interconnect* | Set-Service -StartupType Disabled
    }
}

function EnableIC {

$ICservers = GroupSelect
foreach($server in $ICservers) {
    Write-Host -foreground Green "***********************"
    Write-Host -foreground Cyan "Setting to automatic on $server"
    Get-Service -ComputerName $server -Name *Interconnect* | Set-Service -StartupType Automatic
    Write-Host -foreground Cyan "Starting IC services on $server"
    Get-Service -ComputerName $server -Name *Interconnect* | Start-Service
    }
}

function DisableChoice {
$name = Read-Host "Enter instance name identifier"
$ICservers = GroupSelect
foreach($server in $ICservers) {
    Write-Host -foreground Green "***********************"
    Write-Host -foreground Cyan "Stopping IC services on $server"
    Get-Service -ComputerName $server -Name *$name* | Stop-Service -Force
    Write-Host -foreground Cyan "Setting to disabled on $server"
    Get-Service -ComputerName $server -Name *$name* | Set-Service -StartupType Disabled
    }
}

function EnableChoice {
$name = Read-Host "Enter instance name identifier"
$ICservers = GroupSelect
foreach($server in $ICservers) {
    Write-Host -foreground Green "***********************"
    Write-Host -foreground Cyan "Setting to automatic on $server"
    Get-Service -ComputerName $server -Name *$name* | Set-Service -StartupType Automatic
    Write-Host -foreground Cyan "Starting IC services on $server"
    Get-Service -ComputerName $server -Name *$name* | Start-Service
    }
}

Function Menu {

while(1) {
    Write-host -foreground Yellow "<><><><><><><><><><><><><><>"
    Write-Host -foreground Cyan "Epic Interconnect Functions"
    Write-host -foreground Yellow "<><><><><><><><><><><><><><>"
    Write-host "1.  IC Status"
	Write-host "2.  IC Enable"
	Write-host "3.  IC Disable"
    Write-Host "4.  Wildcard Enable"
    Write-host -foreground Red "---------------------------------------------------"
    Write-host "5.  Wildcard Disable"
    Write-host "6.  "
    Write-host "7.  "
    Write-host "8.  Exit Menu"
    Write-host -foreground Yellow "<><><><><><><><><><><><><><>"
    Write-host -foreground Yellow "<><><><><><><><><><><><><><>"
	$MenuOption = Read-host "Selection"
	
	Switch($MenuOption) {
        "1"  {StatusIC}
		"2"  {EnableIC}
        "3"  {DisableIC}
		"4"  {EnableChoice}
        "5"  {DisableChoice}
        "6"  {}
        "7"  {}
        "8"  {Exit}
        default {Continue}
        }
    }
}
Menu
{% endhighlight %}
</details>


