FROM ruby:2.6.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /usr/local/src/sample_fargate_rails
WORKDIR /usr/local/src/sample_fargate_rails
ADD . /usr/local/src/sample_fargate_rails
ADD Gemfile /usr/local/src/sample_fargate_rails/Gemfile
ADD Gemfile.lock /usr/local/src/sample_fargate_rails/Gemfile.lock
RUN bundle install --jobs=4
RUN curl -o ecs-cli.asc https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest.asc
CMD sh -c 'rm -f tmp/pids/server.pid && bundle exec rails s -e production -p 80 -b 0.0.0.0'
#CMD bundle exec puma -C config/puma/production.rb -d