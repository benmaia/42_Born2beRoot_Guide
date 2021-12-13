<h1>Born2beRoot</h1>

<h2> Index </h2>
<p><a href="#Set the basic up">
  Set the basic up
</a></p>
<p><a href="#Assemble remote SSH">
  Assemble remote SSH
</a></p>
<p><a href="#Password Policy">
  Password Policy
</a></p>
<p><a href="#Sudo Policy">
  Sudo Policy
</a></p>
<p><a href="#Script">
  Script
</a></p>
<p><a href="#VM Assemble">
  VM Assemble
</a></p>
<p><a href="#Installation">
  Installation
</a></p>

<h2 id="Set the basic up">Set the basic up</h2>
<p> Login as root: <code>su</code></p>
<p> Update & Upgrade: <code> apt update</code> and <code> apt upgrade</code></p>
<p> Install sudo: <code> apt install sudo</code></p>
<p> Add user to sudo group: <code>sudo usermode -aG sudo bmiguel-</code></p>
<p> <code>-a</code> is a shortcut for --append: It means append the group to the list of groups the user belongs to!</p>
<p> <code>-G</code> is a shortcut for --groups: It tells usermod that the next argument is a group. Note that you need to use a capital -G here because we don’t want to modify the user’s primary group but the list of supplemental groups the user belongs to.</p>
<p> To check if your user is in the sudo group <code>getent group sudo</code></p>
<p> Leave root to your user now <code>su - bmiguel-</code></p>
<p> <a href="https://www.howtogeek.com/124950/htg-explains-why-you-shouldnt-log-into-your-linux-system-as-root/" target="_blank">Why You Shouldn’t Log Into Your Linux System As Root</a></p>
<p> Install VIM: <code>sudo apt install vim</code></p>

<h2 id="Assemble remote SSH">Assemble remote SSH</h2>
<p> Install OpenSSH: <code>sudo apt install openssh-server</code></p>
<p> Verify ssh service: <code>sudo systemctl status ssh</code></p>
<p> Get your ip: <code>ip a</code></p>
<p> Add port 4242: go to <code>/etc/ssh</code>, run <code>sudo vim sshd_config</code> and edit the <code>#Port22</code> to <code>Port 4242</code></p>
<p> Install UFW Firewall: <code> sudo apt install ufw</code></p>
<p> Activate UFW: <code>sudo ufw enable</code></p>
<p> To check if its enable <code>sudo ufw status</code></p>
<p> Reboot the machine: <code> sudo reboot</code></p>
<p> Allow the port 4242 on the Firewall: <code>sudo ufw allow 4242/tcp</code></p>
<p> To get remote access trough ssh port 4242, run this in your VM: <code>sudo ssh -p 4242 username@ip.adress</code> in my case <code> bmiguel-@10.0.2.15</code></p>
<p> Now outside your VM, in your pc (42 iMac, in your own terminal) run: <code>sudo ssh -p 4242 username@ip.adress</code> in my case <code>sudo ssh -p 4242 bmiguel-@127.0.0.1</code></p>


<a href="https://www.investopedia.com/terms/p/proof-work.asp" target="_blank">Understanding Proof of Work - Investopedia</a> 
<br>

<h2 id="Password Policy">Password Policy</h2>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>


<a href="https://www.investopedia.com/terms/p/proof-work.asp" target="_blank">Understanding Proof of Work - Investopedia</a> 
<br>

<h2 id="Sudo Policy">Sudo Policy</h2>
<p> Proof of work (PoW) describes a system that requires a not-insignificant but feasible amount of effort in order to deter frivolous or malicious uses of computing power, such as sending spam emails or launching denial of service attacks.
 The concept was subsequently adapted to securing digital money by Hal Finney in 2004 through the idea of "reusable proof of work" using the SHA-256 hashing algorithm.</p>

<a href="https://www.investopedia.com/terms/p/proof-work.asp" target="_blank">Understanding Proof of Work - Investopedia</a> 
<br>

<h2 id="Script">Script</h2>
<p> Proof of work (PoW) describes a system that requires a not-insignificant but feasible amount of effort in order to deter frivolous or malicious uses of computing power, such as sending spam emails or launching denial of service attacks.
 The concept was subsequently adapted to securing digital money by Hal Finney in 2004 through the idea of "reusable proof of work" using the SHA-256 hashing algorithm.</p>

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
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072654394892328/9.png">
</div>
<div align="center">
 <img src="https://cdn.discordapp.com/attachments/920049215504269342/920072654780788838/10.png">
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
