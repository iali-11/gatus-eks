FROM golang:alpine3.24 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -o gatus .

# Stage 2: Runtime Stage

FROM scratch AS runtime

WORKDIR /app

COPY --from=builder /app/gatus ./gatus
COPY --from=builder /app/config.yaml ./config.yaml

ENV GATUS_CONFIG_PATH=./config.yaml

EXPOSE 8080

ENTRYPOINT [ "./gatus" ]