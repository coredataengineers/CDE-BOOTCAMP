# LINUX FILE PERMISSION
As we covered priviously that Users are usually created and a User can be added to a specific group, also we covered some comman Linux comamnds with are also useful to naviaget around the file system, not just naviagtion, also to create, delete files and directories.

As much as this are users way to engage with the file system, also this is very dangerous is the Linux file system is not well controlled. Let's take a scenario where 
the administrator creates 2 user A and B, lets assume User A have access to the `/etc/shadow` file that contain all user's encypted password and User A accidentally delete that file, this will cause a massive problem.

Another Scenerio, lets say User A created a created a script inside a file inside a specif folder, we assume User B have access to this file and he execute this file, this can cause an unexpected incidents in a case where User A only wants to run that script once per year maybe to do some clean up.

To prevent critical incidents due to users unrestraicted actions, this is where Linux introduces file permission. This aim is to control individual access to have access to only what the administrator think they should access.


To better understand file permission, let's quickly understand the labelled image below in detail

![Screenshot 2025-05-19 at 09 38 31](https://github.com/user-attachments/assets/a8fcda19-504d-4086-b247-09436ea43121)
