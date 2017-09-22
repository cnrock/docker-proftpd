## Dockerized ProFTP with LDAP config*

* *LDAP not included*

**Why**: Using LDAP as an authentication backend is pretty nifty, but a royal PITA to setup. I struggled getting the right options to get this thing to work. This is the working setup.

**What**: The default configuration will restrict all users (anon, system + LDAP) to READONLY in their respective home directories. Users will be CHROOT'd to their home directories. This allows for the best base to build upon.

**HOW**: You can build the image and use it as is by modifying the supplied `proftpd.conf` file, *OR* you can create another file, call it `local-proftpd.conf` and run this image with `docker-compose` and it will load your config at runtime. This will probably give you the best flexibility, and you can run an ldap server with the same compose file.

## Run

`docker run --rm --name proftpd -p 21:21 -p 60000:60009 -v $(pwd)/ftp-data:/srv/ftpusers  ipetepete/docker-proftpd`

Tack on the `-d` option to run as a daemon. You can mount your own config file in `/etc/proftpd.conf` and add another volume for the anonymous' directories with `-v $(pwd)/anon-data:/srv/ftp`

`docker-compose up`

**Use my ldap container for a simple starting point with this ftp image: [docker-ldap](https://github.com/ipetepete/docker-ldap)**

--------

## Warning!!!

To get this image working properly accross a network, you should run it with the `--net=host` option. Security, firewalls etc are left to you, I am not liable for loss of data, life or limb.

A word of warning if you are running this image (or any FTP image) on MacOs. Docker for Mac doesn't have a propper passthrough for `--net=host` which is required for PASV mode. I discovered this the hard way.
