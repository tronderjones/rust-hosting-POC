FROM mcr.microsoft.com/azure-functions/dotnet:3.0-appservice 
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

FROM rust:1.69


RUN rustup target add x86_64-unknown-linux-musl

COPY . /home/site/wwwroot

RUN RUST_LOG=trace cargo build -v --release --target x86_64-unknown-linux-musl
 
CMD ["./target/x86_64-unknown-linux-musl/release/handler"]