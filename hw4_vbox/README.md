1. Installed VirtualBox  
![Screenshot 1](images/image1.png)

2. Created new virtual machine.
![Screenshot 2](images/image2.png)

3. Specified base memory size, number of CPUs and disk size. Enabled EFI.
![Screenshot 3](images/image3.png)
![Screenshot 4](images/image4.png)

In the settings changed Network adapter to bridged adapter.
![Screenshot 5](images/image5.png)

4. Downloaded latest LTS Ubuntu
![Screenshot 6](images/image6.png)

Selected optical drive
![Screenshot 7](images/image7.png)
![Screenshot 8](images/image8.png)
![Screenshot 9](images/image9.png)

Installed Ubuntu
![Screenshot 10](images/image10.png)
![Screenshot 11](images/image11.png)

5. Made a snapshot
![Screenshot 12](images/image12.png)

Created a folder with a file
![Screenshot 13](images/image13.png)

Restore the snapshot
![Screenshot 14](images/image14.png)
![Screenshot 15](images/image15.png)

6. Turned off the machine, resized the storage:
![Screenshot 16](images/image16.png)

lsblk showed that /dev/sda size is still 20gb. Deleting the snapshot and restarting the machine helped to see the size change.
Now I could resize the disk size from the VM:
![Screenshot 17](images/image17.png)

In the VM settings changed RAM to 4bg
![Screenshot 18](images/image18.png)

...and number of CPUs to 4:
![Screenshot 19](images/image19.png)

7. Close VM window -> Power off the machine.
Delete the Vm with files and virtual hard disks.
![Screenshot 20](images/image20.png)