# IP Addressing and CIDR 
This guide will give you the foundational knowledge needed to understand what really matters for you to establish confidence to work with `AWS Virtual Private Cloud (VPC)`. Please be aware that Networking is a wide and big topic, but we aim to cover what you will most likely come across most of the time and that should be enough to confidently start to work with Amazon VPC.

We will talk about the below `2` important Networking concept, at the end of this guide, you will be confident to know what's going on when next you hit some networking challenges.
- `IP Adressing`
- `Classless Inter-Domain Routing (CIDR)`

## INTERNET PROTOCOL ADDRESS (IP Address)
`IP Adressing:` IP Address is a unique 4 seperated doted numeric that act as an identity that is attached to every device when they communicate over the internet. e.g `23.56.98.11`, `123.34.100.0`.
- For example, you sat at the balcony surfing the internet with your laptop, let's assume you decided to visit `coredataengineers.com` on your favorite browser to sign up.
- Basically you want to communicate with [CoreDataEngineers webiste](https://coredataengineers.com/), in this case, your device (laptop) will be atached with a unique label called `IP Address`. How the IP Address is being genererated is outside the scope of this guide.
- This IP Address is what your computer will use to identify itself when you send that request to `CoreDataEngineers.com` server that host `CDE` website.

## CLASSLESS INTER-DOMAIN ROUTING (CIDR)
Let's talk about `CIDR Range or CIDR Block`.
- `CIDR Range` is a collection of `IP Addresses`.
- Basicaally, its a range of `IP Addresses` that starts from a specific IP Address and ends at a specific IP Address.
  - For example, a range of number between `1-5` will have `1, 2, 3, 4`
  - A `CIDR Range` follow the same concept, but of course not entirly the same. In addition to this, knowing the specific IP Address in a `CIDR Range` is not easy, because some `CIDR Range` has thousands of IP in it.
  - Be rest assured that there are tools already created that will help you to know
    - How many IPs we have in a `CIDR Range`
    - What the first and the last IP Address in a given CIDR Range are.
    - If a specific IP is in a CIDR Range.

Let's see an example of a `CIDR Range`, we are going to use a tool to see how many `IP Address` we have in the `CIDR Range`, the first IP and the Last IP, Lastly, we will see how to check if a specific IP is in the `CIDR Range` we have.
- Let's consider this CIDR Range of `10.5.0.0/30`.
  - The `/30` is called a `subnet mask` which tells us how many IPs we will have in the CIDR Range, which is calculated below
    - 2 ** (32 - 30) = 4 IPs
    - The `2` and `32` is always a constant. 
- Let's consider another CIDR Range of `170.8.0.0/28`
  - The `/28` tells us how many IPs we will have in the CIDR Range, which is calculated below
    - 2 ** (32 - 28) = 16
    - The `2` and `32` is always a constant.

## CHECK LIST OF IP ADDRESSES IN CIDR RANGE
Now that we know how to calculate how many IPs within a CIDR Range, but how do we know the individual `IP Address` in a specific `CIDR Range`?
  - Hit this [link](https://ipgen.hasarin.com/) and see the total list of the IPs in the above `CIDR Ranges`, make sure to select `CIDR` instead of `plain range` and input your 4 seperated digit and `/30` which is your subnet mask like the below image.
    - You will see 4 IPs
    - The first IP is `10.5.0.0`
    - The last IP is `10.5.0.3`. 

<img width="1116" height="510" alt="Screenshot 2025-08-19 at 20 30 58" src="https://github.com/user-attachments/assets/6f8a8902-1f11-4827-9f45-54e992650355" />

If you want to do a deep dive on how they get each of the IPs, and a general deep dive on IP Addressing and CIDR Range, please we highly recommend this [Youtube Video](https://www.youtube.com/watch?v=7hIbzlxbebc). 

## WHAT REALLY MATTERS
Now that we've understood the meaning and the difference between an `IP Address` and `CIDR Range`, and also how to use the tool to see how many IPs we have in a `CIDR Range`, lets talk about what you will most likely deal with most of the time. Before then, lets understand this first
- A `CIDR Range` is like a `private Network`, which is a range of IPs.
- Any IP that is not part of a specific `CIDR Range` is not part of that network.
- When an IP is not part of a `Network`, they cannot communicate with anything that lives inside that Network.

Let's look at the image below to understand very well.

<img width="957" height="447" alt="Screenshot 2025-08-19 at 21 03 59" src="https://github.com/user-attachments/assets/db5ed76a-d06c-482e-aaac-8e5ad3f1ff00" />

- The image above shows `John` trying to connect to a `Database` that lives inside a private network with `CIDR Range 10.5.0.0/30`.
- The `CIDR Range` has `4 IPs` if we use the tool previosuly to check it.
- The communication from `John's` laptop to connect to the `Database` inside the `Private network` is not possible, because `John's IP` is not part of the `CIDR Range`.
- You can use [this tool](https://tehnoblog.org/ip-tools/ip-address-in-cidr-range/) to check if an IP is part of a CIDR Range. i.e if the IP is part of the list of IPs in the `CIDR Range`. The tool looks like the below, in this case we are checking if `John's IP 56.120.2.8` is in the `CIDR Range 10.5.0.0/30`.

<img width="1324" height="267" alt="Screenshot 2025-08-19 at 23 17 19" src="https://github.com/user-attachments/assets/be3718be-7655-481b-897f-8e2374d46543" />

When you click submit and scroll down, you should see this below image saying that the IP is not part of the `CIDR Range`.

<img width="723" height="77" alt="Screenshot 2025-08-19 at 23 20 59" src="https://github.com/user-attachments/assets/5e3655aa-dcb1-4340-b96d-9953b3ded7e8" />

In short, what you need to understand to be able to work with `Amazon VPC` is to build a strong understanding of knowing if an `IP Address` belongs to a `CIDR Range`, IP Address and CIDR Range is everywhere in AWS, this is why we are covering this 2 concepts specifically.

Resource References
- [IP Addressing and CIDR Deep Dive](https://www.youtube.com/watch?v=7hIbzlxbebc).
- [Check List of IPs in a CIDR Range](https://ipgen.hasarin.com/).
- [Check if IP in CIDR Range ](https://tehnoblog.org/ip-tools/ip-address-in-cidr-range/).
- [Show first IP, last IP and how many IPs in a CIDR Range](https://www.ipaddressguide.com/cidr.aspx)















