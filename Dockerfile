FROM ruby:2.6.2
RUN mkdir /chat
WORKDIR /chat
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

# Add a script to be executed every time the container starts.


# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]