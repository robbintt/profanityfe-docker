# Base Stage
FROM ruby:3.2.2 as base
# we will forward gtk to host system, some deps:
RUN apt-get update && apt-get install -y libgtk-3-0 libgtk-3-dev
RUN gem install gtk3
# for profanity
RUN gem install curses
# bundler version for lich-5
RUN gem install bundler -v 2.4.6

# this needs to run from ~/code on the build host
FROM base as builder
WORKDIR /app
COPY lich-5/Gemfile lich-5/Gemfile.lock lich-5/
RUN cd lich-5 && bundle install

# this needs to run from ~/code on the build host
FROM base
WORKDIR /app
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY profanityfe profanityfe
COPY lich-5 lich-5
RUN mkdir -p /app/lich-5/data
COPY profanityfe-docker/entrypoint.sh entrypoint.sh
COPY profanityfe-docker/login.sh login.sh
RUN mkdir -p /root/.profanity
COPY profanityfe/mahtra.xml /root/.profanity.xml

ENV TERM linux #ansi
