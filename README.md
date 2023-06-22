# realsense_ros_gazebo

> Code cloned from Intel RealSense Gazebo/ROS

[中文](./README_zh.md)

This repository provides the d435i camera model and iris_D435i model for simulation in Gazebo. Some parameters have been modified in the original model configuration files.

In fact, you can directly use the iris_depth_camera model provided by the official px4 for drone simulation.

## Quick Start

Tested and compiled on Ubuntu 18.04 with ROS and px4 environment installed.

```bash
git clone https://github.com/tugepaopaoo/realsense_ros_gazebo.git
cd realsense_ros_gazebo
catkin_make
```

After the compilation is complete, you can quickly check if it was successful by running the following command in the current terminal:

```bash
source devel/setup.bash && roslaunch realsense_ros_gazebo simulation.launch
```

<p align="center">
  <img src="pictures/simulation.png" width = "400" />
</p>
You can also run the following command to view the simulation:

```bash
source devel/setup.bash && roslaunch realsense_ros_gazebo simulation_D435i_sdf.launch
```

<p align="center">
  <img src="pictures/simulation_D435i_sdf.png" width = "400" />
</p>

## Environment Configuration

Configuring the environment to load iris unmanned aircraft with D435i in Gazebo simulation.

Copy the camera plugin `librealsense_gazebo_plugin.so` to the dynamic library directory of px4.

```bash
cp ${YOUR_WORKSPACE_PATH}/devel/lib/librealsense_gazebo_plugin.so ${YOUR_PX4_PATH}/build/px4_sitl_default/build_gazebo/
```

Copy the camera model D435i and aircraft model `iris_D435i` to the model library of px4.

```bash
cp -r ${YOUR_WORKSPACE_PATH}/src/realsense_ros_gazebo/sdf/D435i ${YOUR_PX4_PATH}/Tools/sitl_gazebo/models/
cp -r ${YOUR_WORKSPACE_PATH}/src/realsense_ros_gazebo/sdf/iris_D435i ${YOUR_PX4_PATH}/Tools/sitl_gazebo/models/
```

Note: When installing PX4, you should have already configured the relevant environment in the `.bashrc` file. The file should have the following commands at the end (`/home/user/PX4_Firmware` should be replaced with your own path, i.e., `${YOUR_PX4_PATH}` mentioned above):

```bash
source /home/user/PX4_Firmware/Tools/setup_gazebo.bash /home/hahaha/PX4_Firmware /home/hahaha/PX4_Firmware/build/px4_sitl_default
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/user/PX4_Firmware
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/user/PX4_Firmware/Tools/sitl_gazebo
```

## Launch Gazebo Simulation

Modify the `mavros_posix_sitl.launch` file in the `${YOUR_PX4_PATH}/launch` directory. Replace the model in `<arg name="sdf" default=" "/> with the iris_D435i.sdf` model copied to px4, and keep the rest unchanged. The modified part should look like the following:

```xml ￼
<!-- vehicle model and world -->
<arg name="est" default="ekf2"/>
<arg name="vehicle" default="iris"/>
<arg name="sdf" default="$(find mavlink_sitl_gazebo)/models/iris_D435i/iris_D435i.sdf"/>
<arg name="world" default="$(find mavlink_sitl_gazebo)/worlds/empty.world"/>
```

In the terminal, run the command to see the `iris_D435i.sdf` model in Gazebo.

<p align="center">
  <img src="pictures/iris_D435i.png" width = "400" />
</p>
In a new terminal, you can use the command rostopic list to see the relevant camera topic messages.

<p align="center">
  <img src="pictures/rostopic.png" width = "300" />
</p>

## Adjustment of Image Display in Front of the Camera

By adjusting the graphical properties in the camera model D435i.sdf file, you can choose to either display or hide the real-time camera view in front of the camera.

`<visualize>1</visualize>` for display;
`<visualize>0</visualize>` for hide;

<p align="center">
  <img src="pictures/D435i.png" width = "400" />
</p>

The effect when hidden is as follows:

<p align="center">
  <img src="pictures/iris_D435i_without_front_viewer.png" width = "400" />
</p>

## Change Log

- Origin

  - Only modifications were made to the iris_D435i.sdf file in the original repository.
  <p align="center">
    <img src="pictures/iris_D435i_modify.png" width = "400" />
  </p>
  Changed `<pose>0.25 0 0 1.5708 0 1.5708</pose>` to `<pose>0.12 0 0 1.5708 0 1.5708</pose>`

  Changed `<child>D435i::realsense_camera_link</child>` to `<child>D435i::camera_link</child>`

- June 22, 2023
  - Modify plugins src file to enable `<robotNamespace>` element.
  - Create new `sdf` and `sdf.jinja` file to make the multi-robot simulation possible
  - Add multi-robot launch file accordingly (You need to copy them to your repository)
