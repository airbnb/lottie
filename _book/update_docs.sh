#!/bin/bash
command -v gitbook >/dev/null 2>&1 || { npm install -g gitbook-cli; }
rm -rf _book
gitbook build
cd _book
git init
git commit --allow-empty -m 'update book'
git fetch git@github.com:airbnb/lottoe.git gh-pages
git checkout -b gh-pages
git add .
git commit -am 'update book'
git push git@github.com:airbnb/lottie.git gh-pages --force