---
layout: post
title:  "Host Onion Service from Android"
date:   2019-06-01 21:41:56 -0500
# categories: jekyll update
---

In most Android mobile network environments the phone will using mobile data or a wifi hotspot.  Both of these environments will often prevent users from hosting a server since it is difficult to perform the necessary port forwarding to make packets routable to the service.

Onion services solve this problem by using the [onion rendezvous protocol](https://www.torproject.org/docs/onion-services.html.en).  The *rendezvous protocol* allows an endpoint behind a NAT or firewall to host and advertise services.  This type of system is ideal for hosting services on Android since it solves all of the question related to port routing automatically.  The only drawback is that it requires users to install a Tor capable browser.  This will be less and less of a hurdle as many browsers are integrating [Tor capabilities natively](https://brave.com/tor-tabs-beta), or have [announced plans to do so](https://www.zdnet.com/article/mozilla-offers-research-grant-for-a-way-to-embed-tor-inside-firefox/).

So... here's how we set it up.

### Install UserLAnd for Android

For this guide I decided to use UserLAnd as opposed to Termux simply for the ease of use.  Termux is certainly more full featured, but may require a bit more expertise to set up.

Install [UserLAnd](https://play.google.com/store/apps/details?id=tech.ula) (by UserLAnd Technologies) from the Android Play Store.

### Connect to your phone's Wi-Fi

Its difficult to know if your Android is on a network that will accept incoming connections.  The easiest way around that is to put your phone and laptop on thier own private network.  This is exactly what Wi-Fi hotspot does under the hood.

1. Turn on Wi-Fi hotspot in Android.
2. Connect your laptop to the hotspot.
3. Examine your Wi-Fi network properties.
4. Record the **default-gateway** on your Wi-Fi addapter (for later).

Once connected, your laptops Wi-Fi **default-gateway** is actually the IP address of your phone.  We will use this to open an SSH session later.

### Set up a Ubuntu filesystem

1. Launch the UserLAnd app
2. Click **Ubuntu** under *Distribution*
3. Create a username and complex passwords when prompted
4. Select **SSH**
5. Wait for assets to download and extract (minute or two)
6. Log into shell once it launches

### SSH into Ubuntu

1. Recall the Wi-Fi **default-gateway** from earlier
2. SSH to that IP address on port `2022`
3. User your username and complex password from earlier

### Install required software

We'll go ahead and go for the bleeding edge.  This will get all the most current packages.  You can skip the middle two commands if you want to be conservative.  From the SSH shell issue the following command:

```shell
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install vim tor lighttpd
```

### Set up lighttpd

From the SSH shell edit your lighttpd.conf (`vi /etc/lighttpd/lighttpd.conf`).  Modify the end of the `server.` section and add a `server.bind` directive.

```
server.port                 = 80
server.bind                 = "127.0.0.1"
```

### Set up tor

From the SSH shell edit your lighttpd.conf (`vi /etc/tor/torrc`).  Find the `HiddenService` section and uncomment the first two `HiddenService` directives.

```
## HiddenServicePort x y:z says to redirect requests on port x to the
## address y:z.

HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:80
```

### Create a lighttpd / tor startup script

UserLAnd doesn't support the SysV init system since it is really just a PRoot.  As a bit of a hack, we will create a startup script called `/linuxrc` like the old days.  We are going to call that script from `/support/startSSHServer.sh`.  In the script for the lighttpd service, we will ensure the `html` directory is running from `/sdcard`.  This will make the website files accessible to most of the Android OS.  Since UserLAnd doesn't have good shutdown mechanics, we will likely have to sanitize the tor lock file to allow subsequent restarts.  UserLAnd also has some issues with user permissions so you have to run any tor launch scripts from the service context.  We can achieve this through the `runuser` command.

One wierd bit in the script is the `block_for_hostname` function.  Sometimes when the tor server starts up, it can take a second to generate the **first** hostname file.  To keep the system running smoothly, we put that wait on the hostname file into the background.

Edit/Create a new *tor.rc* file (`vi /linuxrc`)

```shell
#! /bin/bash
#
# Note, this file is called from /support/startSSHServer.sh
#
function block_for_hostname {
   hostfile="/var/lib/tor/hidden_service/hostname"
   while [ ! -f $hostfile ]; do sleep 100; done
   onion=$(cat /var/lib/tor/hidden_service/hostname)
   echo "Placeholder: http://$onion/index.lighttpd.html"
}

logfile="/sdcard/Android/data/tech.ula/linuxrc.log"
{
   ln -sf $logfile /var/log/$(basename $logfile)
   #
   # Start lighttpd
   #
   if [ ! -L /var/www/html ]; then
      mv /var/www/html /sdcard/Android/data/tech.ula/
      ln -s /sdcard/Android/data/tech.ula/html /var/www/html
   fi
   service lighttpd start

   #
   # Start Tor
   #
   rm -f /var/lib/tor/lock
   runuser -s /bin/bash -c "service tor start" debian-tor
   block_for_hostname &
} > $logfile 2>&1
```

We will also need to ensure the file is executable (`chmod +x /linuxrc`).

Now we want to add the call to `/linuxrc` to `startSSHServer.sh`.  We will add it right before the call to dropbear (`vi /support/startSSHServer.sh`)

```
/linuxrc
dropbear -E -p 2022
```

### Logout and shutdown

As mentioned before, UserLAnd doesn't have the best shutdown mechanics, but we can do what we can.  One annoyance is that since lighttpd and tor are running under the service context they will not shut down with the Ubuntu instance.  You may consider this a "feature" if you want them always up.  To actually kill the services, you have the kill the UserLAnd process itself.  You can do this through app manager in settings (force stop) or through most android task switchers.

1. Type `exit` in all SSH sessions you opened from your laptop
2. Look at your android notifications and `exit` any open UserLAnd terminals
3. Long press your Ubuntu distribution and select `Stop App`.
4. Kill UserLAnd task.

If you did all of this, your session should have shutdown about as smoothly as you could hope.

### All done

You know have a pocket onion server.  To start it, simply launch UserLAnd and tap Ubuntu.  You don't even need to log in.  To shut down, use the steps described previously.  Add files to your website, simply add them in the `/sdcard/Android/data/tech.ula/html`.  If you just want to verify that it works, lighttpd will have a placeholder file at `/index.lighttpd.html`.  For more information, look at the log file at `/sdcard/Android/data/tech.ula/linuxrc.log`.

### Useful Tor Browsers

As mentioned at the begining of this article, this web hosting that we have done here require a Tor capabile browser.  Below is a list of good options:

* [**Tor Browser**](https://www.torproject.org/download/) - The official Tor Browser.  It is based on Firefox with some additions to ensure privacy.
* [**Brave Browser**](https://brave.com/dwb616) - Popular Chrome clone with a *Private Tor Tab* feature for browsing `.onions`.
* [**Android Tor Browser**](https://play.google.com/store/apps/details?id=org.torproject.torbrowser) - The official Tor Browser for Android.
* [**iOS Onion Browser**](https://itunes.apple.com/us/app/onion-browser/id519296448) - The officially endorsed Tor Browser for iPhone.
