

FROM ubuntu:latest

ENV TARGET=x86_64-unknown-linux-musl
ENV BUILD_DIR=/src/target/x86_64-unknown-linux-musl/release/

RUN apt-get update && \
    apt-get install \
        musl-tools \
        curl \
        gcc \
        -y

RUN curl https://sh.rustup.rs -sSf -o /tmp/rustup-init.sh
RUN sh /tmp/rustup-init.sh -y

RUN ~/.cargo/bin/rustup target add ${TARGET}

ONBUILD COPY . /src
ONBUILD WORKDIR /src

ONBUILD RUN ~/.cargo/bin/cargo test --release --target=${TARGET}
ONBUILD RUN ~/.cargo/bin/cargo build --release --target=${TARGET}

# Build artifacts will be available in /app.
RUN mkdir /app
# Copy the "interesting" files into /app.
ONBUILD RUN find ${BUILD_DIR} \
                -regextype egrep \
                # The interesting binaries are all directly in ${BUILD_DIR}.
                -maxdepth 1 \
                # Well, binaries are executable.
                -executable \
                # Well, binaries are files.
                -type f \
                # Filter out tests.
                ! -regex ".*\-[a-fA-F0-9]{16,16}$" \
                # Copy the matching files into /app.
                -exec cp {} /app \;

ONBUILD RUN echo "The following files will be copied to the runtime image: $(ls /app)"