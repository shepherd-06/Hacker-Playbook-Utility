<h1> Hello World! </h1>

[![Snap Status](https://build.snapcraft.io/badge/ibtehaz-shawon/Hacker-Playbook-Utility.svg)](https://build.snapcraft.io/user/ibtehaz-shawon/Hacker-Playbook-Utility) [![Supported Python Versions](https://img.shields.io/badge/Python-3.4%2C%203.5%2C%203.6-brightgreen.svg)](https://img.shields.io/badge/Python-3.4%2C%203.5%2C%203.6-brightgreen.svg)

<!-- [![Build status](https://travis-ci.org/ibtehaz-shawon/Hacker-Playbook-Utility.svg?branch=master)](https://travis-ci.org/ibtehaz-shawon/Hacker-Playbook-Utility) -->



This is a Python powered bash script to help install different scripts of <a href= "www.thehackerplaybook.com/dashboard"> The Hacker Playbook </a> book.

-----------------------------------------------------------

<h3> What does this script do </h3>
<ol>
<li> Update & Upgrade System </li>
<li> Postgresql status </li>
<li> Metasploit framework </li>
<li> Discover Script </li>
<li> SMBExec </li>
<li> Veil 3.0 </li>
<li> Peeping Tom (<b>Not functional yet</b>) </li>
<li> Eye Witness </li>
<li> Powersploit </li>
<li> Responder </li>
<li> Social Engineering Toolkit </li>
<li> bypassUAC (<b>Not functional yet</b>) </li>
<li> beEF (for cross site scripting) </li>
<li> Fuzzing List </li>
<li> WCE (Windows Credential Editor)</li>
<li> Mimikatz</li>
<li> Skull Security custom password list </li>
<li> CreackStation Human Password list </li>
<li> & NMap script </li>
</ol>

You can choose to download all scripts at once or choose the scripts you need.
{PS: I will add the silent download option later}

-----------------------------------------------------------
<h3> <b> Requirement: </b> </h3>
<h6> Operating system </h6>
<p> This script currently work for <b>Debian systems</b> only.

Tested in the following OS: <u> Ubuntu 16.04 </u> <u> Kali Rolling 2.0 </u> & <u> Linux Mint </u>
</p>
<h6> Install python3, pip3 (for python3+)and curl </h6>
<p> Currently this script only support python3+
<pre>sudo apt-get install python3.6 python3-pip curl</pre>
</p>

-----------------------------------------------------------

<h3> <b> How to run: </b> </h3>
<h6> Step 1 </h6>
<p> Clone this repository
<pre>git clone https://github.com/ibtehaz-shawon/Hacker-Playbook-Utility </pre>
</p>
<h6> Step 2 </h6>
<p>
Install the requirements from the requirements file using the following command.
<pre>pip3 install -r requirements.txt </pre>
</p>
<h6> Step 3 </h6>
<p> Run the HP_Utility.py file in superuser mode
<pre> sudo python3 HP_Utility.py </pre>
The scripts need to install some file in administrative accessed area!
</p>

-----------------------------------------------------------
<b> Thats it! </b>
If there is any problem regarding this script, please create an issue here - https://github.com/ibtehaz-shawon/Hacker-Playbook-Utility/issues

Thank you! -- Ibtehaz :)
