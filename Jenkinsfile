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
                sh "aws ec2 describe-snapshots --filters Name=app,Values=web --region us-west-1"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                
            }
        }
    }
}
