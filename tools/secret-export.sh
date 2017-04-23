#!/bin/bash

set -e
tar -czvf ../secret.tgz ../secret
gpg --encrypt -r pilot-prep@syncfor.science ../secret.tgz
rm ../secret.tgz
mv ../secret.tgz.gpg ~/Dropbox/S4S/
echo "Created ~/Dropbox/S4S/secret.tgz.gpg"
