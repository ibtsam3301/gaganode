#!/bin/bash

cpu_arch="$(uname -m)"
echo "cpu_arch=$cpu_arch"
AMD="https://assets.coreservice.io/public/package/66/gaganode_pro/0.0.300/gaganode_pro-0_0_300.tar.gz"
ARM="https://assets.coreservice.io/public/package/68/gaganode_pro/0.0.300/gaganode_pro-0_0_300.tar.gz"

if [ "${cpu_arch}" = "x86_64" ]; then
DOWNLOADLINK=$AMD
FILENAME="app-linux-amd64.tar.gz"
elif [[ "${cpu_arch}" = "arm64" ]] || [[ "${cpu_arch}" = "aarch64" ]]; then
DOWNLOADLINK=$ARM
FILENAME="app-linux-arm64.tar.gz"
else
echo "Your CPU type dose not support" 
exit 1
fi

echo "DOWNLOADLINK=$DOWNLOADLINK"

if [ -d ./apphub-linux* ]; then
echo "apphub-linux found" &&
cd ./apphub-linux* &&
./apphub service start &&
./apphub status &&
./apphub log &&
./apps/gaganode/gaganode log &&
cat ./apps/gaganode/user_conf/default.toml
else
echo "apphub-linux NOT found."
curl -o $FILENAME $DOWNLOADLINK &&
tar -zxf $FILENAME &&
rm -f $FILENAME &&
cd ./apphub-linux* &&
./apphub service remove &&
./apphub service install
./apphub service start
./apphub status &&
sleep 30 && echo ' ____   ___  _   _ _____
|  _ \ / _ \| \ | | ____|
| | | | | | |  \| |  _|
| |_| | |_| | |\  | |___
|____/ \___/|_| \_|_____|'
./apphub status && 
./apps/gaganode/gaganode config set --token=$TOKEN &&
./apphub restart &&
./apps/gaganode/gaganode log
fi

/bin/bash
