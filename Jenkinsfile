#!/bin/env/groovy

pipeline {
  agent none

  stages {

    stage('Build') {
      parallel {

        stage('px4-dev-base-bionic') {
          agent {
            dockerfile {
              filename 'Dockerfile_base-bionic'
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
              sh 'make px4_sitl_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-base-xenial') {
          agent {
            dockerfile {
              filename 'Dockerfile_base-xenial'
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
              sh 'make px4_sitl_default'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-docs') {
          agent {
            dockerfile {
              filename 'Dockerfile_docs'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw'
            }
          }
          environment {
            HOME = "${WORKSPACE}"
          }
          steps {
            git 'https://github.com/PX4/Devguide.git'
            dir(path: 'Devguide') {
              sh 'export'
              sh 'gitbook install'
              sh 'gitbook build'
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
              sh 'make px4_sitl_default'
              sh 'make px4_sitl_default package'
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
              sh 'make px4_fmu-v2_default'
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
              sh 'make scan-build'
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
              sh 'make px4_sitl_default sitl_gazebo'
              sh 'make px4_sitl_default package'
              sh 'ccache -s'
              sh 'make clean'
            }
          }
        }

        stage('px4-dev-ros-melodic') {
          agent {
            dockerfile {
              filename 'Dockerfile_ros-melodic'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw -e HOME=$WORKSPACE'
            }
          }
          steps {
            sh 'git clone --recursive https://github.com/PX4/Firmware.git catkin_ws/src/Firmware'
            sh '''#!/bin/bash -l
              cd catkin_ws;
              source /opt/ros/melodic/setup.bash;
              catkin build -j$(nproc) -l$(nproc);
            '''
            sh 'rm -rf catkin_ws'
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
            sh 'git clone --recursive https://github.com/PX4/Firmware.git catkin_ws/src/Firmware'
            sh '''#!/bin/bash -l
              cd catkin_ws;
              source /opt/ros/kinetic/setup.bash;
              catkin build -j$(nproc) -l$(nproc);
            '''
            sh 'rm -rf catkin_ws'
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
              sh 'make aerotenna_ocpoc_ubuntu'
              sh 'make aerotenna_ocpoc_ubuntu package'
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
              sh 'make emlid_navio2_cross'
              sh 'make emlid_navio2_cross package'
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

      } // parallel
    } // stage Build (on base)

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
            sh 'git clone --recursive https://github.com/PX4/Firmware.git catkin_ws/src/Firmware'
            sh '''#!/bin/bash -l
              cd catkin_ws;
              source /opt/ros/ardent/setup.bash;
              colcon build --event-handlers console_direct+ --symlink-install;
            '''
            sh 'rm -rf catkin_ws'
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
            sh 'git clone --recursive https://github.com/PX4/Firmware.git colcon_ws/src/Firmware'
            sh '''#!/bin/bash -l
              cd colcon_ws;
              source /opt/ros/bouncy/setup.bash;
              colcon build --event-handlers console_direct+ --symlink-install;
            '''
            sh 'rm -rf colcon_ws'
          }
        }

        stage('px4-dev-ros2-crystal') {
          agent {
            dockerfile {
              filename 'Dockerfile_ros2-crystal'
              dir 'docker/px4-dev'
              args '-e CCACHE_BASEDIR=$WORKSPACE -v ${CCACHE_DIR}:${CCACHE_DIR}:rw -e HOME=$WORKSPACE'
            }
          }
          steps {
            sh 'git clone --recursive https://github.com/PX4/Firmware.git colcon_ws/src/Firmware'
            sh '''#!/bin/bash -l
              cd colcon_ws;
              source /opt/ros/bouncy/setup.bash;
              colcon build --event-handlers console_direct+ --symlink-install;
            '''
            sh 'rm -rf colcon_ws'
          }

        }
      } // parallel
    } // Build ROS2 (after ROS1)

  } // stages

  environment {
    CCACHE_DIR = '/tmp/ccache'
    CI = true
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactDaysToKeepStr: '30'))
    timeout(time: 60, unit: 'MINUTES')
  }
} // pipeline
