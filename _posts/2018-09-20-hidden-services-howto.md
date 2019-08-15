---
layout: post
title:  "Hidden Services HowTo"
date:   2018-09-20 14:17:00 -0500
# categories: jekyll update
---

I'll begin by laying out the basics of setting up a VM, a web-server and some hidden services.  I'll likely do this in a few posts, possibly over a few days, so check back often.

If you want to host a web-page there are a few options available to you.  One of the most obvious is to use something like [foursquare]( https://www.squarespace.com/) or some other site-builder.  Although this is a simple enough solution there are a few drawbacks.  Primary among these is the fact that you do not have the ability to do anything but what the provider (foursquare) offers.  If you wanted to "draw outside the lines" you may quickly find yourself up against some restriction.

On the other-hand, self-hosting your content gives you all the flexibility you need as well as giving you the freedom to post opinions that your provider may disagree with.  I'll give a (very) rough outline of what the steps to do this are, then we will drill into each individual step later.

## Clearnet Setup

The first few steps will be to make content available on the clearnet.  This will make your information available on the normal internet using the normal tools.  You may choose to only host on the clearnet, or only host on the darknet.  For this experiment I'm hosting on both.

#### Create a VM

Hosting a website on anything other than a dedicated web-server is probably not a good idea.  Especially if you open the site up to the web at large.  So in an attempt to find a cheep service, I choose [**Google Compute Engine**]( https://cloud.google.com/compute/).  If you are using the `f1-micro` preemptible image, you can usually stay pretty close to the [always free]( https://cloud.google.com/free/docs/always-free-usage-limits) usage limits.  I tend to run a few things on GCE, but my bills are usually only a dollar or two every other month or so.  If you end up with a site that you want 24x7 up-time there are likely some plans from [discount providers]( http://www.servermom.org/low-end-cloud-server-providers/) at around $5 / mo.

* [Creating A GCE VM]({{ site.baseurl }}{% post_url 2018-09-21-create-gce-vm %}) - Setting up `f1-micro` GCE instances.

Alternatively you could use something like a raspberry pi which you could spin up for $50 or less, but it's up to you.

#### Generating a Site

There are multiple options of site builders to choose from.  I choose [**Jekyll**]( https://jekyllrb.com/) because it is included in [Github Pages]( https://pages.github.com/), and seems the simplest of the most popular solutions.  This also allows you to mirror your self-hosted website onto Github hosted site through their github-pages feature.  This provides a nice five-nine uptime site for clearnet use.

* [Creating A Jekyll Site]({{ site.baseurl }}{% post_url 2018-09-21-create-jekyll-site %}) - A more detailed Jekyll walk through.

#### Choose a Web-server

Originally I glossed over this piece, but shortly after hosting I noticed some really weird intrusion probing on my site and decided to rebuild from scratch.  Opinions on which server software to run will vary wildly, but I'm going to try [**`lighttpd`**]( https://www.lighttpd.net/) for the task.  Key take away is that it has to have a small footprint and seems to be secure enough that our VM doesn't get overrun.

* [Installing Lighttpd Service]({{ site.baseurl }}{% post_url 2018-09-22-install-lighttpd %}) - How to install Lighttpd server.

#### Choose a DynDNS

This allows us to pick a site-name and dynamically update the IP address as our instance moves.  I know there are a few services out there, but I happened upon [**`noip`**]( https://www.noip.com/) and have been pretty happy with it.  It gives me three records.  I use one for the Github hosted page, one for my self-hosted page, and I have not yet figured out what to do with the third.

* [Installing NoIP Service]({{ site.baseurl }}{% post_url 2018-09-22-install-noip %}) - How to install noip as a service.

DynDNS services are also useful for hosting on a raspberry pi, since your home ISP will cycle IPs regularly. 

#### Configure Up-time Monitor

If you are using the GCE and choose a preemtible instance to lower costs, you will likely want an up-time monitor to determine when your instance preempts.  I was pleased to see that GCE integrates Stackdriver to allow you to recieve notifications when you are preempted.  You can even restart your instances via the [Android]( https://play.google.com/store/apps/details?id=com.google.android.apps.cloudconsole) or [iOS]( https://itunes.apple.com/us/app/google-cloud-console/id1005120814/iTunes?mt=8) GCE mobile app.

* [Configure GCE Up-time Monitor]( https://cloud.google.com/monitoring/quickstart-lamp) - Step by step guide with Stackdriver.

## Darknet Setup

At this point your clearnet site should be up and running.  If you only want to host on the darknet, you can stop your web-server and dyndns client since they are only used for clearnet hosting.

The darknet services will run something similar to a web-server, but for vary specific networks.  I choose to run what looked like the three <!-- four after installing zeronet --> most popular [darknet]( https://en.wikipedia.org/wiki/Darknet#Active) services.  Much beyond this would start to make my poor `f1-micro` VM sweat.

#### I2P

I set up [**I2P**]( https://geti2p.net/) though Tor is more popular.  There are many [comparisons]( https://www.makeuseof.com/tag/i2p-vs-tor-vs-vpn-secure/) of I2P and Tor if your interested.  The basic difference I see is that I2P is peer-to-peer.  All browsers are also relays (if their ports are open).  This is similar to how bitcoin or bittorrent networks work.  Tor on the other hand seems to have separate "participants" and "maintainers" or relays.  If your using Debian, a [pre-packaged]( https://geti2p.net/el/download/debian) I2P installer is available.  Once installed, it is polite to open the I2P ports so that your node can contribute to the network.  Keep in mind that this will count against your VM's bandwidth quota, so it is something you will want to keep an eye on.

* [Installing I2P Service]({{ site.baseurl }}{% post_url 2018-09-23-install-i2p %}) - How to install the I2P service.

#### Tor

By far the most popular darknet protocol, [**Tor**]( https://www.torproject.org/) has an integrated and hardened browser as well as the tor service / proxy.  I deviated about from the normal install instructions and did everything through `apt`

* [Installing Tor Service/Browser]({{ site.baseurl }}{% post_url 2018-09-24-install-tor %}) - How to install the TOR service and browser.

#### Freenet

Of all the hidden services, I found [**Freenet**]( https://freenetproject.org/) to be the most interesting.  One of the coolest things about freenet is that the content (if popular) will stay on the network even if the site / server that created the content goes down.  Once content is on freenet it is mirrored and shared by all the nodes and propagated.

Installation on the VM was a little weird for freenet.  Since I was trying to run as close to headless as possible, my JVM was throwing up some errors.  Luckily simply [disabling accessibility]( https://askubuntu.com/questions/695560/assistive-technology-not-found-awterror) features seemed to do the trick.

* [Installing Freenet / Upload Freesite]({{ site.baseurl }}{% post_url 2018-09-24-install-freenet %}) - Install Freenet and upload Freesite.

## All Done

At this point you should have your site mirrored on two clearnet services and 3 darknet services.  Obviously this is way overkill for a simple blog, but I demonstrate it simply to show how it can be done.

<!--
TODO: 

### Install WoTNS and gain enough reputation for a WoTNS name
1. https://github.com/Bombe/WoTNS

### Node or python script to smartly archive.
1. build to _site or www-data dir
2. for each file in _site, wget ghp://file
3. harvest ETag from header
4. If ETag is unknown, archive URL to wbm, and record ETag as known

### Try Zeronet
1. it claims not to be resource heavy, so give it a shot.
2. consider stopping noip, tor, i2p and freenet while running it

### Try installing Namecoin
1. Expand root partition to have enough room for blockchain
2. Install NMControl or the dynmns or whatever

### Create protocol handlers
1. see http://kb.mozillazine.org/Register_protocol
2. freenet:key
3. zeronet:key

### Test script
1. Script that takes service and browser
2. Store to status file based on chron

### Add backup howto
1. Make a crypt loopback
2. Save keys to crypt loopback

### Add self-proxy
1. http://dwblog.ddns.net/{freenetkey}

### Add crawlers
1. https://www.xml-sitemaps.com/
2. wget -r -l1 --delete-after -D localhost http://localhost:4000 2>&1 | findstr "^--2018" | findstr "\/$ html$"
3. wget -r -l1 --delete-after -D localhost "http://localhost:8888${key}" 2>&1 | egrep "^--2018" | egrep "/$|.html$" | grep "$key" | awk '{print $3}'
3. wget http://www.google.com/ping?sitemap=https://example.com/sitemap.xml
4. sitemap/dwghp.xml, sitemap/dwblog.xml, sitemap/onion.ws.xml, sitemap/onion.sh.xml, sitemap/onion.link.xml, sitemap/i2p.xyz

### Add GPG

### Add v3 onion
1. https://tor.stackexchange.com/questions/17378/what-is-up-with-these-longer-onion-addresses
2. `HiddenServiceVersion 3`

### IPFS
1. https://medium.com/@merunasgrincalaitis/how-to-host-your-ipfs-files-online-forever-f0c56b9b5398
2. https://swarm-guide.readthedocs.io/en/latest/
3. https://filecoin.io/blog/update-2018-q1-q2/
4. https://filecoin.io/blog/update-2018-q1-q2/
5. https://ethereum.stackexchange.com/questions/13804/what-are-storj-and-sia-and-how-different-are-they-from-swarm-and-ipfs

### Reverse Proxy
1. https://bluishcoder.co.nz/2015/09/14/using-freenet-for-static-websites.html
2. https://redmine.lighttpd.net/projects/lighttpd/wiki/InstallFromSource (need 1.4.46)
3. make --dry-run install
-->