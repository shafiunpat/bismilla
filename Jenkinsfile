pipeline {
  agent any
  stages  {
    stage('git-stage') {
     # agent{
          label 'git-slave'
      #}
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
         mvn clean package
        '''
      }
    }
  }
}
