---
layout: post
title:  "Installing Lighttpd Service"
date:   2018-09-22 12:00:00 -0500
# categories: jekyll update
---

Since `lighttpd` is a maintained package for Unbuntu, all we have to do is follow the Ubuntu [install instructions](https://help.ubuntu.com/community/lighttpd).
```bash
sudo apt-get install lighttpd
```

#### Security

Once installed, you may want to tighten security a bit.
```bash
cd ~
vi .profile
# change umask to 027 and save
umask 027 # to apply to current session
```

#### Sitebuild Script

Now we can create a build script for our site.  Go to the directory your Jekyll code is in and create `sitebuild.sh` containing
```bash
#!/bin/bash
docroot="/var/www/html"
sudo -- sh -c "umask 0027; bundle exec jekyll build -d $docroot"
sudo chown -R root:www-data $docroot
sudo chmod -R o-rwx,g-w $docroot
```

Hopefully this will ensure that none of your site files have any lingering read attributes that they should not.

Finally, you will want to edit your `_config.yml` and add the following to the end (or at least uncomment some)
```
exclude:
  - sitebuild.sh
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor/bundle/
  - vendor/cache/
  - vendor/gems/
  - vendor/ruby/
```

Now we can build our site and test it
```bash
chmod u+x sitebuild.sh
./sitebuild.sh
lynx localhost
```

If your happy with the content, then we can commit the changes to github
```bash
git add -A
git commit -m "automated our site build"
git push
```

#### Sweeten config

To turn on an access log, you will want to enable the module and the configuration option in `/etc/lighttpd/lighttpd.conf`
```
server.modules = (
        ...
        "mod_accesslog",
        ...
)

accesslog.filename          = "/var/log/lighttpd/access.log"
```

To enable our Jekyll 404 message, add the following...
```
server.error-handler-404    = "/404.html"
```

Since we are running on a **very** small instance, I made the following changes to reduce the server load
```
server.max-request-size     = 65536
server.max-write-idle       = 30
server.max-read-idle        = 10
server.max-connections      = 32
server.max-fds              = 64

```

#### Open firewall

Finally if your satisfied with your content, you can open up port 80 on your GCE vm to start serving the site with the [following `gcloud` command](https://cloud.google.com/vpc/docs/add-remove-network-tags#adding_and_removing_tags)

```bash
gcloud config set compute/zone {zone}
gcloud compute instances add-tags {vm-name} --tags "http-server"
```

#### Further tasks

Some other tasks you may want done.

1. Get an SSL cert
2. Roll out your SSL cert and [move site to port 443](https://redmine.lighttpd.net/projects/1/wiki/HowToRedirectHttpToHttps)
3. Build latest version of lighttpd
4. Setup reverse proxy to serve up other services through lighttpd.

<!-- 
todo: 
spell out HW
do 
   '/freesite_key' -> 127.0.0.1:8888/freesite_key
   '/ZeroNet_key' -> 127.0.0.1:????/ZeroNet_key
-->
