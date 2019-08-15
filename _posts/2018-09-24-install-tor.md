---
layout: post
title:  "Installing TOR Service"
date:   2018-09-24 14:20:00 -0500
# categories: jekyll update
---

<!-- 
todo:
https://wiki.debian.org/TorBrowser#Introduction
http://web.archive.org/web/20180909171127/https://www.torproject.org/docs/debian.html.en
http://www.privoxy.org/faq/misc.html#TOR
-->

In Ubuntu, you can install both the [TOR service](https://www.torproject.org/docs/debian.html.en) and the [TOR Browser (launcher)](https://wiki.debian.org/TorBrowser#Introduction).  The launcher script is a simpler way to install the browser with all the updates.

```bash
sudo apt-get install tor torbrowser-launcher
```

Since we are hosting a Blog, we can mirror it on TOR

```
   HiddenServiceDir /var/lib/tor/hidden_service/
   HiddenServicePort 80 127.0.0.1:80
```

Once done and restarted, Tor will serve the content that is being served up by `lighttpd`.  To find your onion address, enter the following:

```bash
sudo cat /var/lib/tor/hidden_service/hostname
```

Going a bit further... TOR works by setting up a SOCKS proxy that process your requests.  Since some apps offer less support for SOCKS proxies, a compromise is to [use `privoxy`](http://www.privoxy.org/faq/misc.html#TOR) as an HTTP proxy that then forwards requests to the TOR SOCKS proxy.

```
sudo apt-get install privoxy
sudo vi /etc/privoxy/config # uncomment the following
   forward-socks5t            /     127.0.0.1:9050 .
   forward         192.168.*.*/     .
   forward            10.*.*.*/     .
   forward           127.*.*.*/     .
   forward           localhost/     .
```

As a quick test to see if it's working, you can try the following with various browsers.  Good onions would be the one harvested from the `hostname` file above, or the TorProject's offical onion of [expyuzz4wqqyqhjn.onion](http://expyuzz4wqqyqhjn.onion/)
```bash
# Pick the browser you want...
# browser="seamonkey"
# browser="dillo"
browser="lynx"
http_proxy="http://127.0.0.1:8118" \
 no_proxy="127.0.0.1" \
 $browser \
 http://{some_onion}
```

Keep in mind, beyond the quick test, you really do want to use the TorBrowser for better anonymity and security.
<!--
todo
https://trac.torproject.org/projects/tor/wiki/TorRelayGuide#BackupTorIdentityKeys
-->