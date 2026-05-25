FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o tracker .

FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/tracker .

# Приложение не слушает HTTP-порты, поэтому EXPOSE не нужен
# Оставлено на будущее, если добавите сервер:
# EXPOSE 8080

CMD ["./tracker"]
