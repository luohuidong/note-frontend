#!/bin/bash

ROOT=$(pwd)
QUARTZ=$ROOT/quartz
echo "ROOT: $ROOT"
echo "QUARTZ: $QUARTZ"

if [ -d "quartz" ]; then
    rm -rf quartz
fi

rm -rf quartz/content
mkdir quartz/content
git clone https://github.com/jackyzha0/quartz.git
node ./replaceQuartzConfig.cjs
cp -r notes/* quartz/content
cd quartz
npm i 
npx quartz build