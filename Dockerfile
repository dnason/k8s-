FROM golang:1.24.2 AS builder

WORKDIR /

COPY /app/main.go ./app/ 
COPY html/ ./html/

RUN go build -o ./app/server ./app/main.go

FROM debian:bookworm-slim

WORKDIR /

COPY --from=builder /app/server /app/server
COPY --from=builder /html ./html

EXPOSE 8080

CMD ["./app/server"]