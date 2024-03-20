#Take python:3.9 image
FROM python:3.9-slim

#Set working directory
WORKDIR /app

#Installing the needed dependencies
RUN pip install --no-cache-dir Flask==2.0.2 Werkzeug==2.0.2 requests==2.26.0

#Copying the content of current directory into the working directory
COPY . .

#Make port 8081 available
EXPOSE 8081

#Run the app.py
CMD [ "python", "app.py" ]
