# IP Addressing and CIDR 
This Networking guide will give you the foundational knowledge needed to understand what really matters for you to establish confidence to work with `AWS Virtual Private Cloud (VPC)`. Please be aware that Networking a wide and big topic, but we aim to cover what you will most likely come across most of the time and that should be enough to confidently work with Amazon VPC.

We will talk about the below `2` important Networking concept, at the end of this guide, you will be confident to know what's going on when next you hit some networking challenges.
- IP Adressing
- Classless Inter-Domain Routing (CIDR)

## INTERNET PROTOCOL ADDRESS (IP Address)
`IP Adressing:` IP Address is a unique 4 seperated doted numeric that act as an identity that is attached to every device when they communicate over the internet. E.g `23.56.98.11`, `123.34.100.0`
- For example, you sat at the balcony surfing the internet with your laptop, let's assume you decided to visit `coredataengineers.com` on your favorite browser to sign up.
- Basically you want to communicate with CoreDataEngineers webiste, in this case, your device (laptop) will be atached with a label called IP Address. How the IP Address is being genererated will be be discuss later in the guide.
- This IP Address is what your computer will use to identify itself when you send that request to `CoreDataEngineers.com` server that host our website.

## CLASSLESS INTER-DOMAIN ROUTING (CIDR)
Let's talk about `CIDR Blocks/Range`.
- CIDR Block/Range is a collection of IP Addresses
- Basicaally, its a range of IP Addresses that starts from a specific IP Address and ends at a specific IP Address.
  - For example, a range of number between `1-5` will have `1, 2, 3, 4`
  - A CIDR Block/Range follow the same concept, but of course not entirly the same. In addition to this, knowing the specific IP Address in a CIDR Block is not easy, because some CIDR Block has thousands of IP in it.
  - Be rest assured that there are tools already created to help know 
    - How many IPs we have in a CIDR Block/Range
    - What the first and the last IPs in a given CIDR Block/Range are.
    - If s specific IP is in a CIDR Range.

Let's see an example of a CIRR Range, we are going to use a tool to see how many IP Address we have in the CIDR Range, the first IP and the Last IP, Lastly, we will see how to check if a specific IP is in the CIDR Range we have.
- Let's consider this CIDR Range of `10.5.0.0/30`
  - The `/30` is called a `subnet mask` which tells us how many IPs we will have in the CIDR Range, which is calculated below
    - 2 ** (32 - 30) = 4 IPs
    - The `2` and `32` is always a constant. 
- Let's consider another CIDR Range of `170.8.0.0/28`
  - The `/28` tells us how many IPs we will have in the CIDR Range, which is calculated below
    - 2 ** (32 - 28) = 16
    - The `2` and `32` is always a constant.
- Now that we know how to calculate how many IPs within a CIDR Range, but how do we know the individual IP Address in a specific CIDR Range?
  - Hit this [link](https://ipgen.hasarin.com/) and see the total list of the IPs in the above CIDR Ranges, make sure to select `CIDR` instead of `plain range` and input your 4 seperated digit like the below image. You will see 4 IPs, the first IP is `10.5.0.0` and the last IP is `10.5.0.3`. 

<img width="1116" height="510" alt="Screenshot 2025-08-19 at 20 30 58" src="https://github.com/user-attachments/assets/6f8a8902-1f11-4827-9f45-54e992650355" />

If you want to do a deep dive on how they get each of the IPs, and a general deep dive on IP Addressing and CIDR Range, please we highly recommend this [Youtube Video](https://www.youtube.com/watch?v=7hIbzlxbebc). 

Now that we've understood the meaning and the difference between an IP Address and CIDR Block/Range, and also how to use the tool to see how many IPs we have in a CIDR Range, lets talk about what you will most likely deal with most of the time. Before then, lets understand this first
- A CIDR Range is like a private Network, which is a range of IPs.
- Any IP that is not part of a specific CIDR Range is not part of that network
- When an IP is not part of a Network(CIDR Range), they cannot enter that Network.

Let's look at the image below to understand very well.

<img width="957" height="447" alt="Screenshot 2025-08-19 at 21 03 59" src="https://github.com/user-attachments/assets/db5ed76a-d06c-482e-aaac-8e5ad3f1ff00" />











