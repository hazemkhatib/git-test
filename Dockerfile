FROM alpine:latest
RUN apk add --no-cache bash
CMD ["echo", "Hello from Project 1 Container!"]
