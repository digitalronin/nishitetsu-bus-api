FROM ruby:3.1.2-alpine

ARG APPUSER=appuser

RUN apk add \
  bash \
  gettext \
  tzdata \
  jq \
  make

RUN cp /usr/share/zoneinfo/Japan /etc/localtime

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

RUN adduser -D $APPUSER
USER $APPUSER
