pipeline{
  agent {
                label "slave"
            }
     parameters{
        booleanParam(name: 'autoApprove',defaultvalue:false,description:'Automatically run apply after generating plan?')
        #choice(name:'action', choices:['apply''destroy'],description:'select action to perform')
     }
     environment{
        AWS_ACESS__KEY_ID  =credencials('aws_acess_key_id')
        AWS_SECRET_ACESS_KEY  =credentials('aws_secret_acess_key')
        AWS_REGION ='us-east-1'
     }
     stages{
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
    stage('Terraform Init') {
      steps {
        script {
          sh "terraform init"
      }
    }
    stage('Terraform Init') {
      steps {
        script {
          sh "terraform validate"
      }
    }
    stage('Terraform Init') {
      steps {
        script {
          sh "terraform validate"
      }
    }
  }
}      