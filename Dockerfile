FROM ruby:alpine3.13
RUN apk add -U --no-cache bash g++ git less make mysql-dev nodejs openssh-client openssl tzdata yarn     
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN ls
RUN bundle install
VOLUME .:/myapp
RUN ls
RUN bundle exec rails db:create 
RUN bundle exec rails db:migrate
EXPOSE 3000
RUN ls
# Start the main process.
CMD ["rails", "server","-b", "0.0.0.0"]
RUN yarn install
