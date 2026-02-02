0. Installed mongoDB (with Compass), created a new connection.
![Screenshot 1](images/image1.png)

1. Create a new DB
![Screenshot 2](images/image2.png)
and needed collections
![Screenshot 3](images/image3.png)

2. Fill in the collections
![Screenshot 4](images/image4.png)
![Screenshot 5](images/image5.png)
![Screenshot 6](images/image6.png)
![Screenshot 7](images/image7.png)

3. Find clients older than 30:
```
{ "age": { "$gt": 30 } }
```
![Screenshot 8](images/image8.png)

4. Workouts with medium difficulty:
```
{ "difficulty": "Medium" }
```
![Screenshot 9](images/image9.png)

5. Client with certain id
```
{ "client_id": 2 }
```
![Screenshot 10](images/image10.png)
