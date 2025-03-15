# hmatch, a functional cross-compiled c++ project

## Overview

This CI/CD Pipeline exercise uses gitOps to build and test a hmatch executable compiled for linux-gnu with c++/g++ for x86_65 and aarch64 (arm64) systems.

The resulting binaries are auto-tested with Docker and .deb packages for each architecture are created with autoversioning iaw Debian package naming policy §3.2.1.

hmatch can be called in the format `hmatch <csv_path> <filename>`, given:

csv_path: a pre-filled csv with the format "/absolute/path/to/file,<Expectedsha256sum>"

filename: the file to be inspected for integrity pre or mid flight.

This utility can be used to test for lineup, build deviants/devations, corrupted or even compromised systems.  In a Linux env, entire read-only paritions can be checked, too with shell command `sha256sum /dev/mmcblk0p9`, or likewise for `/dev/nvme0n1p9`, `/dev/sda9`, etc., where the output string can be catalogued and committed to the hashes.csv file.

Later versions can pass signals to the system to initiate emergency action based on the severity of the issue, especially in conjuction with a blacklist (wip).  Blacklist functionality can be extended to identifying .deb packages via release file's sha, making lineup review a single action.

## Building the application

hmatch's ./build.sh can be run to invoke all the cmake and cpack functions.  This will create cross-compiled executables which are subsequently propogated by existing code and integrations.

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

code flow: errors(no csv, fnf, bad hash match) | sucess(blessed hash match)

(supports local testing on docker, or native x86 and arm64 Linux systems)

