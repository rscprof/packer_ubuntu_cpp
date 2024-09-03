#!/bin/sh
docker build -t subiquity  .
docker run -v .:/http subiquity bash -c "cd /subiquity;python3 ./scripts/validate-autoinstall-user-data.py /http/user-data"
