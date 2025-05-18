# LINUX FILE SYSTEM
Just like any Operating System we mentioned previously, they generally have a file system on Operating Systems.
To efficiently be able to work with Linux, its important to understand Linux file system and various commands
required to work with the Linux file system.

Before, we dive into this, we need to know that when you create files or folders on your laptop, you are
doing this on the Operating System file system. The image below 👇  shows the layout of a Linux file system.


<img width="1392" alt="Screenshot 2025-05-18 at 10 31 55" src="https://github.com/user-attachments/assets/ee3e04a6-1e84-4ccb-82aa-64d014c0f9ef" />

## SUMMARY OF SOME IMPORTANT DIRECTORIES
- `/` is the Root dircetory of the Linux file system, all other directories (folders) like mnt, home, bin are inside the Root directory.
- `/bin` directory contains common user command binaries, for example `printenv` which user use to see all environemnt variables e.t.c.
- `/sbin` directory is strictly for Linux administrator, it contains administrative commands like `adduser` which is used for creating users, this directory should not be amde available to basic users.
- `/home` directory contain directory for individual users created, it serves as the starting point for each users created.
- `/etc` directory serves as a central directory for system-wide configuration files, for example the file `shadow` is in the `/etc` directory which contains User's encypted passwords.
- `/proc` directory provides access to Linux Kernel process information, and system metrics, for example the `meminfo` file in this directory provides detailed information about the system's memory usage.

## BASIC LINUX COMMANDS
Linux has lots of commands available to users to work on linux, we will cover few important ones , but the exhaustive list can be found in the `/bin` directory inside the Root directory.
- `pwd`: This command means Print Working Wirectory, this will show the current directory you are startring from the `/` Root directory.
  - Command usage is simply running `pwd` on the terminal.
- `cd`: This means change directory, it helps to move/switch from one directory to the other. For example if you are in the Root directory `/`, running `cd bin` will take you into the bin directory.
  - Command usage: `cd <NameOfTheDirectory>` on the terminal.
- `mkdir`






