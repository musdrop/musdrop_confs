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

# 运行 nps
docker run -d --name=nps --restart=always \
  -p 8001:8080 -p 8002:80 -p 8003:443 -p 8004:8024 \
  -v $(pwd)/nps:/conf musdrop/nps:v3 || { echo "运行nps失败"; exit 1; }

echo "服务器初始化完成！"
