FROM ruby:2.4.3

ENV RAILS_ENV production
ENV APP_HOME  /usr/src/app
ENV LC_ALL    C.UTF-8
ENV TZ        Asia/Taipei
ENV NODE_VERSION 8.0.0

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile      $APP_HOME
ADD Gemfile.lock $APP_HOME

RUN bundle install --deployment

ADD . $APP_HOME

RUN curl -SLO https://nodejs.org/dist/v$NODE_VERSION/node-v${NODE_VERSION}-linux-x64.tar.xz && tar -xJf node-v${NODE_VERSION}-linux-x64.tar.xz -C /usr/local --strip-components=1
RUN rake assets:precompile

EXPOSE 3000

CMD rake db:migrate && rails s

