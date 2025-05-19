# LINUX FILE PERMISSION
As we covered priviously that Users are usually created and a User can be added to a specific group, also we covered some comman Linux comamnds with are also useful 
to naviaget around the file system, not just naviagtion, also to create, delete files and directories.

As much as this are users way to engage with the file system, also this is very dangerous is the Linux file system is not well controlled. Let's take a scenario where 
the administrator creates 2 user A and B, lets assume User A have access to the `shadow` file that contain all user's encypted password and User A accidentally delete that file,
this will cause a massive problem.

Another Scenerio, lets say User A created a created a script inside a file inside a specif folder, we assume User B have access to this file and he execute this file, this can cause 
an unexpected incidents in a case where User A only wants to run that script once per year maybe to do some clean up.

To prevent critiocal incidents due to users unrestraict6ed actions, this is where linux introduces file permission. This aim is to control individual access to have access to only what the adminsitartor think they should access.
