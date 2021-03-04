#!/bin/bash

grpc_1_36_0_githash=736e3758351ced3cd842bad3ba4e2540f01bbc48

function build_grpc () {
  git clone https://github.com/grpc/grpc.git google/grpc
  cd google/grpc
  git checkout ${grpc_1_36_0_githash}
  git submodule update --init
  cmake . -DCMAKE_INSTALL_PREFIX=`pwd`/install
  make
  make install
  if [ ! -f ${GRPC_INSTALL_PATH}/lib/libgrpc++_unsecure.so.1 ]; then
    ln -s ${GRPC_INSTALL_PATH}/lib/libgrpc++_unsecure.so.6 ${GRPC_INSTALL_PATH}/lib/libgrpc++_unsecure.so.1
  fi
  cd ../..
}

GRPC_INSTALL_PATH=`pwd`/google/grpc/install
PROTOBUF_DOWNLOAD_PATH=`pwd`/google/grpc/third_party/protobuf

build_grpc
