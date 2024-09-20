ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Install packages needed to build gems
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  build-essential libpq-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Layer 2. Creating environment variables which used further in Dockerfile.
ENV APP_HOME /backend

# Layer 3. Adding config options for bundler.
RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc

# Layer 4. Creating and specifying the directory in which the application will be placed.
WORKDIR $APP_HOME

# Layer 5. Copying Gemfile and Gemfile.lock.
COPY dev-docker-entrypoint.sh ./
COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install --jobs 20 --retry 5
COPY . .

RUN chmod +x ./dev-docker-entrypoint.sh

# Layer 9. Run migrations
ENTRYPOINT ["./dev-docker-entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
