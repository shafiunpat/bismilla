pipeline {
  agent any
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
      agent {
                label "slave"
            }
      steps {
        sh '''
        chmod -R 777 *
        ls -lart;
        cd /Devopsjava
        ls -lart
        '''
      }
    }
  }
}
