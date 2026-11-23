pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t sampleapp:latest .'
            }
        }

        stage('Deploy to Staging (infra010)') {
            steps {
                sh '''
                    docker stop samplerunning || true
                    docker rm samplerunning || true
                    docker run -d --name samplerunning -p 8081:8080 sampleapp:latest
                '''
            }
        }

        stage('Deploy to Production (dmz010)') {
            steps {
                sshagent(['dmz010-ssh-key']) {
                    sh '''
                        docker save sampleapp:latest | ssh -o StrictHostKeyChecking=no vagrant@192.0.2.10 "docker load"
                        ssh -o StrictHostKeyChecking=no vagrant@192.0.2.10 "
                            docker stop samplerunning || true
                            docker rm samplerunning || true
                            docker run -d --name samplerunning -p 8081:8080 sampleapp:latest
                        "
                    '''
                }
            }
        }
    }
}