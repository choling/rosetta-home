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
`sudo apt-get install boinctui
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

### Force BOINC to use more memory
1. Open the file with BOINC settings  
`sudo nano /etc/boinc-client/global_prefs_override.xml`  

2. Insert the following lines
```xml
<global_preferences>
<run_if_user_active>1</run_if_user_active>
<suspend_cpu_usage>100.000000</suspend_cpu_usage>
<leave_apps_in_memory>0</leave_apps_in_memory>
<confirm_before_connecting>0</confirm_before_connecting>
<hangup_if_dialed>0</hangup_if_dialed>
<dont_verify_images>0</dont_verify_images>
<work_buf_min_days>0.700000</work_buf_min_days>
<work_buf_additional_days>0.300000</work_buf_additional_days>
<max_ncpus_pct>100.000000</max_ncpus_pct>
<cpu_scheduling_period_minutes>60.000000</cpu_scheduling_period_minutes>
<disk_interval>60.000000</disk_interval>
<disk_max_used_gb>100.000000</disk_max_used_gb>
<disk_max_used_pct>100.000000</disk_max_used_pct>
<disk_min_free_gb>0.100000</disk_min_free_gb>
<vm_max_used_pct>90.000000</vm_max_used_pct>
<ram_max_used_busy_pct>300.000000</ram_max_used_busy_pct>
<ram_max_used_idle_pct>300.000000</ram_max_used_idle_pct>
<cpu_usage_limit>100.000000</cpu_usage_limit>
</global_preferences> 
```  

3. Apply the setting  
`boinccmd --read_global_prefs_override` 

4. Reduce the amount of RAM available to GPU
`sudo raspi-config`  
then  
Advanced Options -> Memory split -> 16MB  


### Finally
 
"Rosetta needs 1900 MB RAM but only 966MB is available for use"
RPi 3B+ is configured, however there is not enough RAM to run the project. :(
RPi 4 should be considered, 


## Reference
1. [reddit](https://www.reddit.com/r/BOINC/comments/g0r0wa/running_rosetta_covid19_workunits_on_raspberry_pi/)
2. [Rosetta@Home](https://boinc.bakerlab.org/)
3. [Install BOINC](https://pimylifeup.com/raspberry-pi-boinc/)
4. [RPi projects](https://projects.raspberrypi.org/en/)
5. [RPi 4B 8Gb](https://hken.rs-online.com/web/p/processor-microcontroller-development-kits/1822098/)
6. [RPi blog](https://www.rs-online.com/designspark/aipidentifier-cn)

