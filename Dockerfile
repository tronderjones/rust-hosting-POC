FROM rust:stable
FROM alpine:latest

COPY --from=0 /app/ /app/

CMD ["/app/handler"]