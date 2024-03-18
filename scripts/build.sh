#!/bin/bash

ROOT=$(pwd)
QUARTZ=$ROOT/quartz
echo "ROOT: $ROOT"
echo "QUARTZ: $QUARTZ"

if [ -d "quartz" ]; then
    cd $QUARTZ
    git pull
else
    cd $ROOT
    git clone https://github.com/jackyzha0/quartz.git
fi

# copy notes to quartz
rm -rf quartz/content
mkdir quartz/content
cp -r notes/* quartz/content

# modify quartz config 
node ./replaceQuartzConfig.cjs

cd quartz
npm i 
npx quartz build