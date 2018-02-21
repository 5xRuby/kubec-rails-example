FROM ruby:2.4.3

ENV RAILS_ENV production
ENV APP_HOME  /usr/src/app
ENV LC_ALL    C.UTF-8
ENV TZ        Asia/Taipei

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile      $APP_HOME
ADD Gemfile.lock $APP_HOME

RUN bundle install --deployment

ADD . $APP_HOME

RUN rake assets:precompile

EXPOSE 3000

CMD rake db:migrate && rails s

