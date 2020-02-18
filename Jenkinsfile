pipeline {
	agent any
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
                    input "Proceed with deployment to STAGE? Answer timeout is 1 hour, then deploying is going to be skipped"
                }
            }
        }

        stage('Deploying to AWS STAGE env') {
            agent {
                label 'master'
            }
            steps {
                ansiColor('xterm') {
                    dir('terraform/webservice') {
                        sh "sudo chmod +x tf.sh"
                        sh './tf-test.sh stage'
                    }
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
