# bismilla
![image](https://github.com/shafiunpat/bismilla/assets/150790160/6309ba97-dfb2-4494-88c8-b385312bba5f)



![image](https://github.com/shafiunpat/bismilla/assets/150790160/a5c85f51-a90b-4ed6-9746-97e8856974de)
```
pipeline {
  agent  'any'
  stages   ('dev-stage') {
  agent   "label-build-slave-1" 
    stage('git-task') {
      steps {
        sh '''
          git --version
	  git status
		  git clone url
        '''
      }
    }
stage('maven-task') {
      steps {
        sh '''
          mvn --version
		  mvn clean package
        '''
      }
    }
stage('test-task') {
      steps {
        sh '''
          mvn test
        '''
      }
    }
stage('sonar-task') {
      steps {
        sh '''
          sonarqube (url)
        '''
      }
    }
stage('docker-image-build-task') {
      steps {
        sh '''
          docker build -t (image name) .
        '''
      }
    }
	stage('docker-image-push') {
      steps {
        sh '''
          docker push (ECR)
        '''
      }
    }
	
	continious deployement(dev and test no approval) and continious delivery (prod with approval)
pipeline { 
  agent  'any'
  stages   ('dev-stage/test-stage') {
  agent   "label-build-slave-1"

 # optional
   stage('no container') {
      steps {
        sh '''
          mvn --version
		  mvn spring-boot:run or java -jar (jar name)
        '''
      }
    }
	stage('container') {
      steps {
        sh '''
          docker --version
		  docker pull image name (ECR url)

             # optional

		 docker run -it --name -p 8080:8080 -p 50000:50000 jenkins/jenkins 
        '''
      }
    }
stage('approval') {
      steps {
        timeout(time: 15, unit: "MINUTES") {
	                    input message: 'Do you want to approve the deployment?', ok: 'Yes'
	                }   
      }
    }
#contunious Deployement#
	
stage('k8-deploy-task') {
      steps {
        sh '''
		kubectl apply -f file name.yaml
         
        '''
      }
    }
  } 
}
```

```
**Monitor Project**

import psutil
import boto3
import time

# AWS SNS configuration
SNS_TOPIC_ARN = 'arn:aws:sns:us-east-2:YOUR_ACCOUNT_ID:monitor'  # Replace with your SNS Topic ARN
AWS_REGION = 'us-east-2'  # Replace with your AWS region

# Thresholds
CPU_THRESHOLD = 10 # in percentage
MEMORY_THRESHOLD = 10  # in percentage

# Initialize boto3 SNS client
sns_client = boto3.client('sns', region_name='us-east-2')

def send_sns_notification(cpu_usage, memory_usage):
    message = f"Warning!\nCPU usage is at {cpu_usage}%\nMemory usage is at {memory_usage}%"
    try:
        response = sns_client.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=message,
            Subject='High Resource Usage Alert'
        )
        print("SNS notification sent successfully")
    except Exception as e:
        print(f"Failed to send SNS notification: {e}")

def monitor_system():
    while True:
        cpu_usage = psutil.cpu_percent(interval=1)
        memory_usage = psutil.virtual_memory().percent
        
        if cpu_usage > CPU_THRESHOLD or memory_usage > MEMORY_THRESHOLD:
            send_sns_notification(cpu_usage, memory_usage)
        
        time.sleep(5)  # check every 5 seconds

if __name__ == "__main__":
    monitor_system()
```

```
To run your Python script, you need to follow these steps:
**1. Save the Script**
Save your script in a file, for example, monitor.py.

**2. Now we can configure AWS CLI using the command: aws configure and fill in details like AWS keys, region, and output format.**
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: us-east-2  # Replace with your preferred region
Default output format [None]: json
   
**3. Ensure Dependencies are Installed**
Ensure that you have the required Python packages (psutil and boto3) installed. Since pip3 was not found earlier, make sure you have followed the steps to install pip3 and the packages:
sudo yum install python3 -y
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
pip3 install --user psutil boto3

**4.Run the Script:**
python3 monitor.py
```
