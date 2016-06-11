FROM ruby:2.3.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    # For assets compilation
    nodejs \
    # Capybara-webkit deps
    dbus-1-dbg \
    libqt5webkit5-dev \
    qt5-default \
    xvfb \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && dbus-uuidgen > /etc/machine-id

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

CMD bundle exec rails s -b0.0.0.0
