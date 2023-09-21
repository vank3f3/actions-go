FROM golang:alpine AS build

WORKDIR /app
ENV GO111MODULE=on

# 添加项目路径
ADD . .


RUN go mod download && go mod tidy

RUN  go build -v  -o app /app

# 第二阶段,小镜像
FROM alpine AS prod

WORKDIR /app

# 复制二进制到镜像
COPY --from=build /app/app /app/

# 入口命令
ENTRYPOINT ["/app/app"]


