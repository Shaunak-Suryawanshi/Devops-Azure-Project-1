pipeline {
    agent any
    triggers {
        githubPush()
    }

    environment {
        IMAGE_NAME = 'azure-monitoring-app'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        CONTAINER_NAME = 'azure-monitoring-app-ci'
        APP_PORT = '5000'
    }

    stages {
        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    script {
                        if (isUnix()) {
                            sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                        } else {
                            powershell '$img = "$env:IMAGE_NAME`:$env:IMAGE_TAG"; docker build -t $img .'
                        }
                    }
                }
            }
        }

        stage('Trivy Security Scan') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'command -v trivy >/dev/null 2>&1 || (echo "Trivy is not installed on Jenkins agent." && exit 1)'
                        sh 'trivy image --severity CRITICAL --exit-code 1 --no-progress ${IMAGE_NAME}:${IMAGE_TAG}'
                    } else {
                        powershell 'if (-not (Get-Command trivy -ErrorAction SilentlyContinue)) { Write-Error "Trivy is not installed on Jenkins agent."; exit 1 }'
                        powershell '$img = "$env:IMAGE_NAME`:$env:IMAGE_TAG"; trivy image --severity CRITICAL --exit-code 1 --no-progress $img'
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'docker rm -f ${CONTAINER_NAME} || true'
                        sh 'docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:5000 ${IMAGE_NAME}:${IMAGE_TAG}'
                    } else {
                        powershell 'docker rm -f $env:CONTAINER_NAME; if ($LASTEXITCODE -ne 0) { exit 0 }'
                        powershell '$img = "$env:IMAGE_NAME`:$env:IMAGE_TAG"; docker run -d --name $env:CONTAINER_NAME -p ${env:APP_PORT}:5000 $img'
                    }
                }
            }
        }

        stage('Verify Health') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'sleep 5'
                        sh 'curl -f http://localhost:${APP_PORT}/health'
                    } else {
                        powershell 'Start-Sleep -Seconds 5'
                        powershell 'Invoke-WebRequest -UseBasicParsing http://localhost:$env:APP_PORT/health | Select-Object -ExpandProperty Content'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                if (isUnix()) {
                    sh 'docker ps --filter name=${CONTAINER_NAME}'
                } else {
                    powershell 'docker ps --filter "name=$env:CONTAINER_NAME"'
                }
            }
        }
        success {
            echo 'Pipeline completed: image built and container started.'
        }
        failure {
            echo 'Pipeline failed. Check stage logs in Jenkins.'
        }
    }
}
