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

{% highlight Powershell %}
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

Menu

{% endhighlight %}

</details>


