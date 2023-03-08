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


<details><summary>Start PS_ISE as user</summary>

{% highlight powershell %}
$a = "bconner"
$c = Get-Credential $a
Start-Process $PsHome\powershell.exe -Credential $c -ArgumentList “-Command Start-Process $PSHOME\powershell_ise.exe -Verb Runas” -Wait
{% endhighlight %}

</details>


