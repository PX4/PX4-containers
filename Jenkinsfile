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

      } // parallel
    } // stage Build

    stage('Build (on base)') {
      parallel {

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
              sh 'make posix_sitl_default package'
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
              sh 'make posix_sitl_default package'
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

        stage('px4-dev-ros-kinetic') {
          agent {
            dockerfile {
              filename 'Dockerfile_ros-kinetic'
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
              sh 'make posix_ocpoc_ubuntu'
              sh 'make posix_ocpoc_ubuntu package'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-raspi') {
          agent {
            dockerfile {
              filename 'Dockerfile_raspi'
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
              sh 'make posix_rpi_cross'
              sh 'make posix_rpi_cross package'
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

      }
    }

    stage('Build ROS2 (after ROS1)') {
      parallel {
        stage('px4-dev-ros2-ardent') {
          agent {
            dockerfile {
              filename 'Dockerfile_ros2-ardent'
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
              // does not test anything relevant now wrt ROS2
              // px4_ros_com build can be added when released instead
              sh 'make posix_sitl_default sitl_gazebo'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-ros2-bouncy') {
          agent {
            dockerfile {
              filename 'Dockerfile_ros2-bouncy'
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
              // does not test anything relevant now wrt ROS2
              // px4_ros_com build can be added when released instead
              sh 'make posix_sitl_default sitl_gazebo'
              sh 'ccache -s'
              sh 'make clean'
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
