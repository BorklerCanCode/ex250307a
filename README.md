# goose, a payload simulator implemented as a cross-compiled c++ project

## Overview

This CI/CD Pipeline exercise uses gitOps to build and test an executable compiled for linux-gnu with c++/g++ for x86_65 and aarch64 (arm64) systems.

The resulting binaries are auto-tested with Docker and .deb packages for each architecture are created with autoversioning iaw Debian package naming policy §3.2.1.

Later versions will have error injection, which could pass signals to the system to initiate emergency action based on the severity of the issue.



## Building the application

this repo's ./build.sh can be run to invoke all the cmake and cpack functions.  This will create cross-compiled executables which are subsequently propogated by existing code and integrations.

### unit tests

unit tests are integrated directly and the results are observable at local/Docker/Repo level.

### Docker

Docker files are integrated in the repo.

As with any docker prokect, be mindful of the .dockerignore file and its function/contents.

### Other: kubernetes

kubernetes cluster details tbd

## .deb package details

### installation

The .deb can be fetched with wget `hmatch-aarch64-stable-Linux.deb`, then installed with:

tbd wget example (from aws-s3?)

<code>sudo dpkg -i `ls -t hash*.deb | head -1`</code>

The .deb can be removed with:

<code>sudo apt remove hmatch*</code>

## Architectural components and diagram:

locations: repository (github) [pushes to->] package repo (tbd) [<-pulls from] targetArchs

actions: tbd-github-actions | tbd-notifications (github)

code flow:
<code>
The Checker object implements a function for right and left payloads, as
check.left(payload=true,sensor=true) and check.right(payload=true,sensor=true) 
or 
check.left(payload=false,sensor=false) and check.right(payload=false,sensor=false) 
payload loaded and ready for launch? left
1*1=1
payload loaded and ready for launch? right
1*1=1
payload fired and no longer detectd? left
0*0=0
payload fired and no longer detectd? left
0*0=0
...simulated failures of hard mount points in future version
</code>


(supports local testing on docker, or native x86 and arm64 Linux systems)


