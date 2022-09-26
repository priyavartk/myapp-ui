pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                filelist="git diff --name-only $GIT_PREVIOUS_COMMIT $GIT_COMMIT"
                echo ${filelist}
            }
        }
    }
}
