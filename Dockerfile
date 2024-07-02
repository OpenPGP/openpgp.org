FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ruby bundler ruby-dev
RUN mkdir /site
WORKDIR /site

# Fix locales: https://github.com/jekyll/jekyll/issues/4268
# Install program to configure locales
RUN apt-get install -y locales
RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

COPY Gemfile /site
RUN bundle config set --local path 'vendor/bundle' && bundle install && bundle add webrick

COPY assets/* /site/assets/
COPY images/* /site/images/
COPY _* /site
CMD ["/usr/bin/bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]
