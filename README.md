# docker-rails

# Version

Rails 4.1.7

# Build from repository

(https://github.com/jllopis/docker-rails)

````bash

$ git clone git@github.com:jllopis/docker-rails.git
$ cd docker-rails
$ docker build t my_user/rails:latest
````

# Start

This image is intended to be used as base image for Ruby+Rails based application containers.

It comes with Rails installed as well as some dependencies.

It does not define a **CMD** but **it defines** a default **ENTRYPOINT** which is a script *ADDED* from the Dockerfile directory.

If you want to start the image you can do

   $ docker run -t -i --entrypoint /bin/bash rails:4.1.7 -l

# How to use it

To build from it, you need in the same directory of this Dockerfile the following:

- **.** directory which contains your rails application (ex: git clone git@gitorious.server.com:observer.git && cd observer). This directory will be added to
           the image in **/opt/app**
- **run.sh** which is a shell script that will run on container start and thus will run your app and its dependencies.

Also, you should also EXPOSE the ports needed or specify them when the **docker run** command.

A minimal **run.sh** script:

    #!/usr/bin/env bash
    # By: Joan Llopis <jllopis@acb.es>
    
    cd $RAILS_APP_ROOT
    bundle install
    
    echo "Starting app..."
    rails s

