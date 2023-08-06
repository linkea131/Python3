#!/bin/bash
# by baiyu 2021 攻城狮白玉
#-----可变参数-start-----
# 要下载的python版本
# python的大版本号
py_version=3.9
# python的具体版本号
version=$py_version.9
# 要安装的路径
install_path=/usr/local/src/python38
#-----可变参数-end-----

echo -e '即将安装python$version'
echo -e '安装路径为$install_path'

# 安装依赖以及升级索引
sudo apt install -y build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
sudo apt update
sudo apt upgrade -y

# 创建安装目录文件夹
sudo mkdir -p $install_path

# 下载python
echo -e '正在下载'
# 使用官方网址下载--速度可能比较慢
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
# 使用国内华为镜像源下载python
# wget https://mirrors.huaweicloud.com/python/$version/Python-$version.tgz
echo -e "正在解压"
# 静默解压
tar -xzf Python-$version.tgz
# 删除压缩包
echo -e "解压完成，移除压缩包"
rm -rf Python-$version.tgz

echo -e "正在安装"
cd Python-$version
./configure --prefix=$install_path  # 配置安装位置
sudo make
sudo make install

echo -e "配置软连接"
rm -rf /usr/bin/python$py_version /usr/bin/pip$py_version
sudo ln -s $install_path/bin/python$py_version /usr/bin/python$py_version
sudo ln -s $install_path/bin/pip$py_version /usr/bin/pip$py_version

cd ..
sudo rm -rf Python-$version
echo -e "完成安装Python-$version
