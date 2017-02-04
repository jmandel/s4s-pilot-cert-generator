docker build ./tools/generate-certs -t certs-from-rackspace
source  ~/Private/rackspace/environment
docker run --rm -it \
  -e DOMAINS="demo-app.pilot-prep.syncfor.science test-suite.pilot-prep.syncfor.science" \
  -e USERNAME="$OS_USERNAME" -e API_KEY="$OS_API_KEY" \
  -v $(readlink -f config/proxy/certs):/dehydrated/certs \
  certs-from-rackspace

sudo chown -R $USER.$USER config/proxy/certs
