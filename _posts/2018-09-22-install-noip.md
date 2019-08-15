---
layout: post
title:  "Installing NoIP Service"
date:   2018-09-22 12:01:00 -0500
# categories: jekyll update
---

Installing the NoIP Client will allow your system to update your DNS entry with your assigned IP on each boot.  Simply follow the [install instructions](https://www.noip.com/support/knowledgebase/installing-the-linux-dynamic-update-client/) on the NoIP website.  The basic procedure is:

#### Create a NoIP Account

* Go to the [NoIP website](https://www.noip.com/) and create an account
* Check your email for the verification and click the link.
* Log out / Log in again and create a userid
* Create a DynDNS entry

#### Download / Setup Client

```bash
sudo apt-get update
sudo apt-get install make gcc g++ zlib1g-dev
sudo bash
cd /usr/local/src/
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xf noip-duc-linux.tar.gz
cd noip-2.1.9-1/
make install
# answer the questions
noip2
exit # exit sudo
```

#### Configure NoIP service

Now the client is setup, but you still need to set it up as a service.  Someone created a gist for this purpose.

First ensure that if NoIP is running, we terminate it.
```bash
sudo noip2 -S
# copy the process number from the output
sudo noip2 -K {process_num} # use the process number from above
```

Next install the service, enable it, and start it.
```bash
cd ~/src
repo=https://gist.github.com/NathanGiesbrecht/da6560f21e55178bcea7fdd9ca2e39b5
git clone $repo noip.svc
cd ~/src/noip.svc
sudo cp noip2.service /etc/systemd/system
sudo systemctl enable noip2
sudo systemctl start noip2
sudo systemctl status noip2
```

#### Further tasks

* Setup Github Pages with NoIP
* Monitor for renewal emails every month