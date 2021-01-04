# Webots Ros1-Moveit UR5e
A Webots Ros-Melodic-Moveit UR5e Demo with Docker Image Option.
## Note 
If you have Docker engine, you can skip 'Pre-requisites' and 'Install'. you can start from 'Docker Image' to build the [Dockerfile](Dockerfile) as a Docker Image and run this repo in a Docker container. If you prefer to use this repo without Docker engine, you can ignore Dockerfile and you have to meet the Pre-requests as below: 
## Pre-requests
 - Ubuntu 18.04
 - ROS Melodic-moveit
 - Webots 2020b-rev1 or newer version
## Install
1. Compile this under workspace `~/Webots_Ros1_Moveit_UR5e`
````
catkin_make
````
2. Add 'source' and 'export' to .bashrc
````
source ~/Webots_Ros1_Moveit_UR5e/devel/setup.bash
````
## Docker Image
The [Dockerfile](Dockerfile), which can be used to build a docker image consists of ubuntu18.04, nvidia/cudagl, webots, ros-melodic, moveit, and self-defined ROS packages. 
This is super useful and convenient. Any computer with recent Docker Engine and Nvidia GPU can easily use this repo without installing a ton of dependence. 
Also, it can beyond the limitation of operating system, eg. you can even use this repo on Windows. 
### Creat Image
Using docker without 'sudo' the cmd. If you never done this before, it is suggested that typing in following cmd:
````
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo systemctl restart docker
sudo chmod a+rw /var/run/docker.sock
````
Create the image using Dockerfile， Run the cmd under `~/Webots_Ros1_Moveit_UR5e`  
````
docker build -t webots_moveit_ur5 .
````
This will create the deployment image named `webots_moveit_ur5`

### NVIDIA Container Toolkit
You will need the NVIDIA GPU support for the docker container. To build the bridge, run following cmd:
```
curl https://get.docker.com | sh \
  && sudo systemctl start docker \
  && sudo systemctl enable docker
```
````
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
````
````
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
````
### Run Image
Run docker image in container called `webots_interface`
````
docker run --gpus=all --privileged --net=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -it --rm --name webots_interface webots_moveit_ur5 bash
````
Tips: You can create `.bash_aliases` file in `~` and add the following to it(optional):
````
alias wmu_run="docker run --gpus=all --privileged --net=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -it --rm --name webots_interface webots_moveit_ur5 bash"
````
Such that you only need to issue wmu_run to launch the program.  

This repo needs 4 terminals in total, so after you do docker run in one terminal, you have to open 3 new terminals, and type in following cmd to connect these 3 terminals with the first one you opened by the same container `webots_interface` 
````
docker exec -it webots_interface bash
````
## Usage
### Launch webots world with ur5 (terminal 1)
````
roslaunch ur_e_webots ur_webots_world.launch
````
### Launch webots ur5 driver (terminal 2)
````
roslaunch ur_e_webots ur5e.launch
````

### Control ur5 without moveit (Optional)
You can control ur5 by rostopic pub by typing following command in a terminal:
````
rostopic pub -1 /follow_joint_trajectory/goal control_msgs/FollowJointTrajectoryActionGoal "header: 
  seq: 0
  stamp: 
    secs: 1672
    nsecs: 512000000
  frame_id: ''
goal_id: 
  stamp: 
    secs: 1672
    nsecs: 512000000
  id: "/move_group-1-1672.512000000"
goal: 
  trajectory: 
    header: 
      seq: 0
      stamp: 
        secs: 0
        nsecs:         0
      frame_id: "world"
    joint_names: [elbow_joint, shoulder_lift_joint, shoulder_pan_joint, wrist_1_joint, wrist_2_joint,
  wrist_3_joint]
    points: 
      - 
        positions: [0.4800836524707155, -0.3743967070402672, 6.065492035530852, -3.2493820917516176, 0.24115501607092973, 3.1438560272633125]
        velocities: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        accelerations: [0.0, 0.0, -0.35136087310689307, 0.0, 0.0, 0.0]
        effort: []
        time_from_start: 
          secs: 0
          nsecs:         0
      - 
        positions: [0.7508745678414053, -0.6685986884092454, 6.031372993376337, -3.2257606070739477, 0.2752779815153147, 3.1436747000131815]
        velocities: [1.0556874250870498, -1.1469562475600767, -0.13301422504971686, 0.09208914672032482, 0.1330295201262731, -0.0007069103390236631]
        accelerations: [2.8392965167376563, -3.0847661923028857, -0.3577449317718908, 0.24767595719992672, 0.35778606824521314, -0.0019012522225270137]
        effort: []
        time_from_start: 
          secs: 0
          nsecs: 440693570
      - 
        positions: [1.0216654832120953, -0.9628006697782237, 5.997253951221823, -3.202139122396278, 0.3094009469596996, 3.14349337276305]
        velocities: [1.0606453357223284, -1.1523427913824666, -0.13363891056300975, 0.09252163246285489, 0.13365427747107678, -0.0007102302594894569]
        accelerations: [-2.8393610501625988, 3.0848363049263336, 0.3577530628373031, -0.24768158654427305, -0.357794200245603, 0.0019012954354556849]
        effort: []
        time_from_start: 
          secs: 0
          nsecs: 621593558
      - 
        positions: [1.292456398582785, -1.2570026511472019, 5.963134909067308, -3.178517637718608, 0.34352391240408453, 3.143312045512919]
        velocities: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        accelerations: [-2.8793566289320554, 3.1282896774438966, 0.36279241519580363, -0.25117045894526946, -0.36283413207053233, 0.0019280773099641867]
        effort: []
        time_from_start: 
          secs: 1
          nsecs:  55288456
  path_tolerance: []
  goal_tolerance: []
  goal_time_tolerance: 
    secs: 0
    nsecs:         0"
````
### Launch ur5 moveit server (terminal 3)
````
roslaunch ur5_e_moveit_config ur5_e_moveit_planning_execution.launch
````
### Launch Rviz with Motion Planning plugin (terminal 4)
````
roslaunch ur5_e_moveit_config moveit_rviz.launch config:=true
````
Now you can control ur5 in Webots by MontionPlanning Plugin in Rviz

## Trouble shooting
If you cannot launch Webots in docker container, you may need this cmd before you docker run:
````
xhost +local:root > /dev/null 2>&1
````

If you cannot open Rviz in docker container, you may need this cmd before you docker run:
````
xhost +local:docker
````
