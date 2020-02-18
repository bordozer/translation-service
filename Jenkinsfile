pipeline {
	agent any
	options {
        timeout(time: 1, unit: 'HOURS')
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

        stage('Deploy to AWS STAGE env?') {
            agent none
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    input(
                        id: 'Proceed',
                        message: 'Proceed with deployment to STAGE?',
                        parameters: [
                            [
                                $class: 'BooleanParameterDefinition',
                                defaultValue: false,
                                description: 'Answer timeout is 1 hour, then deploying is going to be skipped',
                                name: 'If checkbox is checked, the deployment to AWS STAGE env will be done'
                            ]
                        ]
                    )
                }
            }
        }

        stage('Deploy to Staging') {
            agent {
                label 'master'
            }

            steps {
                milestone ordinal: 2, label: 'STAGE'

                sh "terraform -version"

                dir('terraform/webservice') {
                    sh "chmod +x tf_appy.sh"
                    sh './tf_appy.sh stage'
                }
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
