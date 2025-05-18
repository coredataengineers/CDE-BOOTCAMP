# LINUX OVERVIEW
This section will cover the overview of what `Linux` is about in a layman word, but before we dive into that, its important to take a step back to understand what is an `Operating System`.

Let's consider a scenario where you just bought a new laptop, typically you will get either of the popular ones like `MacOS` or `Windows`, they are both called `Operating System`.
Also, its worth to mention that this laptop will come with it's hardware specifications like `CPU`, `Memory`, `Storage` e.t.c.

The below image shows what the laptop will have and this also demonstrates the relationship between the `User`, the `Operating System` and the underlying `Hardware`.

<img width="616" alt="Screenshot 2025-05-17 at 23 30 25" src="https://github.com/user-attachments/assets/155499c3-b8f6-4ed1-8c2e-77e087d9ab26" />

Image Summary below 👇 
- The `First Layer` shows the User who owns the laptop, the User will install applications on his or her laptop like `VScode`.
- The `Second Layer` is the application layer, in this case, we assumed the User launched the VScode to enable he or she to write code.
- The `Third Layer` is where the `Operating System software` sits, in this case, the application launched on the second layer will communicate with the `Operating System`.
- The `Fourth Layer` highlights the `Operating System` talking to the hardware to request for resources like `CPU`, `Memory` to be allocated to the VScode application that was launched.

In short, `Operating Systems` are software that bridges the communication between the User applications and the underlying Hardware. As users, we launch various applications on our laptop, but how 
the applications get resources to run is hidden away from us, that is made possible becasue of the Operating System software.

# WHAT IS LINUX
`Linux` is an open source `Operating System`, similar to `MacOS` and `Windows`. Open Source in this context means it was developed by the community, contrary to `MacOS` and `Windows` which are both developed and owned 
by Apple Inc and Microsoft respectively.

The below image shows a similar layers as we have above, the major difference is that the applications communicate with the `Linux Kernel` which is the actuall Operating System
software via the `System Calls` interface.

<img width="799" alt="Screenshot 2025-05-17 at 23 56 03" src="https://github.com/user-attachments/assets/a368b919-d3a5-48dd-889b-f3cb5ae05ea4" />
Brief read on Linux Kernel [here](https://www.redhat.com/en/topics/linux/what-is-the-linux-kernel).

# WHY LINUX

- `Zero Cost`: Linux is free to use, the source code is available to everyone.
- `Security`: Linux is very secure, and this is as a result of a strong community backing the project.
- `Industry Standard`: Linux is widely adopted in the tech space, in fact, about 96% of applications runs on Linux servers.
- `High Demand`: Linux skill is in high demand, considering it powers nearly all of the applications out there, Engineers with Linux skill are sought after.


