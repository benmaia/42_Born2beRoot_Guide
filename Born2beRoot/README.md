<h1>Born2beRoot</h1>

<h2> Index </h2>
<p><a href="#VM Assemble">
  00 - VM Assemble
</a></p>
<p><a href="#Installation">
  01 - Installation
</a></p>
<p><a href="#Set the basic up">
  02 - Set the basic up
</a></p>
<p><a href="#Assemble remote SSH">
  03 - Assemble remote SSH
</a></p>
<p><a href="#Password Policy">
  03 - Password Policy
</a></p>
<p><a href="#Sudo Policy">
  04 - Sudo Policy
</a></p>
<p><a href="#Script">
  05 - Script
</a></p>

<h2 id="Set the basic up">Set the basic up</h2>
<p> Login as root: <code>su</code></p>
<p> Update & Upgrade: <code> apt update</code> and <code> apt upgrade</code></p>
<p> Install sudo: <code> apt install sudo</code></p>
<p> Add user to sudo group: <code>sudo usermod -aG sudo bmiguel-</code></p>
<p> <code>-a</code> is a shortcut for --append: It means append the group to the list of groups the user belongs to!</p>
<p> <code>-G</code> is a shortcut for --groups: It tells usermod that the next argument is a group. Note that you need to use a capital -G here because we don’t want to modify the user’s primary group but the list of supplemental groups the user belongs to.</p>
<p> To check if your user is in the sudo group <code>getent group sudo</code></p>
<p> Leave root to your user now <code>su - bmiguel-</code></p>
<p> <a href="https://www.howtogeek.com/124950/htg-explains-why-you-shouldnt-log-into-your-linux-system-as-root/" target="_blank">Why You Shouldn’t Log Into Your Linux System As Root</a></p>
<p> Add group user42: <code> sudo groupadd user42</code></p>
<p> Add our user to that group: <code> sudo usermod -aG user42 bmiguel-</code>
<p> Install VIM: <code>sudo apt install vim</code></p>

<h2 id="Assemble remote SSH">Assemble remote SSH</h2>
<p> Install OpenSSH: <code>sudo apt install openssh-server</code></p>
<p> Verify ssh service: <code>sudo systemctl status ssh</code></p>
<p> Get your ip: <code>ip a</code></p>
<p> Add port 4242: go to <code>/etc/ssh</code>, run <code>sudo vim sshd_config</code> and edit the <code>#Port22</code> to <code>Port 4242</code></p>
<p> Install UFW Firewall: <code> sudo apt install ufw</code></p>
<p> Activate UFW: <code>sudo ufw enable</code></p>
<p> To check if its enable <code>sudo ufw status</code></p>
<p> Go to VirutalBox -> Choose the VM -> Select "Settings" -> Choose "Network" -> "Adapter 1" -> "Advance" -> "Port Forwarding"</p>
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072654394892328/9.png" width="500px" height="400px">
<p> Insert <code>4242</code> in Host Port and Guest Port</p>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072654780788838/10.png" width="900px" height="350px">
</div>
<p> Reboot the machine: <code> sudo reboot</code></p>
<p> Allow the port 4242 on the Firewall: <code>sudo ufw allow 4242/tcp</code></p>
<p> To get remote access trough ssh port 4242, run this in your VM: <code>sudo ssh -p 4242 username@10.0.2.15</code> in my case <code>sudo ssh -p 4242 bmiguel-@10.0.2.15</code></p>
<p> Now outside your VM, in your pc (42 iMac, in your own terminal) run: <code>sudo ssh -p 4242 username@127.0.0.1</code> in my case <code>sudo ssh -p 4242 bmiguel-@127.0.0.1</code></p>

<a href="http://www.openssh.com/" target="_blank">Open SSH</a> 
<br>
<a href="https://www.linux.com/training-tutorials/introduction-uncomplicated-firewall-ufw/" target="_blank">An Introduction to Uncomplicated Firewall (UFW)</a> 
<br>

<h2 id="Password Policy">Password Policy</h2>
<p> To enforce password complexity I will use pwquality.conf <code>sudo apt install libpam-pwquality</code></p>
<p> Go to <code>/etc</code> and run <code> sudo vim login.defs</code></p>
<p> Search for:</p>
<p> <code>PASS_MAX_DAYS  9999</code></p>
<p> <code>PASS_MIN_DAYS   0</code></p>
<p> <code>PASS_WARN_AGE   7</code></p>
<p> and change to</p>
<p> <code>PASS_MAX_DAYS  30</code></p>
<p> <code>PASS_MIN_DAYS   2</code></p>
<p> <code>PASS_WARN_AGE   7</code></p>
<p> Go to <code>/etc/pam.d</code>, run <code>sudo vim common-password</code> and find <code>password        requisite                       pam_pwquality.so retry=3</code></p>
<p> To set at least one upper-case letter in the pw add <code> ucredit=-1</code> </p>
<p> To set at least one lower-case letter in the pw add <code> lcredit=-1</code></p>
<p> To set at least one digit in the pw add <code> dcredit=-1</code></p>
<p> To set the minimum length in the pw add <code> minlen=10</code></p>
<p> To set at max consecutive identical chars in the pw add <code> maxrepeat=3</code></p>
<p> To check if the password contains the username in some form add <code> usercheck=0</code></p>
<p> To set a minimum number of chars that must be different from the old pw add <code> difok=7</code></p>
<p> To the root pw comply to this policy add <code> enforce_for_root</code></p></p>
<p> Reboot your VM <code> sudo reboot</code></p>
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920102151538217010/39.png">

<a href="https://linux.die.net/man/8/pam_pwquality" target="_blank">Pam_pwquality</a> 
<br>

<h2 id="Sudo Policy">Sudo Policy</h2>
<p> Go to <code>/etc/sudoers.d</code>  and run <code>sudo visudo</code></p>
<p> NEVER EDIT THE SUDOERS FILE WITH A NORMAL TEXT EDITOR, ALWAYS USE <code>sudo visudo</code></p>
<p> Find the <code>Defaults</code> section and add:</p>
<p> To enable TTY <code> Defaults        requiretty</code></p>
<p> To select the right folder for your log files <code> Defaults        logfile="/var/log/sudo/sudo.log"</code></p>
<p> To archive your log inputs and outputs <code> Defaults        log_input, log_output</code></p>
<p> To set your password retries (It usually comes 3 times as default, but still...) <code> Defaults        passwdtries=3</code></p>
<p> To enable TTY <code> Defaults        badpass_message="Your message"</code></p>
<p> The security pass probably is already there, but in case it isn't <code>Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"</code></p>
<img src="https://cdn.discordapp.com/attachments/920049215504269342/920102151815049247/40.png">


<a href="https://www.linux.com/training-tutorials/linux-101-introduction-sudo/" target="_blank">Linux 101: Introduction to sudo</a> 
<br>

<h2 id="Script">Script</h2>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>

<a href="https://www.debian.org/download" target="_blank">here</a> 
<br>

<h2 id="VM Assemble">VM Assemble</h2>
<p> Get the Debian ISO from <a href="https://www.debian.org/download" target="_blank">here</a></p>
<p> ISO the netinst CD is a small CD image that contains just the core Debian installer code and a small core set of text-mode programs(known as "standart" in Debian).</p>
<br>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920074087555018762/1.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072652243214386/2.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072652503273482/3.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072652859797584/4.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072653086261339/5.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072653400842250/6.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072653707034634/7.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072654038397018/8.png">
</div>

<h2 id="Installation">Installation</h2>
<p> Get the Debian ISO from <a href="https://www.debian.org/download" target="_blank">here</a></p>
<p> ISO the netinst CD is a small CD image that contains just the core Debian installer code and a small core set of text-mode programs(known as "standart" in Debian).</p>
<br>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081681313067089/1.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081681644408842/2.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081682093178910/3.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081682340655154/4.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081682923675658/5.png">
</div>
<p> Set hostname as your login+42</p>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081683397640282/6.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081683804467231/7.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081683989033062/8.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081684223889478/9.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920081684504936448/10.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082461285838888/11.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082461508128819/12.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082461722026105/13.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082461927571478/14.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082462124695582/15.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082462326026270/16.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082462544121886/17.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082462804181012/18.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082463013888020/19.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082463248748594/20.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082875926319154/21.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082876136058910/22.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082876333195294/23.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082876580634664/24.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082876761006151/25.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082876958134312/26.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082877184606298/27.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082877402742864/28.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082877687939142/29.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920082877910241341/30.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920083302231187466/31.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920083302868733992/32.png">
</div>
