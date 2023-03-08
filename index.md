**[Click for LinkedIn profile](https://www.linkedin.com/in/brent-conner)**

![Photo of Me](https://brent-conner.github.io/Me.jpg)

[Click for photo of my family](https://brent-conner.github.io/Fam.jpg)



## Powershell Script Examples

<details>
<summary>PS_ISE</summary>

{% highlight %}
$a = "bconner"
$c = Get-Credential $a
Start-Process $PsHome\powershell.exe -Credential $c -ArgumentList “-Command Start-Process $PSHOME\powershell_ise.exe -Verb Runas” -Wait
{% endhighlight %}

</details>
