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
        stage('Deploying to Kubernetes') {
            steps {
                script {
                    kubernetesApply (configs: "deploymentservice.yaml")
                }
            }
        }
    }
}
