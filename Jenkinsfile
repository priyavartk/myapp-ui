pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Get List of EC2 Instances') {
            steps {
                sh "aws ec2 describe-instances --filters Name=tag:app,Values=web --region eu-west-1"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                
            }
        }
    }
}
