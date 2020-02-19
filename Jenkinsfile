pipeline {
	agent any
	options {
        timeout(time: 1, unit: 'HOURS')
    }
    parameters {
        booleanParam(
            name: 'AWS_DEPLOY_TO_STAGING',
            defaultValue: false,
            description: 'Deploy to AWS STAGING?'
        )
        booleanParam(
            name: 'AWS_DEPLOY_TO_PROD',
            defaultValue: false,
            description: 'Deploy to AWS PROD? For `master` branch only'
        )
    }
	stages {
		stage("Build & Unit tests") {
            agent {
                label 'master'
            }

			steps {
				script {
					echo "-----------------------------------------------------------------------------------------------"
					echo "Build"
					sh "./gradlew --version"
					sh "./gradlew clean bootJar test"
				}
			}
            post {
                always {
                    junit "**/test-results/test/*.xml"
                }
            }
		}

        stage('Deploying to STAGING') {
            agent {
                label 'master'
            }
            when {
                expression { AWS_DEPLOY_TO_STAGING == "true" }
            }

            steps {
                sh "echo Deploying to STAGING"
                withCredentials([
                        string(credentialsId: 'AWS_STAGE_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'AWS_STAGE_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                        string(credentialsId: 'AWS_STAGE_DEFAULT_REGION', variable: 'AWS_DEFAULT_REGION')
                ]) {
                    dir('terraform/webservice') {
                        sh "chmod +x tf_apply.sh"
                        sh './tf_apply.sh staging'
                    }
                }
            }
        }

        stage('Deploying to PROD (declarative yet)') {
            agent {
                label 'master'
            }
            when {
                branch 'master'
                expression { AWS_DEPLOY_TO_PROD == "true" }
            }

            steps {
                sh "echo Deploying to PROD"
                // TODO: deploy to PROD
            }
        }
	}

	post {
	    always {
          deleteDir()
        }

		failure {
			echo "-----------------------------------------------------------------------------------------------"
			echo "-                                       FAILED                                                -"
			echo "-----------------------------------------------------------------------------------------------"
		}
		success {
			echo "-----------------------------------------------------------------------------------------------"
            echo "-                                      SUCCESS                                                -"
            echo "-----------------------------------------------------------------------------------------------"
		}
	}
}
