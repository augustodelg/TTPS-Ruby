FROM ruby:alpine3.13
RUN apk add -U --no-cache bash g++ git less make mysql-dev nodejs openssh-client openssl tzdata yarn     
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY package.json /myapp/package.json
COPY package-lock.json /myapp/package-lock.json
COPY yarn.lock /myapp/yarn.lock
RUN bundle install
RUN yarn install
VOLUME .:/myapp
RUN bundle exec rails db:create 
RUN bundle exec rails db:migrate
EXPOSE 3000
# Start the main process.
CMD ["rails", "server","-b", "0.0.0.0"]

