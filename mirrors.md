---
layout: page
title: Mirrors
permalink: /mirrors/
---

Since the purpose of this blog was to show how to create a website and mirror it on various hidden services, below is a list of mirrors of the current blog that have been compiled.

#### Github Pages Instance

This page is hosted by github and is part of the repo we originally created.  This does require that the the NoIP.com be set up to point to your github pages instance

* [dwghp.ddns.net]( https://dwghp.ddns.net/) - Live
* [dwghp.ddns.net]( https://web.archive.org/web/2/https://dwghp.ddns.net/) - Web-Archive
* [dwghp.ddns.net]( https://webcache.googleusercontent.com/search?q=cache:https://dwghp.ddns.net/) - Google Cache

#### GCE VM Instance

This is the Live instance hosted in our VM.

* [dwblog.ddns.net]( http://dwblog.ddns.net/) - Live
* [dwblog.ddns.net]( https://web.archive.org/web/2/http://dwblog.ddns.net/) - Web-Archive
* [dwblog.ddns.net]( https://www.google.com/search?q=site:dwblog.ddns.net+inurl:dwblog.ddns.net) - Google Cache

#### Mnemonic Redirects

Since most of the Hidden have hashes as names, It is convenient to have these mnemonic redirects.  For example, to get the hash for the onion v2 service simply navigate to `/onion.v2/` and you will get redirected to `/bithxedusrw236ji.onion/` so you now have the full onion hash.

* [/onion.v2]( /onion.v2/) - Onion v2
* [/onion.v3]( /onion.v3/) - Onion v3
* [/i2p.short]( /i2p.short/) - I2P Short Form Name
* [/i2p.long]( /i2p.long/) - I2P Long Form Name
* [/freenet]( /freenet/) - Freenet

#### Expanded Reverse Proxies

While on clearnet, it is usefull to be able to verify if the hidden services are still functioning.  For this we use some reverse proxy settings in lighttpd.  Now we can simply bracket our hidden services address in slashes (`/`) and determine if its up based on if it resolves. 

* [/dwblog.i2p]( /dwblog.i2p/) - I2P Short Address
* [/bithxedusrw236ji.onion]( /bithxedusrw236ji.onion/) - Onion v2 Address
* [/USK@UHw2...AQACAAE/dwblog/4/]( /USK@UHw2~SAEv7EAmfhb4SO6EVLWRo6NHbKUte-BJ72isCg,v6y94~qHCRvfKdM-90dxC2rHSvykgyEYoZLp45a26NU,AQACAAE/dwblog/4/) - Freenet Address
* [/lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p]( /lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p/) - I2P Long Address
* [/zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion]( /zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion/) - Onion v3 Address

#### Onion v2 Instance

These are the instances that reference the Onion (version 2) hidden service hosted on my VM.  If the VM goes down, the live onions will go down.  The archives and google cache will survive.

* [bithxedusrw236ji.onion]( http://bithxedusrw236ji.onion/) - Live onion (requires Tor)
* [bithxedusrw236ji.onion]( https://web.archive.org/web/2/http://dwblog.ddns.net/onion.v2/) - Onion v2 Mnemonic Web-Archive
* [bithxedusrw236ji.onion]( https://web.archive.org/web/2/http://dwblog.ddns.net/bithxedusrw236ji.onion/) - Onion v2 Reverse Proxy Web-Archive
* [bithxedusrw236ji.onion]( https://www.google.com/search?q=bithxedusrw236ji+OR+inurl:bithxedusrw236ji) - Google Cache

##### **Onion.ws Inproxy**

The [Onion.ws](http://onion.ws/) Tor2Web inproxy will bridge traffic from clearnet to Tor.  If either the onion.ws server or my VM goes down, then the live link won't be available.  The archive links will survive.

* [bithxedusrw236ji.onion.ws]( http://bithxedusrw236ji.onion.ws/) - Onion.ws Live (clearnet)
* [bithxedusrw236ji.onion.ws]( https://web.archive.org/web/2/http://bithxedusrw236ji.onion.ws/) - Onion.ws Web-Archive

##### **Onion.link Inproxy**

The [Onion.link](http://onion.link/) Tor2Web inproxy will bridge traffic from clearnet to Tor.  If either the onion.link server or my VM goes down, then the live link won't be available.  The archive links will survive.

* [bithxedusrw236ji.onion.link]( http://bithxedusrw236ji.onion.link/) - Onion.link Live (clearnet)
* [bithxedusrw236ji.onion.link]( https://web.archive.org/web/2/http://bithxedusrw236ji.onion.link/) - Onion.link Web-Archive

##### **Onion.sh Inproxy**

The [Onion.sh](https://onion.sh/) Tor2Web inproxy will bridge traffic from clearnet to Tor.  If either the onion.sh server or my VM goes down, then the link won't be available.  Be aware that this inproxy uses SNI TLS which some browsers do not support.

* [bithxedusrw236ji.onion.sh]( https://bithxedusrw236ji.onion.sh/) - Onion.sh Inproxy

#### Onion v3 Instance

These are the instances that reference the Onion (version 3) hidden service hosted on my VM.  If the VM goes down, the live onions will go down.  The archives and google cache will survive.

* [zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion]( http://zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion/) - Live onion (requires Tor)
* [zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion]( https://web.archive.org/web/2/http://dwblog.ddns.net/onion.v3/) - v3 Mnemonic Web-Arch
* [zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion]( https://web.archive.org/web/2/http://dwblog.ddns.net/zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion/) - v3 Rev-Proxy Web-Arch
* [zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion]( https://www.google.com/search?q=zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd+OR+inurl:zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd) - Google Cache

##### **Onion.ws Inproxy**

The [Onion.ws](http://onion.ws/) Tor2Web inproxy will bridge traffic from clearnet to Tor.  If either the onion.ws server or my VM goes down, then the live link won't be available.  The archive links will survive.

* [zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion.ws]( http://zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion.ws/) - Onion.ws Inproxy
* [zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion.ws]( https://web.archive.org/web/2/http://zgeajoabenj2nac6k5cei5qy62iu5yun5gm2vjnxy65r3p3amzykwxqd.onion.ws/) - Onion.ws Web-Archive

#### I2P eepsite Instance

These are the instances that reference the I2P (eepsite) hidden service hosted on my VM.  If the VM goes down, the live eepsite will go down.  The archives and google cache will survive.

* [lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p]( http://lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p/) - Live b32 eepsite (requires I2P)
* [lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p]( https://web.archive.org/web/2/http://dwblog.ddns.net/i2p.long/) - I2P b32 Mnemonic Web-Arch
* [lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p]( https://web.archive.org/web/2/http://dwblog.ddns.net/lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p/) - I2P b32 Rev-Proxy Web-Arch
* [lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p]( https://www.google.com/search?q=lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma+OR+inurl:lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma) - Google Cache

##### **I2P.xyz Inproxy**

The [I2P.xyz](http://i2p.xyz/) I2P Inproxy (Russian) will bridge traffic from clearnet to I2P.  If either the i2p.xyz server or my VM goes down, then the live link won't be available.  The archive links will survive.

* [lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p.xyz]( http://lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p.xyz/) - I2P.xyz Inproxy
* [lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p.xyz]( https://web.archive.org/web/2/http://lggg5usmc5jrle6pxjb7zysnorlp6djzu7ne36geigbcigwfugma.b32.i2p.xyz/) - I2P.xyz Web-Archive

##### **I2P Short Form**

These are the instances that reference the I2P (eepsite) short form hidden service hosted on my VM.  The short form requires a type of I2P dns service.  If the I2P dns service or the VM goes down, the live eepsite will go down.  The archive links will survive.

* [dwblog.i2p]( http://dwblog.i2p/) - Live Short Form eepsite (requires I2P)
* [dwblog.i2p]( https://web.archive.org/web/2/http://dwblog.ddns.net/i2p.short/) - I2P Short Mnemonic Web-Archive
* [dwblog.i2p]( https://web.archive.org/web/2/http://dwblog.ddns.net/dwblog.i2p/) - I2P Short Reverse Proxy Web-Archive

#### Freenet Instance

These are the instances that reference the Freenet (freesite) site.  Freesites are distributed across the network as soon as they are inserted.  The freesite will persist even if my VM goes down, so long as it is routinely accessed by someone.  Sites that fall into disuse are eventually garbage collected.

* [USK@UHw2...AQACAAE/dwblog/#/]( http://127.0.0.1:8888{{ site.freeurl }}/) - Live Freenet (requires freenet software)
* [USK@UHw2...AQACAAE/dwblog/#/]( https://web.archive.org/web/2/http://dwblog.ddns.net/freenet/) - Freenet Mnemonic Web-Archive
* [USK@UHw2...AQACAAE/dwblog/#/]( https://web.archive.org/web/2/http://dwblog.ddns.net{{ site.freeurl }}/) - Freenet Reverse Proxy Web-Archive
