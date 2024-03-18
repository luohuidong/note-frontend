#!/bin/bash

ROOT=$(pwd)
QUARTZ=$ROOT/quartz
echo "ROOT: $ROOT"
echo "QUARTZ: $QUARTZ"

if [ -d "quartz" ]; then
    echo "quartz exists"
    cd $QUARTZ
    git pull
else
    echo "cloning quartz"
    cd $ROOT
    git clone --depth 1 https://github.com/jackyzha0/quartz.git
fi

cd $ROOT

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