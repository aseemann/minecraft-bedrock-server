#!/bin/bash

set -e

if [ ! -z "${@}"]; then
  ${@}
fi

echo "Determine latest minecraft server version from website"

curl 'https://www.minecraft.net/en-us/download/server/bedrock' \
  -H 'authority: www.minecraft.net' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: de,de-DE;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6' \
  -H 'dnt: 1' \
  -H 'referer: https://www.bing.com/' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="100", "Microsoft Edge";v="100"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 Edg/100.0.1185.50' \
  --compressed --silent | grep linux | grep -v preview > /tmp/mcbrs

DownloadLink=$(sed -r 's/(.*)(https.*zip)(.*)/\2/' /tmp/mcbrs)

VERSION=$(echo "${DownloadLink}" | sed -r 's/^(.*\-)([0-9\.]+)(\.zip)$/\2/')

echo "Download and start minecraft bedrock-server in version $VERSION"

curl -X GET -o bedrock-server.zip  --progress-bar https://minecraft.azureedge.net/bin-linux/bedrock-server-$VERSION.zip
chmod +x bedrock-server.zip
unzip -qn bedrock-server.zip
rm bedrock-server.zip
find -type f -exec chmod +x {} \;


export LD_LIBRARY_PATH="/mojang/bedrock/server"

/mojang/bedrock/server/bedrock_server
