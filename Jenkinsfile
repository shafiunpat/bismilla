pipeline {
  agent any
  stages {
    stage('git-stage') {
      steps {
        sh '''
          git -version
          git clone 'https://github.com/shafiunpat/bismilla.git'
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
    
    stage('maven-test') {
      steps {
        sh '''
          mvn --version
          mvn test
        '''
      }
    }
    stage('maven-test') {
      steps {
        sh '''
          mvn --version
          mvn test
        '''
      }
    }
  }
}
