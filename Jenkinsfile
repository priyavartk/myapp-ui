pipeline {
  agent any
  environment {
    TF_WORKSPACE = 'terraform' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
  }
  
  stages {
    stage('Terraform Init') {
      steps {
        dir("${env.WORKSPACE}/terraform")
        {
          sh "pwd"
        }
        sh "terraform init -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false -var-file='dev.tfvars'"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan"
      }
    }
  }
}
