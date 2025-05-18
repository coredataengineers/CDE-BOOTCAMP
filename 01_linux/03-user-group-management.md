# LINUX USER MANAGEMNET
This section will give the necessary knowledge to understand the `User Managemnet` in `Linux`. Let's talk about how a typical
set up of our laptop is when we newly purchase one. Ideally we will create a user and a password, and with that we can
start to use the laptop and create different things, install  various apps. Also, we can decided to create another user for guest on the same laptop for guest usage.

It's a bit similar in Linux, also you create user in Linux, however users doesn't have all permissions by default. 
We are going to go through different user mnanagemet commands to allow us create a new user, create a new group, add that user into the group, delete the user and
delete the group.

# CREATE USER AND GROUP
Users in Linux is simply an individual who need access to the Linux Opeating system.
To create a user, you can leverage the following 2 commands 
- `adduser <TheUserName>`
  - This command will prompt for password and some other information about the user.
  - To verify the user has been created, you can run this command `cat /etc/passwd` to see the list of users in the `passwd` file.
- `useradd <TheUserName>`
  - This command doesn't prompt for password, the administartor can later add password to the user by running this command `passwd <TheUserName>`. This will prompt for the password to be inserted.
  - To verify the user has been created, you can run this command `cat /etc/passwd` to see the list of users in the `passwd` file.
- To check the encrypted passord of the users, run the command `cat /etc/shadow`, this will list all the encrypted password for all users.

Group is much easier to manage users, users of the same functions can go into the same group and have a single permission applied to that group, rather than individual user permission.

To create a group in Linux, run the below command
- `addgroup <TheGroupName>`

To add a User to a Group, run the below command
- `usermod -aG <TheGroupName> <TheUserName>`

To check the user added, run the below command
- `cat /etc/group`

To check the list of Users in a specific group, run the below command
- `cat /etc/group | grep TheGroupName`


# DELETE USER AND GROUP
Sometimes, there are some users or groups that are no longer needed, its ideal to clean up and tidy the Linux environment.

To remove a user from the group
- `gpasswd -d TheUserName TheGroupName`

To delete the group
- `delgroup TheGroupName`

To delete the user
- `deluser TheUserName`
