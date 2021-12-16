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
 <img src="https://media.discordapp.net/attachments/920049215504269342/920886949655486514/1.png" >

<a href="https://linux.die.net/man/8/pam_pwquality" target="_blank">Pam_pwquality</a> 
<br>

<h2 id="Sudo Policy">Sudo Policy</h2>
<p> Go to <code>/etc/sudoers.d</code>  and run <code>sudo visudo</code></p>
<p> NEVER EDIT THE SUDOERS FILE WITH A NORMAL TEXT EDITOR, ALWAYS USE <code>sudo visudo</code></p>
<p> Find the <code>Defaults</code> section and add:</p>
<p> To enable TTY <code> Defaults        requiretty</code></p>
<p> To select the right folder for your log files <code> Defaults        logfile="/var/log/sudo/sudo.log"</code></p>
<p> To archive your log inputs and outputs <code> Defaults        log_input, log_output</code></p>
<p> To set your password retries (It usually comes 3 times as default, but still...) <code> Defaults        passwd_tries=3</code></p>
<p> To enable TTY <code> Defaults        badpass_message="Your message"</code></p>
<p> The security pass probably is already there, but in case it isn't <code>Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"</code></p>
<img src="https://media.discordapp.net/attachments/920049215504269342/920886949265420298/2.png" >


<a href="https://www.linux.com/training-tutorials/linux-101-introduction-sudo/" target="_blank">Linux 101: Introduction to sudo</a> 
<br>

<h2 id="Script">Script</h2>
<p> Run: <code>sudo vim /usr/local/bin/monitoring.sh</code></p>
<p> Every bash script start with <code>#!/bin/bash</code></p>
<p> <code>wall</code> is a command-line utility that displays a message on the terminals of all logged-in users. The messages can be either typed on the terminal or the contents of a file.</p>
<h3>Architecture</h3>
<p> The command <code>uname -a</code> is use to get the architecture, <code>uname</code> is used to to print certain system information including kernel name, and the <code>-a</code> or <code>all</code> print all information </p>
<p> To list the number of physical CPU's you can use <code>/proc/cpuinfo | grep "physical id" | sort | uniq | wc -l</code></p>
<p> The last you can find the full command if you just google the subject line</p>
<p> To list how many virtual processors you have you can use <code>/proc/cpuinfo | grep "^processor"</code></p>
<p> Now, lets set the free RAM and it's percentage, to see the free RAM we have lets run <code>free -m</code> the <code>-m</code> flag makes the output in MB as we want.</p>
<p> We only want the Mem row,to do that we can <code>grep Mem</code>, the available memory is in the 4th column, to represent that we use <code>$4</code>, and to show just that value we will use <code>awk '{print $4}'</code>, if you don't know what <code><a href="https://www.geeksforgeeks.org/awk-command-unixlinux-examples/" target="_blank">awk</a></code> is, got study please!</p>
<p> So overall the command is <code>free -m | grep Mem | awk '{print $4}'</code></p>
<p> To get the total RAM memory we will do the same but instead of the column <code>$4</code> the total memory is in the column <code>$2</code></p>
<p> So it will be <code>free -m | grep Mem | awk '{print $2}'</code></p>
<p> To get the percentage of usage, we have to get the usage that is in the column<code>$3</code> and we will have to divide <code>$3/$2</code> and multiply by 100, <code>free -m | grep Mem | awk '{printf("%.2f"), $3/$2*100}'</code></p>
<p> To see the server space you can run <code>df</code> that it will show you your disk space, to show it in MB we will use the flag <code>-m</code> and in GB we have to use 2 flags, <code>-B</code> to show the block size of the size we will ask, and <code>-g</code> that makes the size in GB. Our server it's the lines that start with <code>/dev/</code> so to get oly those lines we can <code>grep '^/dev/'</code>, the <code>^</code> means the beggining of the line so, every line that starts with ... . Those partitions(lines) are our home, our boot system and our dev, but actually you don't have acess to th boot partition because you can add or delete anything of that, so to take of only the line with boot we can use <code> grep -v '/boot$'</code>, the <code>-v</code>, is a flag to deselect the line, and the <code>$</code> is to select the end of the line, so it we are saying to take out the line that ends with ... . this time the print is a sum of the 3 lines so I created a variable (fdisk) and add the lines of the same column <code>awk '{fdisk += $4}</code>, to print the end result we have to add to the <code>awk</code> the following <code>END {print fdisk}</code>. So in the end we get <code>df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{fdisk += $4} END {print fdisk}'</code></p>
<p> To get the total disk space lets do the same but change the variable name to tdisk, the <code>-m</code> for <code>-Bg</code> and the column <code>$4</code> to <code>$2</code> so <code>df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{fdisk += $2} END {print fdisk}'</code></p>
<p> For the usage percent of the server is putting together what we did in the RAM but with the disk commands we did earlier, so <code>df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{fdisk += $3} {tdisk += $2} END {printf("%.2f"), fdisk/tdisk*100}'</code></p>
<p> Now lets cet the Cpu usage in percent, fortunately the command <code>top</code> already give us the cpu %, I'll use the flag <code>-b</code> to start in batch mode, that is usefull for sending output from top to toher programs or to a file, and I'll use the flag <code>-n numberx</code> that specify the max number of iterations or frames, top should produce before ending.</p>
<p> Because there is so many lines, lets grabe the one that matter <code>grep '^%Cpu'</code></p>
<p> To values we want are in the column <code>$3</code> so lets grab him in percentage with 1 decimal number <code>awk '{printf("%.1"), $3}'</code></p>
<p> In the end <code>top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $3}'</code></p>
<p> For the the date and time of the last reboot, the command <code>who</code> it's the one, it prints out information about users who are currently loggend in, and with the flag <code>-b</code> shows the time of last system boot.</p>
<p> To get only the information we want we just selecting the columns that we need <code>$3 $4</code>, but to print both columns we need to add a <code>" "</code> between, so <code>awk '{print $3 " " $4}'</code>, so the final command will be <code>who -b | awk '{print $3 " " $4}'</code></p>
<p> Now, theres no command to run that says if the LVM is active or not so the way I did is, I run the command <code>lsblk</code> that will show the partitions, and I'm grabing just the lvm part <code>grep lvm</code> to check I'll do an if, so if I the column <code>$1</code> is different from NULL print an yes and exit, otherwise print a no <code>awk '{if ($1) {print "yes";exit;} else {print "no"}}'</code> </p>
<p> The final command will be <code>lsblk | grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no";exit;}}'</code></p>
<p> To get the number of connections you can use <code>ss</code>, ss is a tool that displays network socket related information, and we're going to use <code>-t</code> that lists only the tcp connections. To get the active ones, we going to use <code>grep ESTAB</code> and to print the number os lines we will use <code>wc</code> that prints a newline, word and byte counts for files, and if we use the flag <code>-l</code> just print the newline counts. </p>
<p> The final command is <code>ss -t | grep ESTAB | wc -l</code></p>
<p> To see the number os users, we are going to run <code>who</code> again, and lets cut until the first space <code>cut -d " "</code>, the <code>-d</code> flag use delimiter instead of TAB for field delimite, and after lets use the flag <code>-f</code> to select only these fields and add 1, so its like <code? cut -d " " -f 1</code>.</p>
<p> Now lets use the command <code>sort</code> with the flag <code>-u</code> to output only the first of an equal run so it doesn't repeat, and that count the number of lines <code>wc -l</code>, so the command is <code>who | cut -d " " -f 1 | sort -u | wc -l</code></p>
<p> Setting the IP of our server we will search the IP of the host, if you run <code>hostname</code> it displays the system's DNS name, and if you had the flag <code>-I</code> it display  all  network  addresses  of the host, so just use <code>hostname -I</code></p>
<p> To find the MAC (Media Access Control) we can use the <code>ip</code> that shows / manipulate routing, network devices, interfaces and tunnels, and with the object <code>link show</code> shows the network device. The lines we want are the ones that have ether, so just <code>grep ether</code> and to get the MAC we just need to print the column <code>$2</code>, in the end is just <code>ip link show | grep ether | awk '{print $2}'</code></p>
<p> I tried so hard to do this with install netstat, but couldn't get to the right number, so just <code>sudo apt install net-tools</code></p>
<p> Now we have access to the command <code>journalctl</code> may be used to query the contents of the systemd(1) journal as
  written by systemd-journald.service(8), lets add <code>_COMM</code> to match for the script name <code>(sudo)</code>is added to the query. Lets grab just the commands thats what we want <code>grep COMMAND</code>, and lets cound the number of lines <code>wc -l</code> </p>
<p> The final command <code>journalctl _COMM=sudo | grep COMMAND | wc -l</code></p>
<p> Now lets use wall to print all the variables with the right text to it looks pretty.</p>
<p> In the final my script looks like this:</p>
<div align="center">
<img src="https://media.discordapp.net/attachments/920049215504269342/920885938995990538/scipt2.png?width=1262&height=1573">
</div>
<p> Now lets add the rule for the script execute with sudo permissions with out the sudo password. Run the <code>sudo visudo</code> and add <code>bmiguel- ALL=(ALL) NOPASSWD: /usr/local/bin/monitoring.sh</code> in the "Allow members of group sudo to execute any command"</p>
<p> Now to make the script run every 10 mins, you need to <code>sudo crontab -e</code> and at the end of the file put <code>*/10 * * * * /usr/local/bin/monitoring.sh</code></p>


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
