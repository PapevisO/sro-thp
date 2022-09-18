FROM ruby:2.7.4-buster

# By default image is built using RAILS_ENV=production.
# You may want to customize it:
#
#   --build-arg RAILS_ENV=development
#
# See https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables-build-arg
#
ARG RAILS_ENV=production
ARG UID=1000
ARG GID=1000

ENV NODE_VERSION 10.15.3

# Devise requires secret key to be set during image build or it raises an error
# preventing from running any scripts.
# Users should override this variable by passing environment variable on container start.
ENV RAILS_ENV=${RAILS_ENV} \
    APP_HOME=/home/app

ENV TZ=UTC

# Create group "app" and user "app".
RUN groupadd -r --gid ${GID} app \
    && useradd --system --create-home --home ${APP_HOME} --shell /sbin/nologin --no-log-init \
    --gid ${GID} --uid ${UID} app

WORKDIR $APP_HOME

# Install dependencies defined in Gemfile.
RUN mkdir -p /opt/vendor/bundle \
  && gem install bundler:2.1.4 \
  && chown -R app:app /opt/vendor $APP_HOME

USER app

RUN bundle config set path '/opt/vendor/bundle' \
  && bundle install --jobs $(nproc); exit 0

USER root

RUN apt-get update
RUN apt-get install --only-upgrade openssl
RUN sed -i 's/\#*CipherString = DEFAULT@.*$/CipherString = DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

RUN chown app:app -R /usr/local/bundle

USER app

# Install dependencies
RUN gem update bundler

RUN bundle install --jobs=$(nproc) --system --binstubs --without development test; exit 0

COPY --chown=app:app Gemfile Gemfile.lock $APP_HOME/
RUN bundle install --jobs=$(nproc) --system --binstubs --without development test

# Copy the main application.
COPY --chown=app:app . $APP_HOME

# Initialize application configuration & assets.
RUN bundle exec rake tmp:create

COPY --from=node:10.15.3-stretch --chown=${UID}:${GID} /usr/local /usr/local
COPY --from=node:10.15.3-stretch --chown=${UID}:${GID} /opt /opt

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
