#!/bin/bash

set -e

gpg -d $1 > ../secret.tgz
tar  -xzvf ../secret.tgz  -C ..
rm ../secret.tgz
