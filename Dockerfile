# base is alias here
FROM golang:1.22.5 as base   

WORKDIR  /app

COPY go.mod .

RUN go mod download

# copy source code(everything) on to the Dockerimage.
COPY . . 

# this will run on /app directory & artifact/binary : main will be created in the Docker
RUN go build -o mian .

# Final stage - Distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]



