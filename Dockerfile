# Use the latest Rust stable release as base image
FROM rust:1.77.2

# Switch the working directory to 'app'
WORKDIR /app
# Install the required system dependencies for linking configuration
RUN apt update && apt install lld clang -y
# Copy all the files from the working environment to the Docker image
COPY . .
# Make sqlx look at saved metadata instead of querying a live database
ENV SQLX_OFFLINE true
# Build binary
RUN cargo build --release
# Use the production environment
ENV APP_ENVIRONMENT production
# When 'docker run' is executed, run the binary
ENTRYPOINT ["./target/release/newsletter"]
