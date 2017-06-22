#!/bin/bash
command -v gitbook >/dev/null 2>&1 || { npm install -g gitbook-cli; }
rm -rf _book
gitbook build