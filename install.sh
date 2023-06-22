#!/bin/bash
CATKIN_PATH=$(pwd)

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	echo "Usage: $0 [-p <px4_path>] "
	echo "-s flag is used to script spawning vehicles e.g. $0 -s iris:3,plane:2"
	exit 1
fi

while getopts p: option; do
	case "${option}" in
	p) PX4_PATH=${OPTARG} ;;
	esac
done

# Copy built `.so` files to px4 build directories
cp ${CATKIN_PATH}/devel/lib/librealsense_gazebo_plugin.so ${PX4_PATH}/build/px4_sitl_default/build_gazebo-classic/

# Copy models to px4 gazebo models directory
cp -r ${CATKIN_PATH}/src/realsense_ros_gazebo/sdf/D435i ${PX4_PATH}/Tools/simulation/gazebo-classic/sitl_gazebo-classic/models/
cp -r ${CATKIN_PATH}/src/realsense_ros_gazebo/sdf/iris_D435i ${PX4_PATH}/Tools/simulation/gazebo-classic/sitl_gazebo-classic/models/
