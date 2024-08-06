pipeline {
    agent any
    environment {
        ECR_REGISTRY = 'public.ecr.aws/t7e9v6m0'
        ECR_REPOSITORY = 'world-db-springmvc'
        AWS_REGION = 'us-east-1'
        APP_RUNNER_REGION = 'eu-west-2'
        AWS_CREDENTIALS_ID = 'jenkins-ecr-apprunner-credentials'
        APP_RUNNER_SERVICE_NAME = 'world-db-springmvc'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/BaselessFabric/world-db-springmvc.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Prepare Docker Image') {
            steps {
                script {
                    sh "cp target/*.jar app.jar"
                    sh "docker build -t ${ECR_REPOSITORY}:${env.BUILD_NUMBER} ."
                    sh "docker tag ${ECR_REPOSITORY}:${env.BUILD_NUMBER} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${env.BUILD_NUMBER}"
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    withAWS(credentials: AWS_CREDENTIALS_ID, region: AWS_REGION) {
                        sh "aws ecr-public get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                        sh "docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Update App Runner') {
            steps {
                withAWS(credentials: AWS_CREDENTIALS_ID, region: APP_RUNNER_REGION) {
                    sh """
                    aws apprunner update-service --service-arn arn:aws:apprunner:${APP_RUNNER_REGION}:211125415319:service/${APP_RUNNER_SERVICE_NAME} \
                    --source-configuration ImageRepository={ImageRepositoryType=ECR_PUBLIC,ImageIdentifier=${ECR_REGISTRY}/${ECR_REPOSITORY}:${env.BUILD_NUMBER},ImageConfiguration={Port=8080}}
                    """
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
