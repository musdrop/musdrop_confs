docker run \
    -d \
    --name=frp \
    --restart=always \
    --net=host
    -v $(pwd)/frp/frps.toml:/etc/frps.toml \
    musdrop/frp:v1