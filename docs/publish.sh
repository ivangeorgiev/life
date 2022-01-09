#! /bin/bash

ORIG_DIR=$(pwd)
DOCS_DIR=`dirname "$0" | xargs realpath`
STAGE_DIR="$ORIG_DIR/_build/publish"
BUILD_DIR="$ORIG_DIR/_build/html"
echo "Current directory is: $ORIG_DIR"
echo "Docs directory is: $DOCS_DIR"
echo "HTML build directory is: $BUILD_DIR"
echo "Stage directory is: $STAGE_DIR"

echo "Activate virtual environment..."
source $DOCS_DIR/../.venv/Scripts/activate

echo "Build HTML..."
cd $DOCS_DIR
make html

echo "Setup stage directory..."
mkdir -p $STAGE_DIR
rm -rf $STAGE_DIR
mkdir -p $STAGE_DIR

echo "Clone repository..."
git clone https://github.com/ivangeorgiev/life $STAGE_DIR

cd $STAGE_DIR
git checkout gh-pages

echo "Copy build files to staging directory..."
cp -vr $BUILD_DIR/* $STAGE_DIR/.
git add .
git commit -m "build by script"
echo "Publish..."
git push
cd $ORIG_DIR
echo "Cleanup..."
rm -rf $STAGE_DIR


exit 0

echo "Setup stage directory..."
ORIG_DIR=$(pwd)
STAGE_DIR="$ORIG_DIR/_build/publish"
BUILD_DIR="$ORIG_DIR/_build/html"
echo "Current directory is $ORIG_DIR"
echo "Stage directory is $STAGE_DIR"
mkdir -p $STAGE_DIR
rm -rf $STAGE_DIR
mkdir -p $STAGE_DIR

git clone https://github.com/ivangeorgiev/life $STAGE_DIR
cd $STAGE_DIR
echo "Copy build files to staging directory..."
git checkout gh-pages
cp -vr $BUILD_DIR/* $STAGE_DIR/.
git add .
git commit -m "build by script"
echo "Publish..."
git push
cd $ORIG_DIR
echo "Cleanup..."
rm -rf $STAGE_DIR

