#!/bin/bash

set -e

tar -czvf ../secret.tgz ../secret
gpg -c ../secret.tgz
rm ../secret.tgz
