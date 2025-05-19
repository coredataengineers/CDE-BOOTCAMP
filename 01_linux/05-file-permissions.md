# LINUX FILE PERMISSION
As we covered priviously that Users are usually created and a `User` can be added to a specific `Group`, also we covered some comman `Linux` comamnds with are also useful to naviaget around the file system, not just naviagtion, also to create, delete files and directories.

As much as these are users way to engage with the file system, also this is very dangerous is the `Linux` file system is not well controlled. Let's take a scenario where the administrator creates 2 user `A` and `B`, lets assume User `A` have access to the `/etc/shadow` file that contain all user's encypted password and User `A` accidentally delete that file, this will cause a massive problem.

Another Scenerio, lets say User `A` created a created a script inside a file inside a specif folder, we assume User `B` have access to this file and he execute this file, this can cause an unexpected incidents in a case where User `A` only wants to run that script once per year maybe to do some clean up.

To prevent critical incidents due to users unrestraicted actions, this is where `Linux` introduces `file permission`. This aim is to control individual access to have access to only what the administrator think they should access.

# PERMISSION OUTPUT BREAKDOWN
The command used to verify the permission applied on `files` and `directories` in Linux is `ls -l`, if you run this command from a specific directory, it will list all the files and directories with the permission set on each of them. 

Let's quickly understand the labelled image below in detail, this image gives the complete output of the command Linux users run to check if they have access.

![Screenshot 2025-05-19 at 09 38 31](https://github.com/user-attachments/assets/a8fcda19-504d-4086-b247-09436ea43121)
Starting from left to the right

- The letter `d` stands for `directory`, this means the object you are checking it's permission is a `directory`. If you have `-` dash , it means its a `file`.
  - For example if you see an output like this `-rwxrwxrwx`, it simply means its a `file`, however if you have `drwxrwxrwx`, then its a `directory`.
- Next is a box labelled `USER`, inside the box we have `rwx`, this first box shows the permission is for the `USER (owner)` who created the directory or who created the file. lets assume we have this output `-rwxrwxrwx`, 
  - `r` means the User that own the file has read permission on that file, read permission include being able to list the file
  - `w` means the User that own the file has write permission, write permission include being able to delete the file, being able to write something inside the file.
  - `x` shows the User who own the file is allowed to execute the file.
- The middle box labelled `GROUP` shows this is the permission for the group which the User who own the file or directrory belong to. Basically, The User can have write access on his or her file, but the group which the user belong to might not have that permission because maybe you don't want anyone to alter your file.
  - `r` means the `Group` which the `User` that own the file has read permission on that file, anyone who is part of that group will inherit that permission.
  - `w` means the `Group` which the `User` that own the file has write permission, write permission include being able to delete the file, being able to write something inside the file.
  - `x` shows the `Group` which the `User` who own the file is allowed to execute the file.
- The last box labelled `OTHERS` is for anyone who is not the owner of the file or the directory and who is also not in the group the user belongs to.
  - `r` means other users has read permission on the directory or file.
  - `w` means other users has write permission on the directory or file.
  - `x` means other users has permission to execute a file.
