# Base Stage
#FROM ruby:3.2.2 as base
FROM ubuntu:jammy as base

RUN apt-get update --fix-missing
RUN apt-get -y install curl

# install rvm to quickly change native ruby path
# this list of packages is misbehaving during the rvm installer
RUN /bin/bash -c "curl -sSL https://get.rvm.io | bash -s stable"
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && rvm install 3.2.2"

# we will forward gtk to host system, some deps:
RUN apt-get install -y libgtk-3-0 libgtk-3-dev
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && rvm use 3.2.2 --default && gem install gtk3 curses bundler:2.4.6"
# for profanity
#RUN gem install curses
# bundler version for lich-5
#RUN gem install bundler -v 2.4.6

# stage 2, currently stages are removed
WORKDIR /app
COPY lich-5/Gemfile lich-5/Gemfile.lock lich-5/
# by the way --path is apparently deprecated
#RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && rvm use 3.2.2 --default && cd lich-5 && bundle install --path /usr/local/bundle"
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && rvm use 3.2.2 --default && cd lich-5 && bundle install"

# stage 3, currently stages are removed
#COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY profanityfe profanityfe
COPY lich-5 lich-5
RUN mkdir -p /app/lich-5/data
COPY profanityfe-docker/entrypoint.sh entrypoint.sh
COPY profanityfe-docker/lichlauncher.sh lichlauncher.sh
COPY profanityfe-docker/login.sh login.sh
COPY profanityfe-docker/debug.sh debug.sh
RUN mkdir -p /root/.profanity
COPY profanityfe/mahtra.xml /root/.profanity.xml

#ENV TERM ansi
#ENV TERM linux
ENV TERM xterm-256color
ENV BUNDLE_PATH=/usr/local/bundle
