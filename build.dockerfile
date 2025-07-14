FROM 11notes/go:1.24
RUN set -ex; \
  git clone https://github.com/some/repo; \
  cd ./repo; \
  go build -ldflags="-extldflags=-static" -o repo main.go;