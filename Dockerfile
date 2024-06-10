# Gunakan image dasar Alpine
FROM ruby:3.3.0-alpine

# Install dependencies yang diperlukan
RUN apk update && \
    apk add --no-cache \
    build-base \
    tzdata \
    nodejs \
    yarn \
    git \
    bash \
    curl

# Install bundler
RUN gem install bundler

# Atur direktori kerja
WORKDIR /app

# Salin file Gemfile dan Gemfile.lock ke dalam direktori kerja
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Salin seluruh kode aplikasi ke dalam direktori kerja
COPY . .

# Precompile assets untuk production
RUN RAILS_ENV=production SECRET_KEY_BASE=$(rake secret) bundle exec rake assets:precompile

# Expose port yang digunakan oleh aplikasi Rails (misalnya port 3000)
EXPOSE 3000

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Command untuk menjalankan server puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
