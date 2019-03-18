FROM ruby:2.6.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# yarnパッケージ管理ツールインストール
RUN apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install nodejs
RUN mkdir /usr/local/src/sample_fargate_rails
WORKDIR /usr/local/src/sample_fargate_rails
ADD . /usr/local/src/sample_fargate_rails
ADD Gemfile /usr/local/src/sample_fargate_rails/Gemfile
ADD Gemfile.lock /usr/local/src/sample_fargate_rails/Gemfile.lock
RUN bundle install --jobs=4
CMD sh -c 'rm -f tmp/pids/server.pid && bundle exec rails s -e production -p 80 -b 0.0.0.0'