**[Click for LinkedIn profile](https://www.linkedin.com/in/brent-conner)**

![Photo of Me](https://brent-conner.github.io/Me.jpg)

[Click for photo of my family](https://brent-conner.github.io/Fam.jpg)



## Powershell Script Examples

<details><summary>Install Pre-reqs requiring sxs</summary>
{% raw %}
```
$servers = Get-Content -path D:\Scripts\servers.txt

#Copy sxs folder to server and install Pre-reqs
foreach($server in $servers) {
$s = New-PSSession $server
Copy-Item -Path 'D:\Server2019\sources\sxs\' -Destination 'D:\sources\sxs' -Force -recurse -ToSession $s
Copy-Item -Path 'D:\Server2019\sources\PreReq.xml' -Destination 'D:\sources\' -Force -recurse -ToSession $s
Invoke-Command -ComputerName $server { Install-WindowsFeature -ConfigurationFilePath "D:\sources\PreReq.xml" -source "D:\sources\sxs\" }
}
```
{% endraw %}
</details>

<details><summary>Open ISE as user</summary>
{% raw %}
{% highlight %}
$a = "bconner"
$c = Get-Credential $a
Start-Process $PsHome\powershell.exe -Credential $c -ArgumentList “-Command Start-Process $PSHOME\powershell_ise.exe -Verb Runas” -Wait
{% endhighlight %}
{% endraw %}
</details>