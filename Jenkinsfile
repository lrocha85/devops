pipeline {
    agent {
        label 'master'
    }

    environment {
	  DOCKERHUB_CREDENTIALS = 'dckr_pat_tXjZ2Fj_KhYMogyQdskNx6CKstM'
	}


    stages{
        stage('Clone repository') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], browser: [$class: 'BitbucketWeb', repoUrl: 'https://lrocha85@bitbucket.org/lrocha85/brasileirao.git'], extensions: [], userRemoteConfigs: [[credentialsId: 'devops_estudo', url: 'https://lrocha85@bitbucket.org/lrocha85/brasileirao.git']]])
            }
            
        }

        stage('Build') {
            steps{
                
                bat 'docker build -t lrocha85/brasileirao_image:latest .'
            }
        }
        stage('Login to dockerhub') {
            steps{
                bat 'docker login -u lrocha85 -p dckr_pat_tXjZ2Fj_KhYMogyQdskNx6CKstM'
            }    
        }
        stage('Push image') {
            steps{
                bat 'docker push lrocha85/brasileirao_image:latest'
            }  
        post {
            always {
               bat 'docker logout' 
            }
        }         
            
        }
    }
}