FROM jllopis/ruby:2.1.1
MAINTAINER Joan Llopis <jllopisg@gmail.com>

ENV RAILS_VERSION 4.0.0

# Rails app home dir
ENV RAILS_APP_ROOT /opt/app

#RUN apt-get -qqy install apache2-mpm-prefork --no-install-recommends
RUN apt-get -qqy install libsqlite3-dev

# Install Rails
# but first, rails needs a Javascript runtime...
RUN add-apt-repository -y ppa:chris-lea/node.js && \
    apt-get -qq update && \
    apt-get -qqy install nodejs
RUN gem install rails --no-ri --no-rdoc -v $RAILS_VERSION

# Install Passenger
# RUN . /usr/local/rvm/scripts/rvm && gem install --no-ri --no-rdoc passenger -v 4.0.37 && passenger-install-apache2-module --auto

ENTRYPOINT ["/usr/local/bin/run.sh"]

# app/ directory should contain the application to be inltalled
ONBUILD ADD app/ /opt/app
ONBUILD RUN cd /opt/app && bundle install
ONBUILD ADD run.sh /usr/local/bin/run.sh
ONBUILD RUN chmod +x /usr/local/bin/run.sh

# To build from this image, you must provide in the same directory of this Dockerfile the following:
# - app/ directory which contains your rails application (ex: git clone git@gitorious.server.com:observer.git app)
# - run.sh which is a shell script that will run on container start and thus will run your app and its dependencies
#
# You should also EXPOSE the ports needed
