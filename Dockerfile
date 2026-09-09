FROM golang:alpine3.24 

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -o gatus .

ENV GATUS_CONFIG_PATH=./config.yaml

EXPOSE 8080

ENTRYPOINT [ "./gatus" ]