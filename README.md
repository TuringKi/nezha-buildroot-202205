# 从头构建d1-h上的软件环境～～

```bash
#启动一个ubuntu 18.04 环境：
docker run -it -v `pwd`:/work/ ubuntu:18.04

apt-get install mtools dosfstools libpixman-1-dev libglib2.0-dev ninja-build

#clone平头哥编译器源码：
git clone --recursive https://github.com/T-head-Semi/xuantie-gnu-toolchain

cd xuantie-gnu-toolchain
#第一趟编译，使用默认的linux-header：
./configure --prefix=`pwd`/.build/install/  \
--with-arch=rv64imafdcv_zfh_xtheadc  --with-abi=lp64d

cd ..

#clone d1-linux源码：
git clone https://github.com/TuringKi/d1-linux

cd d1-linux

#用第一趟编译好的riscv64工具链在指定的linux内核上编译出linux-header：
PATH=/work/xuantie-gnu-toolchain/.build/install/bin/:$PATH \
make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-  \
headers_install INSTALL_HDR_PATH=`pwd`/.build/install/usr -j8

cd ../xuantie-gnu-toolchain

#第二趟编译，使用指定内核的linux-header版本：
./configure --prefix=`pwd`/.build/install/  \
--with-linux-headers-src=`pwd`/../d1-linux/.build/install/usr/include/ \
--with-arch=rv64imafdcv_zfh_xtheadc  --with-abi=lp64d

make -j8

cd ..

#编译qemu，全志的dragonseboot只提供了x86-64版本。如果我们要在非x86-64上运行，
#就需要模拟器。
wget https://download.qemu.org/qemu-7.2.0.tar.xz && tar xvf qemu-7.2.0.tar.xz

cd qemu-7.2.0

./configure --prefix=/root/usr

make -j8

cd ..

#clone本工程
git clone https://github.com/TuringKi/nezha-buildroot-202205.git

cd nezha-buildroot-202205

cp d1-buildroot.config .config

make -j8

#如果编译成功，会有：
ls output/images/sdcard.img

```

注意，在gcc10.x版本下，vector扩展的march标识为：v0p7 而不是v。