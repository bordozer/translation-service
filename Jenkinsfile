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
//                     input "Proceed with deployment to STAGE? Answer timeout is 1 hour, then deploying is going to be skipped"
                input(
                    id: 'Proceed', message: 'Proceed with deployment to STAGE?', parameters: [
                    [$class: 'BooleanParameterDefinition', defaultValue: false, description: '', name: 'Answer timeout is 1 hour, then deploying is going to be skipped']
                ])
                }
            }
        }

        stage('Deploy to Staging') {
            agent {
                label 'master'
            }

            steps {
                milestone ordinal: 2, label: 'STAGE'

                dir('terraform/webservice') {
                    sh "chmod +x tf-test.sh"
                    sh './tf-test.sh stage'
                }
            }
        }
		/* stage('Deploy to AWS STAGE env?') {
            agent none
            steps {
                timeout(time: 1, unit: 'HOURS') {
//                     input "Proceed with deployment to STAGE? Answer timeout is 1 hour, then deploying is going to be skipped"
                    input message: "Approve deploy to AWS STAGE env?", ok: ‘Yes’
                }
            }
        }

        stage('Deploying to AWS STAGE env') {
            agent {
                label 'master'
            }
            steps {
                milestone ordinal: 2, label: 'STAGE'
                ansiColor('xterm') {
                    dir('terraform/webservice') {
                        sh "sudo chmod +x tf.sh"
                        sh './tf-test.sh stage'
                    }
                }
            }
        } */
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
