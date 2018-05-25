pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {

        stage('px4-dev-base') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_base'
            }
          }
          steps {
            sh 'uname -a'
          }
        }

        stage('px4-dev-nuttx') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_nuttx'
            }
          }
          steps {
            sh 'uname -a'
          }
        }

        stage('px4-dev-simulation') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_simulation'
            }
          }
          steps {
            sh 'uname -a'
          }
        }

        stage('px4-dev-ros') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_ros'
            }
          }
          steps {
            sh 'uname -a'
          }
        }

      }
    }
  }
}
