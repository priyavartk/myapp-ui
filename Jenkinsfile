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
       sh '''
                   cd terraform
                   terraform plan -var-file=vars.tfvars
                '''
      }
    }
    stage('Terraform Apply') {
     steps {
       sh '''
                   cd terraform
                   terraform apply -auto-approve -var-file=vars.tfvars
                '''
      }
    }
  }
}
