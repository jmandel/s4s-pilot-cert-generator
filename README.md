# Self-Contained S4S Pilot Stack

A self-contained deployment of the tools needed for testing S4S Pilot sites.
The stack includes two S4S apps: our demo research app and test suite.
Everything runs on a dedicated PC where secrets can be guarded.

## Architecture

The two apps are configured to run at:
 * `https://demo-app.pilot-prep.syncfor.science`
 * `https://test-suite.pilot-prep.syncfor.science`

— but these domains have no public DNS records. This configuration ensures the
apps can only be accessed from a machine:

1. Running pilot stack installed locally
2. Pilot app hostnames and SSL certificates configured locally
3. OAuth secrets and test account credentials available locally

**From the perspective of an S4S-enabled EHR, these looks like normal apps.**

For security purposes, this configuration allows us to conduct tests from a
self-contained environment without relying on third-party hosting.  Secrets are
never exposed to a cloud environment. By installing this stack on an encrypted
laptop, we can conduct tests from anywhere, including from behind a hospital's
firewall in circumstances where this may be required.

The stack includes:

 * nginx (proxy) bound to the local PC's loopback device
 * app servers running on a host-internal network, proxied by nginx
 * support services also running on the host-internal network:
   * FHIR API server for resource validation
   * research app API server for S4S synchronization

## Run the stack

To conduct S4S pilot site tests, launch the stack via:

```shell
docker-compose up
```

Then open a web browser to: https://demo-app.pilot-prep.syncfor.science and
https://test-suite.pilot-prep.syncfor.science

## Setup

First, add the two apps to `/etc/hosts`:

    127.0.0.1   localhost demo-app.pilot-prep.syncfor.science test-suite.pilot-prep.syncfor.science

##### Create directories; get code & images

Note: before this step you must obtain (out of band!) `secret.tgz.gpg` and a
suitable decryption key or passphrase.

These instructions create a directory structure where an `s4s` directory
contains:

 * `secret`
 * `pilot-prep`.

Sensitive configuration settings are stored one level above the git-controlled
`pilot-prep` directory.  Within `pilot-prep`, symbolic links point to
sensitive configuration settings at `../secret`.


```shell
mkdir s4s
cd s4s

git clone http://github.com/sync-for-science/pilot-prep
cd pilot-prep
docker-compose pull

# This creates the `../secret` directory for sensitive configuration settings
./tools/secret-import.sh /path/to/secret.tgz.gpg
```

##### Generate SSL certificates (if needed)

Your `secrets.tgz.gpg` file should contain ready-to-go SSL certificates. If you
need to regenerate SSL certificates, you must create
`~/Private/rackspace/environment` like:

```
export OS_API_KEY=your-key
export OS_USERNAME=your-username
```

Then you can regenerate certificates via:


```shell
./tools/generate-certs.sh
```
