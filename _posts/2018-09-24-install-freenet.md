---
layout: post
title:  "Installing Freenet Service"
date:   2018-09-24 21:20:00 -0500
# categories: jekyll update
---

Before we begin, there is a bit of maintenance to do.  Freenet will benifit from some `rng` tools so install:
```bash
sudo apt-get install rng-tool
```

The JRE that Ubuntu (bionic) defaults to has some incompatibilities with Freenet (0.7.5 Build 1480) has some trouble with.  The problem is related to [assistive technology class not found]( https://askubuntu.com/questions/695560/assistive-technology-not-found-awterror) error.  To get around it simply comment out the last (and only) line in `/etc/java-8-openjdk/accessibility.properties`
```bash
sudo vi /etc/java-8-openjdk/accessibility.properties
   # assistive_technologies=org.GNOME.Accessibility.AtkWrapper
```

Now on to the install.  Although it is often suggested that Freenet be installed under a user account, I choose instead to install it under a system account since that seemed much less privileged than some of my standard login accounts.  The wiki has a good [walkthrough]( https://github.com/freenet/wiki/wiki/Installing-on-POSIX#debian-based-with-a-freenet-system-user).

```bash
sudo adduser --system --home /usr/local/Freenet --group freenet
sudo chown -R freenet:freenet ~freenet
sudo chmod -R o-rwx,g-w ~freenet
cd ~freenet
sudo su -s "$SHELL" freenet # log-in as freenet
umask 0027
installjar=build01480/new_installer_offline_1480.jar
wget -O new_installer_offline.jar \
   https://github.com/freenet/fred/releases/download/$installjar
java -jar new_installer_offline.jar -console
exit # log-out of freenet
```

Now that freenet is running, go ahead and copy the ports you need to open
```bash
sudo grep listen /usr/local/Freenet/freenet.ini
```
You should see two UDP ports.  One is the `opennet` port used by strangers, the other is the `darknet` port used by friends.  To open them, create a firewall rule from your laptop using the GCE api

```bash
gcloud config set compute/zone {zone}
gcloud compute firewall-rules create i2p-server \
 --target-tags=i2p-server \
 --allow=udp:{opennetPort},udp:{darknetPort} \
 --source-ranges=0.0.0.0/0
gcloud compute instances add-tags {vm-name} --tags "i2p-server"
```

At this point freenet is running but needs to be configured.  You can configure it with `lynx` but running a desktop browser might be a bit eaiser

```bash
# Pick the browser you want...
# browser="seamonkey"         
# browser="dillo"             
browser="lynx"
$browser http://127.0.0.1:8888
```

This will give you the startup wizard for you to configure your node.  Most of the defaults are fine, though you might want to change your bandwidth.  Since you get charged on GCE for bandwidth, be careful with your generosity.  I choose 8KiB / 128KiB, but if you miss this step, you can always change it back, or edit the `freenet.ini` file.  Use values you think are fair, these are likely the lowest possible for freenet to function at all.  

```bash
sudo vi /usr/local/Freenet/freenet.ini # change the following
   node.outputBandwidthLimit=8192
   node.inputBandwidthLimit=131072
```

Before we go any further, we will need to do a test build of our Jekyll site to prepare to upload it

```bash
cd ~/src/{jksite}
bundle exec jekyll build
```

Once we have that sorted, we can get on to uploading our blog to Freenet.  For this process we will need a jar called `jSite`.  To download `jSite` browse to `http://127.0.0.1:8888` and follow the `jSite` link then download the jar file in the download area of the site.  Do be aware, the download process may be kind of odd since error codes `500` is routinely thrown around, so just be patient and read every redirect.

Once you have the jar go ahead and copy it to your `~/Downloads` dir.  You may want to add permissions to the `jar` depending on how you downloaded it.  The first execution is used to create a config file, so you have to do that from the desktop (update *userid* and *jksite* with appropriate values).

* Start `vncserver`
* Punch VNC whole in your firewall
* Launch VNC viewer on your laptop to your VM's external IP
* Enter your *highly random* VNC password
* From the desktop launch a terminal
* `cd` to the Downloads directory `cd ~/Downloads`
* Launch the jar `java -jar jSite-*.jar`
* Click *Add Project*
* Fill out Name: *My Blog*
* Fill out Description: *Jekyll Blog*
* Fill out Local path: */home/`{userid}`/src/`{jksite}`/_site*
* Freesite Path: *myblog*
* Click *Next*
* Click `index.html` in the list
* Check the *Default file* checkbox
* Click *Quit*
* From terminal type `vncserver -kill :1` to exit VNC

Now in the `~/Downloads` folder you will find a file called `jSite.conf` with information required to upload the site.  We are done with the desktop environment and we can now move to updating the `sitebuild.sh` script.  Using the editor of your choice, update the `sitebuild.sh` file to contain the following.

```bash
#!/bin/bash
docroot="/var/lib/i2p/i2p-config/eepsite/docroot"
jsite_conf="${HOME}/Downloads/jSite.conf"
jsite_jar="${HOME}/Downloads/jSite-12-jSite-0.13-jar-with-dependencies.jar"

function mk_env() {
   sed 's#<#"\n#g;s#>#="#g;s#request-##g' $jsite_conf | \
      grep "^uri\|^edition\|^path\|^name"
}

function bld_docroot() {
   umask 0027
   sudo cat ${docroot}/hosts.txt > hosts.txt
   sudo bundle exec jekyll build -d ${docroot}
   sudo chown -R i2psvc:www-data $docroot
   sudo chmod -R o-rwx $docroot
   sudo chmod -R g-w $docroot
}

function upld_freesite() {
   source <(mk_env)
   echo > _freenet.yml "baseurl: \"/freenet:USK@${uri}/${path}/$(( edition + 1 ))\""
   bundle exec jekyll build --config _config.yml,_freenet.yml
   java -cp ${jsite_jar} \
      "de.todesbaum.jsite.main.CLI" \
      "--config-file=${jsite_conf}" \
      "--project=${name}"
}

bld_docroot
upld_freesite
```

The variables `jsite_conf`, and `jsite_jar`, in the script above, will need to be updated to reflect your particular config.  The script is broken down into functions.  The `mk_env` function will use the config file to generate variable declarations `uri`, `edition`, `path`, and `name`.  The `source <(mk_env)` is a bit of bash wizardry to consume those declarations.  Finally, the `_freenet.yml` appends a Jekyll config to set the `baseurl` to the proper freesite key.  The site is then built with `bundle exec jekyll build` and uploaded using the `jSite` jar.

<!-- 

add disable awt section!

Freenet
   
open ports in firewall
   
Follow the wiki (from my reddit post) on how to create freenet user
set user umask 0027
chown the dir
chmod the files
Remove the aws stuff in java (not req)
sudo apt-get install rng-tool   


how to change gce network tier
how to add ip to gce instance
how to start a security scan

grep -i "Port" /usr/local/Freenet/freenet.ini

logrotate for lighttpd
/var/log/lighttpd/*.log {
        weekly
        size 5M
        missingok
        rotate 12
        compress
        delaycompress
        notifempty
        sharedscripts
 
 
 
 ( for i in $(ls -rt *.log; ls -rt *.gz ); do ( zcat $i || cat $i ); done ) | grep "at freenet" | sort | uniq | wc -l

 https://en.wikipedia.org/wiki/Peer-to-peer_web_hosting
 https://namecoin.org/docs/tor-resolution/

 https://web.archive.org/web/20151126010245/http://dot-bit.org:80/Namespace:Domain_names_v2.0#Value_field
 see Types: { ip, tor, i2p, freenet }
 
 https://zeronet.readthedocs.io/en/latest/faq/#how-can-i-register-a-bit-domain
 see { zeronet }
 
-->