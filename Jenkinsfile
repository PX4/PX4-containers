pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {

        stage('px4-dev-base') {
          agent {
            dockerfile {
              filename 'Dockerfile_base'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make posix_sitl_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-base_archlinux') {
          agent {
            dockerfile {
              filename 'Dockerfile_base_archlinux'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make posix_sitl_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-clang') {
          agent {
            dockerfile {
              filename 'Dockerfile_clang'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          environment {
              CC = 'clang'
              CXX = 'clang++'
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make posix_sitl_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-nuttx') {
          agent {
            dockerfile {
              filename 'Dockerfile_nuttx'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make px4fmu-v2_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-nuttx_clang') {
          agent {
            dockerfile {
              filename 'Dockerfile_nuttx_clang'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              //sh 'make px4fmu-v2_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-simulation') {
          agent {
            dockerfile {
              filename 'Dockerfile_simulation'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw -e HOME=$WORKSPACE'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make posix_sitl_default sitl_gazebo'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-ros') {
          agent {
            dockerfile {
              filename 'Dockerfile_ros'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw -e HOME=$WORKSPACE'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make posix_sitl_default sitl_gazebo'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-armhf') {
          agent {
            dockerfile {
              filename 'Dockerfile_armhf'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
              sh 'make clean'
              sh 'ccache -z'
              sh 'make posix_bebop_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-ecl') {
          agent {
            dockerfile {
              filename 'Dockerfile_ecl'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          environment {
              CC = 'clang'
              CXX = 'clang++'
          }
          steps {
            git 'https://github.com/PX4/Firmware.git'
            dir(path: 'Firmware') {
              sh 'export'
            }
          }
        }

        stage('px4-docs') {
          environment {
            HOME = "${WORKSPACE}"
          }
          agent {
            dockerfile {
              filename 'Dockerfile_docs'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          steps {
            git 'https://github.com/PX4/Devguide.git'
            dir(path: 'Devguide') {
              sh 'export'
              //sh 'gitbook build'
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
