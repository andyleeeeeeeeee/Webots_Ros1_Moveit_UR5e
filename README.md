# Webots Ros1-Moveit UR5e
A Webots Ros-Noetic-Moveit UR5e Demo.

## Pre-requests
 - Ubuntu 20.04
 - ROS Noetic-moveit 
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
