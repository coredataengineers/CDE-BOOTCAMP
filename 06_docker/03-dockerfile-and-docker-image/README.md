# Dockerfile and Docker image.
Understanding a Dockerfile is like holding a cookbook in your hands. As long as you have it, you have access to the various recipes in the book.

This guide is to help you understand the basics of a Dockerfile and how docker images fit into this picture.

At the end of this guide, you should:
- Understand what a Dockerfile is and why it’s foundational.
- Learn how Docker uses a Dockerfile to create a Docker image.
- Understand the purpose of Docker images, and how they relate to containers.
- Get comfortable with basic Docker commands like docker build and docker run.
- Practice by building and running your own Docker image and container.

## Understanding a Dockerfile and why it is foundational

First, we need to understand that **Docker** exists so that when you want to cook fried rice in your house, your friend's house or your parents' house, the food tastes exactly the same.
You’ve probably heard the phrase: “It works on my laptop, but not on yours.”
This happens because different computers have different operating systems, software versions and this can cause code to behave unexpectedly.

In technical terms, Docker exists to make sure your code is in a container with everything it needs to work exactly the same on any machine.
To get to that container, you first need a Docker image. Before that, there is the Dockerfile, the root of any container you want to create and that is why it is foundational.

** A Dockerfile is a text file that contains the instructions that tell Docker how to build a Docker image. That image is what Docker uses to create and run containers. **

So basically:
** Dockerfile → builds Docker image → which creates running containers that makes sure your code runs the same regardless of who runs it or where ** 
