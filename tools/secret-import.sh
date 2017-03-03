#!/bin/bash

set -e

gpg --output ../secret.tgz ${1:-~/Dropbox/S4S/secret.tgz.gpg}
tar  -xzvf ../secret.tgz  -C ..
rm ../secret.tgz
