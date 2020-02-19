pipeline {
	agent any
	options {
        timeout(time: 1, unit: 'HOURS')
    }
    parameters {
        booleanParam(
            name: 'AWS_DEPLOY_STAGE',
            defaultValue: false,
            description: 'Deploy to AWS STAGE?'
        )
        booleanParam(
            name: 'AWS_DEPLOY_PROD',
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

        stage('Deploying to STAGE') {
            agent {
                label 'master'
            }
            when {
                expression { AWS_DEPLOY_STAGE == "true" }
            }

            steps {
                sh "echo Deploying to STAGE"
                dir('terraform/webservice') {
                    sh "chmod +x tf_appy.sh"
                    sh './tf_appy.sh stage'
                }
            }
        }

        stage('Deploying to PROD (declarative yet)') {
            agent {
                label 'master'
            }
            when {
                branch 'master'
                expression { AWS_DEPLOY_PROD == "true" }
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
