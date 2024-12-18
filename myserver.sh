#!/bin/bash

# 更新软件包列表
apt-get update || { echo "更新软件包列表失败"; }

# 安装必要的软件包
apt install -y git --fix-missing || { echo "安装git失败"; exit 1; }
apt install -y docker.io --fix-missing || { echo "安装docker失败"; exit 1; }

# 拉取配置仓库
git clone https://github.com/musdrop/musdrop_confs.git ~/musdrop_confs || { echo "拉取配置仓库失败"; exit 1; }

# 进入仓库目录
cd ~/musdrop_confs || { echo "进入仓库目录失败"; exit 1; }

# 运行nginx
docker run -d --name=nginx --network=host --restart=always -v $(pwd)/nginx:/etc/nginx/conf.d nginx:stable-perl || { echo "运行nps失败"; exit 1; }

#运行frp
docker run \
    -d \
    --name=frp \
    --restart=always \
    -p 8001:7000 \
    -v $(pwd)/frp/frps.ini:/etc/frps.ini \
    gists/frp || { echo "运行frp失败"; exit 1; }



echo "服务器初始化完成！"
