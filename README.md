# Building Docker Images

This is a repository for building Docker images.  

## Prerequisites
* Docker should be installed.  The procedure for doing this is covered in chapter 1 at https://github.com/rubyonracetracks/tutorial-docker-stretch .
* You can only build 64-bit Docker images in a 64-bit Linux OS.
* You can only build 32-bit Docker images in a 32-bit Linux OS.
* If your host machine and OS are 64-bit systems, you can build 32-bit Docker images from within a 32-bit Linux OS guest machine.
* You should use the nuke.sh command in one of the docker-debian-stretch repositories to clear all Docker images and containers.  Because this disrupts all other Docker activity, it is recommended that you build Docker images on a dedicated physical or virtual machine.

## Building Images
* Download this repository, use the "cd" command to enter the directory for the Docker image you wish to build.  Run the "build.sh" script.
* If the name of the directory does not begin with "32bit-", then the directory is for the 64-bit version of the Docker image.

## Docker Hub
* All 64-bit Docker images are produced on Docker Hub using the automated build procedure.  However, running the build process on your local machine allows you to experiment without putting bad images on Docker Hub.
* All 32-bit Docker images must be produced locally.  (After the build process is completed, you will be prompted on whether or not you wish to push the new image to Docker Hub.)  Docker Hub's automated build system is designed for 64-bit images and does not fully support 32-bit images.  For example, it was unable to install Ruby 2.5.0 in a 32-bit image.
