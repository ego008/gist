#
# Install nghttp2 on CentOS 6
#

# Install zlib
sudo yum install zlib-devel

# Use g++ 4.8 toolchain
source ~/enable-devtoolset-2.sh


mkdir dependency && cd dependency

# Install CMake 3.1
# wget https://cmake.org/files/v3.1/cmake-3.1.0-Linux-x86_64.tar.gz
wget ftp://192.168.0.102/Development/C++/cmake-3.1.0-Linux-x86_64.tar.gz
tar -xzvf cmake-3.1.0-Linux-x86_64.tar.gz 
sudo cp -r cmake-3.1.0-Linux-x86_64/* /usr/local/
rm -rf cmake-3.1.0-Linux-x86_64
rm -f cmake-3.1.0-Linux-x86_64.tar.gz 

# Install openssl 1.1.0b
# wget https://www.openssl.org/source/openssl-1.1.0b.tar.gz
wget ftp://192.168.0.102/Development/SourceCode/openssl-1.1.0b.tar.gz
tar -xzvf openssl-1.1.0b.tar.gz
cd openssl-1.1.0b
./config --prefix=/usr && make && sudo make install
cd ..
rm -rf openssl-1.1.0b
rm -f openssl-1.1.0b.tar.gz


# Install boost 1.62
# wget https://sourceforge.net/projects/boost/files/boost/1.62.0/boost_1_62_0.tar.gz
wget ftp://192.168.0.102/Development/SourceCode/boost_1_62_0.tar.gz
tar -xzvf boost_1_62_0.tar.gz 
cd boost_1_62_0 &&
sh bootstrap.sh && ./bjam && sudo ./bjam install 
cd ..
rm -rf boost_1_62_0
rm -f boost_1_62_0.tar.gz


# Install CUnit 2.1.3
# wget https://sourceforge.net/projects/cunit/files/latest/download
wget ftp://192.168.0.102/Development/SourceCode/CUnit-2.1-3.tar.bz2
tar -jxvf CUnit-2.1-3.tar.bz2 
cd CUnit-2.1-3
autoreconf -f -i -Wall && ./configure && make && sudo make install
cd ..
rm -rf CUnit-2.1-3
rm -f CUnit-2.1-3.tar.bz2


# Install libev 4.22
# wget http://dist.schmorp.de/libev/libev-4.22.tar.gz
wget ftp://192.168.0.102/Development/SourceCode/libev-4.22.tar.gz
cd libev-4.22
./configure && make && sudo make install
cd ..
rm -rf libev-4.22
rm -f libev-4.22.tar.gz


# Install nghttp2 1.16
# wget https://github.com/nghttp2/nghttp2/releases/download/v1.16.0/nghttp2-1.16.0.tar.gz
wget ftp://192.168.0.102/Development/SourceCode/nghttp2-1.16.0.tar.gz
tar -xzvf nghttp2-1.16.0.tar.gz
cd nghttp2-1.16.0 && mkdir build && cd build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release .. && make && sudo make install
cd ..
rm -rf nghttp2-1.16.0
rm -f nghttp2-1.16.0.tar.gz


# flush ld config
sudo ldconfig

