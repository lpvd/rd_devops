Task 1:  
\- Installed Docker  
\- Created file docker-compose.yaml  
\- Run from terminal in the directory with the docker-compose file:

\`\`\` docker compose up

![Screenshot 1](images/image1.png)

![Screenshot 2](images/image2.png)

- Opened localhost:8080  
  ![Screenshot 3](images/image3.png)
    
  Task 2:  
    
- Retrieved the password via  
  \`\`\` docker exec \-it jenkins cat /var/jenkins\_home/secrets/initialAdminPassword  
- Installed suggested plugins  
  ![Screenshot 4](images/image4.png)
  ![Screenshot 5](images/image5.png) 
  ![Screenshot 6](images/image6.png)
  ![Screenshot 7](images/image7.png)
- Jenkins was missing Maven, so I added it in the settings (Tools \-\> Maven installations \-\> Add Maven)  
- Installed “Maven Integration” plugin  
  ![Screenshot 8](images/image8.png) 
- Restarted jenkins  
- Specified path to POM  
  ![Screenshot 9](images/image9.png)
- ![Screenshot 10](images/image10.png)
- ![Screenshot 11](images/image11.png)


Task *

- Added Jenkinsfile to the root of the forked repo: https://github.com/lpvd/gs-spring-boot/blob/main/Jenkinsfile
(also added the file to this repo)
- In Jenkins added new Pipeline -> Pipeline script from SCM ->  Specified my forked repo and "main" branch
- Generated GH token
- Added credentials to the Jenkins instance
- ![Screenshot 12](images/image12.png)
- ![Screenshot 13](images/image13.png)