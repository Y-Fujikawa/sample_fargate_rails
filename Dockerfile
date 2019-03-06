FROM ruby:2.6.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /usr/local/src/sample_fargate_rails
WORKDIR /usr/local/src/sample_fargate_rails
ADD . /usr/local/src/sample_fargate_rails
ADD Gemfile /usr/local/src/sample_fargate_rails/Gemfile
ADD Gemfile.lock /usr/local/src/sample_fargate_rails/Gemfile.lock
RUN bundle install --jobs=4
CMD ["bundle", "exec", "puma", "-C", "config/puma/production.rb", "-d"]