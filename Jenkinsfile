pipeline {
    agent any

    stages {
        stage('Init') {
            steps {
                sh "cd terraform"
                sh "terraform init"     
            }
        }
        stage('Get List of EC2 Instances') {
            steps {
                sh "cd terraform"
                sh "terraform apply"
        }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                
            }
        }
}
