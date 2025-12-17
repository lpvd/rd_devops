- Created VM
- Installed nginx:
sudo apt update
sudo apt install nginx -y
nginx -v
![Screenshot 1](images/image1.png)

- Check status:
systemctl status nginx
![Screenshot 2](images/image2.png)

- Open browser in the VM
![Screenshot 3](images/image3.png)

- Installed utility to work with ppa:
sudo apt install software-properties-common -y

- Add ppa nginx/stable
![Screenshot 4](images/image4.png)

- It didn't work :)
![Screenshot 5](images/image5.png)

- Adding other ppa...
sudo add-apt-repository ppa:ondrej/nginx-mainline

And it's private.
![Screenshot 6](images/image6.png)

- Tried adding 
sudo add-apt-repository ppa:ondrej/nginx
But got the same error as for the nginx/stable.

- I still run 
sudo apt install nginx-full
and it triggered nginx reload.

The version had changed, so it means we did update the nginx to the latest from the ppa.
![Screenshot 7](images/image7.png)

- Returning to the official version.
Install ppa-purge
sudo apt install ppa-purge -y

Purge the ppa:
sudo ppa-purge ppa:nginx/stable

Which didn't work
![Screenshot 8](images/image8.png)

Manually removing the ppa.
![Screenshot 9](images/image9.png)

And manually removed and re-installed nginx.
sudo apt-get remove --purge nginx
sudo apt-get autoremove --Purge
sudo apt install -y nginx

So ppa-purge failed because it tries to run apt update, and it can't be finished because the release file is absent.
So it was just a broken ppa. 