#!/bin/bash
command -v gitbook >/dev/null 2>&1 || { npm install -g gitbook-cli; gitbook install; }
rm -rf _book
gitbook build
cp -r _book/ .
rm -rf _book/
