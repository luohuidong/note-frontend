#!/bin/bash

ROOT=$(pwd)
QUARTZ=$ROOT/quartz
echo "ROOT: $ROOT"
echo "QUARTZ: $QUARTZ"

echo "cloning quartz"
rm -rf quartz
git clone --depth 1 https://github.com/jackyzha0/quartz.git

echo "copy notes to quartz"
rm -rf quartz/content
mkdir quartz/content
cp -r notes/* quartz/content

echo "modify quartz config"
node ./replaceQuartzConfig.cjs

cd $QUARTZ

echo "installing dependencies and building quartz"
npm i 
npx quartz build