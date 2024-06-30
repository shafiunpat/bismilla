import psutil
import boto3
import time

# AWS SNS configuration
SNS_TOPIC_ARN = 'arn:aws:sns:us-east-2:151854138445:sns.fifo' 
AWS_REGION = 'us-east-2'  # Replace with your AWS region

# Thresholds
CPU_THRESHOLD = 80  # in percentage
MEMORY_THRESHOLD = 80  # in percentage

# Initialize boto3 SNS client
sns_client = boto3.client('sns', region_name=us-east-2)

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

def monitor():
    while True:
        cpu_usage = psutil.cpu_percent(interval=1)
        memory_usage = psutil.virtual_memory().percent
        
        if cpu_usage > CPU_THRESHOLD or memory_usage > MEMORY_THRESHOLD:
            send_sns_notification(cpu_usage, memory_usage)
        
        time.sleep(5)  # check every 5 seconds

if __name__ == "__main__":
    monitor()
