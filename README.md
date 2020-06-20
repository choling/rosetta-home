# Running Rosetta@Home on Raspberry Pi 3B+

## Aims
1. Install rosetta@home on RPi 3B+  
2. Contribute RPi 3B+

## Steps
### Setup BOINC and 
1. Firstly, make sure everything is up to date  
`sudo apt-get update`  
`sudo apt-get upgrade`  

2. Install BOINC GUI
`sudo apt-get install boinc`

3. Create and configure `zram.sh` in `/usr/bin/`

4. Make `zram.sh` executable
`sudo chmod +x /usr/bin/zram.sh'

5. Edit "/etc/rc.local" file to run script on boot  
`sudo nano /etc/rc.local`

6. And add this line before exit 0  
`/usr/bin/zram.sh &`  

7. Check whether your ZRAM partitions  
`zramctl`  

### Put the kernel into 64 bit mode
1.Make a copy of the config.txt  
`cd /boot`  
`sudo cp config.txt config.old`  

2. Add `arm_64bit=1` to the end of `config.txt`    

3. Reboot and Check by using:
`sudo reboot`  
`uname -a`  


### Tell BOINC to use aarch64
1. Edit the `cc_config.xml`  
`cd /etc/boinc-client`  
`sudo nano cc_config.xml`  

2. Add the following  
```xml
<cc_config>
  <log_flags>
    <task>1</task>
    <file_xfer>1</file_xfer>
    <sched_ops>1</sched_ops>
  </log_flags>
  <options>
    <alt_platform>aarch64-unknown-linux-gnu</alt_platform>
  </options>
</cc_config>
```

3. Restart BOINC to pick up this change  
`sudo systemctl restart boinc-client`



 BOINC manager configuration  
`Menu->System Tools->Boinc Manager'



## Reference
1.
