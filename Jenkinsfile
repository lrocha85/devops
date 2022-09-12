pipeline {
    agent {
        label 'master'
    }

    	environment {
		DOCKERHUB_CREDENTIALS=credentials('devops_estudo')
	}


    stages{
        stage('Clone repository') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], browser: [$class: 'GithubWeb', repoUrl: 'https://github.com/lrocha85/devops/tree/main/brasileirao_api'], extensions: [], userRemoteConfigs: [[credentialsId: 'devops_estudo', url: 'https://github.com/lrocha85/devops.git']]])
            }
            
        }

        stage('Build') {
            steps{
                
                bat 'docker build -t lrocha85/brasileirao_image:latest .'
            }
        }
        stage('Login to dockerhub') {
            steps{
                bat 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }    
        }
        stage('Push image') {
            steps{
                bat 'docker push lrocha85/estudo/brasileirao_image:latest'
            }           
            
        }
    }
}