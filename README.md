# Flask-random-string-app

To start with the project - <br>
Go to -> Terraform-create-instance folder. <br>
Create a keygen using: <br>
ssh-keygen <br>
And replace the path of the pub key file in create-Instance.tf

First execute: 
<br>
  terraform init
<br>
Now, execute the create-Instance.tf <br>
  terraform apply -auto-approve
  
<br>
It will automatically create an AWS infrastructure for us.<br>
<br>

Now, login to the EC2 Instance -<br>
Install Docker<br>
Create app.py and a Dockerfile
<br>

Now, build Dockerfile:
<br>
docker build -t flask-app .
<br>

Run the image:
<br>
docker run -d -p 8081:8081 flask-app
