docker build . -t certs-from-rackspace
source  ~/Private/rackspace/environment
docker run --rm -it \
  -e DOMAINS="pilot-secure-demo-app.syncfor.science pilot-secure-test-suite.syncfor.science" \
  -e USERNAME="$OS_USERNAME" -e API_KEY="$OS_API_KEY" \
  -v $(readlink -f certs):/dehydrated/certs \
  certs-from-rackspace

sudo chown -R $USER.$USER certs

