pipeline {
    agent any
    
    environment {
        REPONAME = "inosadocker/database"
        AZURE_REPOSITORY_CREDENTIALS = "azure-repository-credentials"
    }
    
    stages {
        stage ("Create tags") {
            steps {
                script {

                    def dockerTag = ''
                    
                    if (env.TAG_NAME) {
                        env.DOCKER_TAG = "release-${env.TAG_NAME}"
                    } else {
                        error "Unsupported tag: ${env.BRANCH_NAME ?: env.TAG_NAME}"
                    }

                    env.IMAGE_FULL_TAG = "${REPONAME}:${DOCKER_TAG}"
                    env.AWS_TAG = "public.ecr.aws/s6z8v3g0/${IMAGE_FULL_TAG}"
                    env.AZURE_REPOSITORY_IMAGE_TAG = "${AZURE_REPOSITORY_URL}/${IMAGE_FULL_TAG}"
                }
            }
        }

        stage('Docker Build') {
            steps {
                retry(3) {
                    sh "docker build -t ${AWS_TAG} -t ${AZURE_REPOSITORY_IMAGE_TAG} ."
                }
            }
            post {
                failure {
                    slackSend(channel: "${INOSA_CD_FAIL_SLACK_CHANNEL}", color: '#fc0303', message: "<!here> Failed to build ${IMAGE_FULL_TAG} image \n ${BUILD_URL}" )
                }
            }
        }

        stage('Docker Push') {
            parallel {
                stage('AWS') {
                    steps {
                        sh "docker push ${AWS_TAG}"
                    }
                    post {
                        failure {
                            slackSend(channel: "${INOSA_CD_FAIL_SLACK_CHANNEL}", color: '#fc0303', message: "<!here> Failed to push ${IMAGE_FULL_TAG} image to AWS repository \n ${BUILD_URL}" )
                        }
                    }
                }
                stage('Azure') {
                    steps {
                        withCredentials([usernamePassword(credentialsId: "${AZURE_REPOSITORY_CREDENTIALS}", passwordVariable: "AZURE_CLIENT_SECRET", usernameVariable: "AZURE_CLIENT_ID")]) {
                            sh "docker login ${AZURE_REPOSITORY_URL} --username ${AZURE_CLIENT_ID} --password ${AZURE_CLIENT_SECRET}"
                            sh "docker push ${AZURE_REPOSITORY_IMAGE_TAG}"
                        }
                    }
                    post {
                        failure {
                            slackSend(channel: "${INOSA_CD_FAIL_SLACK_CHANNEL}", color: '#fc0303', message: "<!here> Failed to push ${IMAGE_FULL_TAG} image to Azure repository \n ${BUILD_URL}" )
                        }
                    }
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