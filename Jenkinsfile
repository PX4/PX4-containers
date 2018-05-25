pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {
        stage('px4-dev-base') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_base'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'make posix_sitl_default'
            }
          }
        }

        stage('px4-dev-nuttx') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_nuttx'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'make px4fmu-v2_default'
            }
          }
        }

        stage('px4-dev-simulation') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_simulation'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw -e HOME=$WORKSPACE'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'make posix_sitl_default sitl_gazebo'
            }
          }
        }

        stage('px4-dev-ros') {
          agent {
            dockerfile {
              filename 'docker/px4-dev/Dockerfile_ros'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw -e HOME=$WORKSPACE'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'make posix_sitl_default sitl_gazebo'
            }
          }
        }

      }
    }
  }

  environment {
    CCACHE_DIR = '/tmp/ccache'
    CI = true
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactDaysToKeepStr: '30'))
    timeout(time: 60, unit: 'MINUTES')
  }

}
