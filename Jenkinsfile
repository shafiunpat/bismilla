pipeline {
  agent any
  stages  {
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
        pwd
        ls -lart
        cd bismilla
        ls -lart
        cd Devopsjava
        ls -lart
        cd demo
         mvn --version
         mvn clean package
        '''
      }
    }
  }
}
