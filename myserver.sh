# 拉取配置仓库
git clone https://github.com/musdrop/musdrop_confs.git ~/musdrop_confs
# 进入仓库目录
cd ~/musdrop_confs
# 运行 nps
docker run -d --name=nps --restart=always -p 8001:8080 -p 8002:80 -p 8003:443 -p 8004:8024 -v ./nps:/conf musdrop/nps:v2
# 安装 nginx
apt install nginx
# 建立符号链接
rm -rf /etc/nginx/conf.d
ln -s ./nginx /etc/nginx/conf.d 
# 启动 nginx
service nginx start