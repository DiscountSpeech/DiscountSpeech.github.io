---
layout: post
title:  "Deplatform Risks"
date:   2018-09-20 11:30:00 -0500
hidden: true
# categories: jekyll update
---

<pre>
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

</pre>

## TLDR

Consider mirroring sites to a darkweb services such as Tor, I2P or Freenet to reduce de-platforming risk.  Might consider self-hosting crypto POS services to further decentralize funding.  This would leave the primary exposures simply at the hosting services / ISP.  This exposure is unavoidable unless hosting on a service such as Freenet.

# Deplatform Risks to GlennBeck.com / TheBlaze.com

After an interesting series of shows around 9-14-2018, and 9-19-2018 the question of de-platforming various media groups came to mind.  On a few occasions it was suggested that "self-hosting" would be a way to mitigate that risk by removing the dependency on platforms such as Youtube and Twitter.  Later (9-19) Jason Buttrill did suggest hosting content on a darkweb service, which I also suggest.  Below I will outline a very minimal list of risks that are still exposed while self-hosting on clearnet.  If one or more of the companies listed below decide to block a site that is dependent on it, the site could be rendered unreachable and de-facto "de-platformed".  Possible mitigation to this risk would be to use something like I2P, Tor, or Freenet.  An oversimplification of these networks would be a "Bitcoin for Internet".  Since they are decentralized services they would be hard for bad actors to disrupt.  These services will often carry the darker connotation as "Dark Web".  The following companies could deplatform GlennBeck.com and/or TheBlaze.com today with minimal effort:

* Amazon - Since Amazon AWS is uses for hosting
* Oracle - Since dynect.net is used for DNS services
* MarkMonitor Inc. - Used as a domain registrar
* Fastly Inc. - Used for hosting
* GlobalSign Inc. - Used as a SSL CA.
* Visa / MasterCard - Used for subscription payments (only if both jointly deplatformed)

Other companies could hinder traffic, but not necessarily blackout traffic completely.

## Risks

The way web browsers work require traffic to go through a number of different layers before a request from a subscriber will actually reach a server controlled by the media provider (glennbeck.com).  Here is an abridged list:

* **Browser** - This is literally the program subscribers browse your site with.
* **OS hosts file** - FQDN names like "glennbeck.com" will go through the OS to translate to IP addresses.
* **DNS** - If a first level hit in an OS hosts file is not found, the request is sent to an internet "DNS server" to translate.
* **Registrar** - FQDN to IP translations are maintained by a registrar that pays the DNS to maintain your FQDN to IP correlation.
* **Web Proxy** - Once an IP address is acquired, the connection is initiated... if the subscriber is behind a proxy, this is the first hop.
* **Hosting Service** - For reliability, most websites will hire a hosting service to host their content and house their servers.
* **SSL CA** - SSL Certificate Authorities are used to ensure encrypted web traffic comes from an authorized source.
* **CC POS** - Visa / Mastercard transactions are used for membership subscriptions.

If any of the companies responsible for any piece of this stack were to black-list a site, the site would become unreachable.

#### Browser

Browser companies like Chrome (google) and Firefox (mozilla) could potentially decide at some future date to not allow certain "hate-sites" to be browsed.  This is widely done by Chrome and Firefox if they consider a site a "phishing" site or just generally "deceptive".  In mobile platforms the "browser" is the content delivery application, and in many cases this is an "App Store" program.  The mobile stores for Android and Apple regularly deplatform content due to "hate guidelines".

Examples:

1. Firefox [Unsafe Site Protection](https://support.mozilla.org/en-US/kb/how-does-phishing-and-malware-protection-work)
2. Chrome [Unsafe Site Protection](https://support.google.com/chrome/answer/99020?co=GENIE.Platform%3DDesktop&hl=en)
3. Safari [Unsafe Site Protection](https://support.apple.com/guide/safari/security-preferences-ibrw1074/mac)
4. [TheBlaze](https://itunes.apple.com/us/app/theblaze/id414496806?mt=8) @ Apple App Store
5. [TheBlaze](https://play.google.com/store/apps/details?id=com.theblaze&hl=en_US) @ Android Play Store

#### OS Hosts File

One of the low-level hold-overs of the internet protocols is the concept of a "hosts" file.  This is a file provided by the OS that helps turn domain names into IP addresses.  OS providers such as Microsoft or Apple could black-list a site through a "security patch", though no precedence for this has yet been set.  One of the easiest ways for a site to get black-listed in an OS hosts file is through a Anti-virus package.  These software packages routinely maintain a list of "unsafe" sites and render them unreachable through manipulation of the OS hosts file.

Examples:

1. Popular [hosts file filter](https://github.com/StevenBlack/hosts)

#### Web Proxy

Like various "safe-site filters" mentioned earlier, web proxies are a way to keep users from inadvertently going to phishing sites or known "unsafe" domains.  Web proxies are often used at office locations, schools and universities.  Various companies offer web proxy services, and will usually allow the offices, schools or universities to list sites to ban.  Once the proxy bans a site, no one accessing the internet from that office, school or university will be able to access it.

Examples:

1. [Barracuda Web Proxy](https://www.barracuda.com/products/websecuritygateway)

#### DNS

A DNS (Domain Name Server) is like a phone book for the internet.  Each domain name is translated to an IP4/IP6 address.  Similar to the "unsafe site" filters in the OS and in the browsers, DNS providers can also decide which sites to flag.  Once flagged, the DNS provider can simply answer "not-found" to any DNS query involving a flagged site.  If one of the major DNS providers were to flag your site, a large portion of subscribers would be unable to access it.

Examples:

1. OpenDNS [site filtering](https://support.opendns.com/hc/en-us/articles/227987987-Getting-Started-The-protection-and-filtering-provided-by-OpenDNS)

Exposures:

1. Oracle's [dynect.net](https://portal.dynect.net/) serving DNS entries for GlennBeck.com and TheBlaze.com presently.

#### Registrar

A domain registrar is a company that will maintain DNS translation for its customers.  These registrars will provide these listing to various DNS services, and through these, the network of DNS resolutions are derived.  Although customers pay for a registrar to broadcast and maintain its DNS entry, any bad acting registrar could black-list one of its customers should if feel the need to.  It could also refuse to accept future DNS registrations from customers or groups that it deemed "hateful".

Exposures:

1. MarkMonitor Inc. - Domain Registrar for [GlennBeck.com](https://www.whois.com/whois/glennbeck.com) and [TheBlaze.com](https://www.whois.com/whois/theblaze.com)

#### Hosting Service

Hosting services are usually the companies that either house the media servers content is delivered from, or the companies that own the internet backbone that those servers are connected to.  Hosting services or ISPs could arbitrarily decide that a customer (glennbeck.com) is operating outside the terms of their contract and terminate services.  In cases where customers have favorable contracts preventing such denials, the ISP could choose simply to no longer renew a contract or lease forcing the content provider to scramble to secure new hosting services before existing relations expire.

Exposures:

1. [Fastly ISP](https://www.fastly.com/) - Hosting subnet used by TheBlaze.com currently.
2. [Amazon AWS](https://aws.amazon.com/) - Hosting service used by GlennBeck.com currently.

#### SSL CA

SSL certificates handle the authentication and encryption for sensitive site traffic like subscriber passwords and credit-card numbers.  A familiar interface for SSL certificates is the use of the "lock" or green "secure" icon in the browser by the URL.  You will notice these when browsing to theblaze.com or glennbeck.com.  If an SSL CA were to decide to revoke a certificate due to what it deems as "bad behavior", then all site security would be rendered useless.  Furthermore, most browsers will automatically ban sites who have had their certificates revoked.

Exposures

1. [GlobalSign CA](https://www.globalsign.com/en/) - CA used by TheBlaze.com and GlennBeck.com currently.

## Mitigation

Darkweb services offer solutions to all of these exposures.  Jason Buttrill demonstrated a firm grasp of the utility of these services on his 9-19 broadcast of "Pat Gray Unleashed".  Darkweb services will be slower and may require some compromising in site content, but all the the same core site features will still be available.  Pay-wall and subscriber only content is also very viable while hosting darkweb services.  Below I will outline how various darkweb services can protect against various exposures.

#### OS Hosts File

Services such as Tor, and Freenet use (effectively) randomly generated names for sites.  This would make it very unlikely that an OS vendor would pain themselves to discover these random site names only to ban them.  The I2P services does use "readable" hostnames such as glennbeck.i2p, but they use host files in unique locations on disk that most OS vendors or antivirus companies do not filter.

#### Web Proxy

None of the darknet services are susceptible to proxy filtration.  Most of the services use thier own proxy that is independent of anything that may be implemented by a corporate site or university location.

#### DNS

None of the darknet services use the traditional DNS network in use by the clearnet today.  Most name resolution is done peer-to-peer in a way that is analogous to how bitcoin addresses and validations are performed.

#### Registrar

Since the darknet services do not use traditional DNS, they likewise do not use tradition DNS registrars.  There are "seeders" and "relays" that sometimes have a type of centralization to them that could be exploited, but this seems less likely than the risks currently in tradition DNS space.

#### Hosting Service

Some darknet services such as Freenet decentralize hosting as well.  All nodes "browsers" in the network hold a small piece of the site so even if a hosting service refuses to allow content on their network, or on their servers, freenet services would continue uninterrupted.

#### SSL CA

Darkweb SSL is a bit of an odd subject.  There are entire books on the  [subject](https://books.google.com/books?id=RzdmDwAAQBAJ&printsec=frontcover#v=onepage&q&f=false).  Keeping in mind that the main purpose of SSL is to prove who you are, and much of the point of darkweb is to hide who you are, many of these designs seem to work against each other.  With this in mind, there are entrepreneurs that are trying offer good SSL CA services for Tor or I2P.  This simplifies site design since many of the POS and commerce web-development packages assume and require SSL for their communications.

Suffice to say that Darknet SSL does exist, but it is likey beyond the scope of this post or message.

<pre>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJcYGPrAAoJEINfBDOm1RhgvgEH/2fg/dyb9L+fkLSjUVd6tJ8L
sT5hxiQCLwEgfdVQiYaNcD1rNZxnxo02bYKO9SjwKlxd9+1uA5Q8k7EepJKB9Kuo
gAYtp/CFs24CWJzZMr9IDMNtMmmskosT8mRTTzwRjkAcgxLhWgmfNUQUZO/ooQl7
/5qF+dGVowUR/q75FoMsEnTQJKiXrF3HT/5y1bZqe2U3mgba15+OFPSTjsuDbhUE
g5qq4FqdTn+gQysMghrMiBVcxCZ4UsytbHhy49T0pTp8KnoR+0j14jaWhwmhOxhD
9oJEeSdoMNcRukWgSQgo8WJRFOaA+apjIFTcbs19462slPDTLQtkjtS5ASN6NXM=
=cIn1
-----END PGP SIGNATURE-----
</pre>
