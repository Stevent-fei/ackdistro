#!/usr/bin/env bash

set -x;set -e

if ! which sealer;then
    echo "sealer not found, please download latest sealer"
    exit 1
fi

TAG=$1

if [[ "$TAG" == "" ]];then
    echo "Usage: bash build.sh TAG"
    exit 1
fi

bins=(helm kubectl kubelet kubeadm trident)
for bin in ${bins[@]};do
    wget https://acs-ecp.oss-cn-hangzhou.aliyuncs.com/ack-distro/bin/amd64/${bin} -O ${bin}
done

# Build sealer image
sealer build -f test-Kubefile -t ack-distro:${TAG} .