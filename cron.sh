#!/bin/sh
set -u

export PATH=$PATH:/root/go/bin

cd /opt/my-fast-cf-ip/
echo "shell working with $(pwd)"

if ![ command -v go > /dev/null 2>&1 ] ; then
    echo "install golang"
    echo "e.g. sudo apt-get install golang"
    exit 1
fi

if ![ command -v CloudflareSpeedTest > /dev/null 2>&1 ] ; then
    echo "install CloudflareSpeedTest"
    echo "e.g. go install \"github.com/yangxikun/CloudflareSpeedTest\""
    exit 1
fi

if ![ command -v git > /dev/null 2>&1 ] ; then

    echo "install git"
    echo "e.g. sudo apt-get install git"
fi

CloudflareSpeedTest -dd -tll 20 -tl 200 -o "result.csv"
head -n21 result.csv | tail -n20 | awk -F, '{print $1}' > fastips.txt
git commit -m "update fastips.txt at $(date -R)" fastips.txt
git push origin master

echo "all done well!!"

