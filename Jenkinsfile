pipeline {
    agent {
        kubernetes {
            inheritFrom 'jenkins-agent'
            idleMinutes 5
            yamlFile 'build-pod.yaml'
            defaultContainer 'custom-agent'
        }
    }

    environment {
        AWS_ACCOUNT_ID = '581426944935'
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_CREDENTIALS = credentials('aws-auth')
        IMAGE_REPO_NAME = 'mike00000'
        IMAGE_TAG = 'latest'
        REPOSITORY_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage('authen') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws-auth', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                    }
                }
            }
        }

        stage('docker build') {
            steps {
                sh 'docker build -t mike00000 .'
            }
        }

        stage('push') {
            steps {
                script {
                    sh "docker tag mike00000:latest ${REPOSITORY_URL}:latest"
                    sh "docker push ${REPOSITORY_URL}:latest"
                }
            }
        }

        stage("k8s Deployment") {
            steps {
                script {
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'jen-crd', namespace: '', restrictKubeConfigAccess: false, serverUrl: 'https://api-raycoy-new-kops-k8s-l-qhsifq-ec869206e876b455.elb.us-east-1.amazonaws.com') {
                        // sh 'kubectl create secret docker-registry regcred --docker-server=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com --docker-username=AWS --docker-password=$(aws ecr get-login-password)'
                        sh 'kubectl apply -f k8sbook.yaml'
                        // sh 'envsubst < kjavaapps.yaml | kubectl apply -f -'
                    }
                }
            }
        }
    }
}
    