# Gunakan image Ruby Alpine sebagai base image
FROM ruby:alpine

# Install dependencies
RUN apk update && \
    apk add --no-cache \
      build-base \
      nodejs \
      yarn \
      tzdata

# Set working directory
WORKDIR /app

# Copy Gemfile dan Gemfile.lock ke dalam image
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install --binstubs

# Copy seluruh kode ke dalam image
COPY . .

# Expose port 3000 untuk server
EXPOSE 3000

# Command untuk menjalankan server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
