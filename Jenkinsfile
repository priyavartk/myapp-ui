pipeline {
  agent any
  environment {
    TF_WORKSPACE = 'terraform' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
  }
  
  stages {
    stage('Terraform Init') {
      steps {
       sh '''
                   cd terraform
                   terraform init
                '''
    }
    }
    stage('Terraform Plan') {
      steps {
        dir("${env.WORKSPACE}/terraform")
        {
          sh "pwd"
        }
        sh "terraform plan -out=tfplan -input=false -var-file='dev.tfvars'"
      }
    }
    stage('Terraform Apply') {
      steps {
        dir("${env.WORKSPACE}/terraform")
        {
          sh "pwd"
        }
        sh "terraform apply -input=false tfplan -var-file='dev.tfvars'"
      }
    }
  }
}
