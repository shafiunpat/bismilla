pipeline {
  agent 'any'
  stages {
    stage('git-stage') {
      steps {
        sh '''
        rm -rf *
          git --version
          git clone 'https://github.com/shafiunpat/bismilla.git'
          git --version
        '''
      }
    }
    stage('maven-stage') {
      steps {
        agent {
                label "slave"
            }
        sh '''
        mvn --version
        ls -lart
         cd bismilla/Devopsjava/demo
         mvn clean install
        '''
      }
    }
     stage('docker-stage') {
      steps {
        agent {
                label "slave"
            }
        sh '''
        cd bismilla/Devopsjava/demo
        ls -lart
        docker --version
        docker build -t "bissmilla" .
        '''
      }
    }
  }
}
