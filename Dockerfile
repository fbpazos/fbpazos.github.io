FROM ruby:3.2-slim

# Install system packages required for compiling native gem extensions & running Jekyll
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Install gems into the image
COPY Gemfile Gemfile.lock* ./
RUN bundle config set --local force_ruby_platform false \
    && bundle install

# Expose Jekyll server port and LiveReload port
EXPOSE 4000 35729

# Start Jekyll server with live reloading and polling enabled for file change detection
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--livereload", "--force_polling"]
