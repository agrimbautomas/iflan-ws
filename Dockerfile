FROM ruby:2.7.1
WORKDIR /usr/src/iflan-ws

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ADD Gemfile /usr/src/iflan-ws/Gemfile
ADD Gemfile.lock /usr/src/iflan-ws/Gemfile.lock
RUN bundle install
COPY . /usr/src/iflan-ws
EXPOSE 3000
CMD [ "bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0" ]
