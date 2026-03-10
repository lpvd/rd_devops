# 1. Set up n8n locally
Created [docker-compose.yml](docker-compose.yml) and run
```
docker compose up -d
```
![Screenshot 1](images/image1.png)

The n8n container is up and running:
![Screenshot 2](images/image2.png)

# 2. Create a Google form

![Screenshot 3](images/image4.png)

Resposnes -> Link to sheets -> Create a new google sheets.

# 3. Create a telegram bot
Create a bot via BotFather

![Screenshot 4](images/image3.png)

https://api.telegram.org/bot<TOKEN>/getUpdates

# 4. Create n8n workflow

1. In the n8n:
New workflow -> Add trigger -> Google Sheets -> On row added.
Credentials -> Create new credential -> Copy OAuth redirect URL.

2. Because I started a local docker container, I couldn't just log into Google Sheets. 
In Google Cloud:
APIs&Services -> Credentials -> Create credentials -> OAuth client ID

Configure consent screen (app name n8n-lab, and fill in emails).

Now we can create OAuth client.
![Screenshot 7](images/image7.png)

APIs&Services -> OAuth consent screen -> Audience -> test users -> add my email.

Authorized redirect URIs - paste the URI copied from n8n -> Create.

Copy Client ID and client secret to n8n -> Sign in to Google.
![Screenshot 8](images/image8.png)
![Screenshot 9](images/image9.png)

Enable Google drive API in google cloud.

FINALLY choose the document and sheet to finish the trigger:
![Screenshot 10](images/image10.png)

And after filling in the form, the result appeared in n8n:
![Screenshot 11](images/image11.png)
![Screenshot 12](images/image12.png)

3. Lookup rows in the google sheet - check if the email exists

4. Add IF node

5. If the email exists - append row with status "duplicate"

6. If not - add telegram node. Paste chat ID and the bot token in credentioals.
In the settings - retry on fail.

7. Append row with status "Sent"
![Screenshot 14](images/image14.png)


Current state:
![Screenshot 15](images/image15.png)
TODO: finish deduplication lookup, test telegram sent
