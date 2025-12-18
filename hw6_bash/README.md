1. Wrote a bash script (backup.sh) for making backup copies from /home/user/data to /home/user/backup every day.
Added the script to this folder.

Made it executable
chmod +x ./backup.sh

Set  up cron job for this script to be executed every day at 2 am.
![Screenshot 1](images/image1.png)

2. Created new systemd service to automatically run a script, which checks is google.com is available and writes it to a file.
Added a script (check_site.sh) to this folder.
Added service and timer files to this foler.

Set up the daemon:
![Screenshot 2](images/image2.png)

Activated it:
systemctl daemon-reexec
systemctl enable --now check-site.timer

Check that it exists:
![Screenshot 3](images/image3.png)

It ran every 5 mins:
![Screenshot 4](images/image5.png)
![Screenshot 5](images/image6.png)

3. Created new script (system_monitor.sh), added it to cron too.
crontab -e
*/10 * * * * /usr/lpv/scripts/system_monitor.sh

Logs from the script:
![Screenshot 6](images/image4.png)

4. Rotate nginx's access Logs.
gedit /etc/logrotate.d/nginx

It already contained rotation rules for both error and access logs:
![Screenshot 7](images/image7.png)

logrotate -f /etc/logrotate.d/nginx
![Screenshot 8](images/image8.png)