#!/bin/bash

# 更改默认 LAN 地址为 10.0.0.1
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改默认源地址为上海交大源
if [ -f package/emortal/default-settings/files/99-default-settings-chinese ]; then
  sed -i "s,mirrors.vsean.net/openwrt,mirrors.sjtug.sjtu.edu.cn/immortalwrt,g" package/emortal/default-settings/files/99-default-settings-chinese
fi

# 适配 v24.10.6 的 nftables/firewall4 构建，保留可用的界面和证书补丁。
if [ -d "$GITHUB_WORKSPACE/openwrt/package/emortal/autocore/files/generic" ]; then
  cp -rf "$GITHUB_WORKSPACE/patchs/21_ethinfo.js" "$GITHUB_WORKSPACE/openwrt/package/emortal/autocore/files/generic/21_ethinfo.js"
fi

if [ -f "$GITHUB_WORKSPACE/openwrt/package/system/ca-certificates/Makefile" ]; then
  cp -rf "$GITHUB_WORKSPACE/patchs/ca-Makefile" "$GITHUB_WORKSPACE/openwrt/package/system/ca-certificates/Makefile"
fi
