# Aircrack

installing aircrack 

```sudo apt-get install realtek-rtl88xxau-dkms
sudo aurmon-ng check kill
sudo airmon-ng start wlan0

```

--------------------------------------------------------------------------------- 
Aircrack - (Airmon) sudo apt-get install realtek-rtl88xxau-dkms 
sudo airmon-ng check kill sudo airmon-ng start wlan0 
--------------------------------------------------------------------------------- 
aircrack airodump: this is for 2.4ghz: sudo airodump-ng wlan0 
this will pull everything from 5ghz too: sudo airodump-ng -b a 
wlan0 if you click [a] you can change the filter to see stations 
connected to the access points the names of probes are showing 
you the names that devices like phones and computers are looking 
out for a router named that if you see any devices that are "not 
associated", and you change your wifi adapters name to the probe 
name their device will connect to you as a wifi connection, and 
this is the heart of an evil twin attack. these commands are 
found in aircrack when you choose the suite that you are using. 
if you click [tab] while in the access points view it will 
colorcode points of interest for scan and you can mark them with 
[m] when you select it with arrow keys. When you go to the 
stations view you can now see a coorilation between points of 
interest and stations. 
--------------------------------------------------------------------------------- 
aircrack air-replay: sudo aireplay-ng -0 25 -D -a [router mac 
address] ["name of your wifi adapters name" (ex. eth0, wlan0)]
        -0 is deauth attack | 25 is the packet amount | -D is 
        making it so it doesnt check for what channels devices 
        are connecting to | -a is access point | you can put -c 
        after the [router mac address] to just disconnect one 
        [device mac address]
this is important because you can capture a WPA handshake during 
the devices autoconnect using airodump. now with this you can 
use aircrack and use the WPA handshake and it will start 
cracking the wifi routers password to make a fake access point 
use: sudo airbase-ng -C 60 -P [wifi adapter name]
        -C is for change and the 60 is the amount of seconds the 
        broadcast is for | the -P is making the fake wifi 
        whatever the name of the probes devices are looking for
macchanger can be used to change your mac address to whatever 
this can be used for evil twin, can be used for getting onto 
hotel wifi networks, airport networks, once you can capture that 
WPA handshake and crack it you can get the password, and then 
you can also just kick off a device and change your mac address 
to the mac address the router is looking for tools to make this 
all work fern - wifite- ettercap - aircrack when and if you ever 
do this you should always change the mode your wifi adapter is 
working in from monitor to managed. nmap --script vuln <ip addr>
https://stuffjasondoes.com/2018/07/18/putting-alfa-wi-fi-adapters-into-monitor-mode-in-kali-linux/
