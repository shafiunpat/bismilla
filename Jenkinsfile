pipeline {
  agent any
  stages {
    stage('git-stage') {
      steps {
        sh '''
          git --version
          git clone 'https://github.com/shafiunpat/bismilla.git'
          git --version
        '''
      }
    }
    stages {
    stage('maven-stage') {
      steps {
        sh '''
          mvn --version
        '''
      }
    }  
  }
}
