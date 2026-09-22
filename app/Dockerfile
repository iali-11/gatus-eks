# Stage 1: Build Stage

FROM golang:alpine3.24 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -o gatus .

RUN addgroup -S nonrootgroup && \
    adduser -S nonrootuser -G nonrootgroup

# Stage 2: Runtime Stage

FROM scratch AS runtime

WORKDIR /app

COPY --from=builder /app/gatus ./gatus
COPY --from=builder /app/config.yaml ./config.yaml
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

ENV GATUS_CONFIG_PATH=./config.yaml

EXPOSE 8080

ENTRYPOINT [ "./gatus" ]