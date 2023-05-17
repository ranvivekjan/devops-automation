pipeline {
    agent {
        label 'k8-node'
    }
    /*tools{
        maven 'maven_3_5_0'
    }*/
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ranvivekjan/devops-automation']]])
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t ranjanvivek/dev-inte .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u ranjanvivek -p ${dockerhubpwd}'
                   }
                   sh 'docker push ranjanvivek/dev-inte'
                }
            }
        }
        /*stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8sconfigpwd')
                }
            }
        }*/
        /*stage('Deploy to k8s'){
            steps{
                script {
	                sh "cp deploymentservice.yaml /home/ubuntu"
                }
                script {
	                try{
		                sh "kubectl apply -f ."
	                }catch(error) {
		                sh "kubectl create -f ."
	                }
                }
            }
        }*/
	stage('Deploy App on k8s') {
		steps {
			sshagent(['k8s']) {
				sh "scp -o StrictHostKeyChecking=no deploymentservice.yaml ubuntu@65.0.55.243:/home/ubuntu"
				script {
					try{
						sh "ssh ubuntu@65.0.55.243 kubectl create -f ."
					}catch(error){
						sh "ssh ubuntu@65.0.55.243 kubectl create -f ."
					}
				}
			}  
		}
	}
    }
}
