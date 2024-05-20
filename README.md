# bismilla
![image](https://github.com/shafiunpat/bismilla/assets/150790160/6309ba97-dfb2-4494-88c8-b385312bba5f)



![image](https://github.com/shafiunpat/bismilla/assets/150790160/a5c85f51-a90b-4ed6-9746-97e8856974de)
'''
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
          git add
	  git status
          git commit
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
	
	continious delivery(dev and test no approval) and continious deployement(prod with approval)
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
'''

