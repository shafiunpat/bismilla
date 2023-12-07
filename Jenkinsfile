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
        sh '''
        mvn --version
        ls -lart
         cd bismilla/Devopsjava/demo
         mvn clean install
        '''
      }
    }
  }
}
