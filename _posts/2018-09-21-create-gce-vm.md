---
layout: post
title:  "Creating A GCE VM"
date:   2018-09-21 17:30:00 -0500
# categories: jekyll update
---
If you decide to use Google Compute Engine to host your webserver, you should be able to use their API to do most maintenace tasks.  

#### Install the SDK

The [gcloud SDK installer](https://cloud.google.com/sdk/install) is simple enough and should work on most any OS.  The guts are python and if your really determined you can strip out the scripts and use the python libraries directly.

#### Creating a VM

Once the SDK is installed, you can start up a VM with a few command line instructions.  You want to change `{zone}`, `{disk-name}`, and `{vm-name}` to your personal choices.  Obviously strip out the `{}`.

```bash
gcloud config set compute/zone {zone}
gcloud compute project-info update --default-network-tier=STANDARD
gcloud compute instances create \
 --image-family=ubuntu-1804-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=f1-micro \
 --preemptible {vm-name}
gcloud compute ssh {vm-name}
```

#### Adding a swapfile

Once your VM is running, you might want to consider adding some cache.  You won't need it for the clearnet config, but you will need it as you start to set up some of the darknet services.  I'd suggest you simply follow [this procedure](https://www.tecmint.com/create-a-linux-swap-file/) to set a swap **file** instead of using a more traditional **partition** based setup.

```bash
sudo fallocate --length 2GiB /var/swapfile
sudo chmod 600 /var/swapfile
sudo mkswap /var/swapfile
sudo swapon /var/swapfile
sudo vi /etc/fstab # add the following line
   /var/swapfile swap swap defaults 0 0
```

#### Enabling desktop GUI

Although not required, you might want to install a GUI desktop for some tasks that may come. Since we are running a **very** small memory footprint, we will [install xfce, TightVNC and dillo](https://medium.com/google-cloud/linux-gui-on-the-google-cloud-platform-800719ab27c5) which will give us a desktop, remote access and a web browser.
```bash
sudo apt-get install tightvncserver xfce4 xfce4-goodies dillo
```

Although Dillo is a good lightweight browser, [SeaMonkey](https://wiki.debian.org/Seamonkey) is by far much more capable.
```bash
sudo apt-get install dirmngr apt-transport-https
sudo vi /etc/apt/sources.list # add the following
   deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2667CA5C
sudo apt-get update
sudo apt-get install seamonkey-mozilla-build
```

Now to set your VNC password.  Pick something random!  Having a guessable password will be **very** bad.
```bash
vncpasswd
```

#### Accessing GUI through VNC

To access your system remotely, you will need to SSH into the system then launch the VNC server, do your work and tear down the VNC server.  I would **not** recommend leaving the VNC server running as this is a **huge** security risk.  You will also need to pick a VNC client for [Windows](http://www.tightvnc.com/download.php), Linux or MacOS

To make your system accessible remotely via VNC, we will have to punch another hole in the firewall using tcp:5901

First, determine your laptop's IP address and only allow that source IP through...
```bash
curl -s https://api.myip.com/
```

Next, create a firewall and add it to your VM.
```bash
gcloud compute firewall-rules create vnc-server \
 --target-tags=vnc-server \
 --allow=tcp:5901 \
 --source-ranges={your-ip}/32
gcloud compute instances add-tags {vm-name} --tags "vnc-server"
```

Now you should be able to connect to your VM via VNC.  To find your VM's IP address, grab the `EXTERNAL_IP` from the following command

```bash
gcloud compute instances list
```

using the hostname you registered with noip.com and port 5901
```bash
tvnviewer.exe {EXTERNAL_IP}::5901  # tvnviewer will be different on different laptops.
```

When your done in the VNC session, close all the GUI apps, then from the `xterm` app on your VM's desktop run:
```bash
vncserver -kill :1
```

For future sessions, make sure to update the `{your-ip}` value in the `vnc-server` firewall rule by using the following command:

```bash
gcloud compute firewall-rules update vnc-server --source-ranges={your-ip}/32
```

#### Homework

* [Install NoIP Service]({{ site.baseurl }}{% post_url 2018-09-22-install-noip %}) to replace `{EXTERNAL_IP}` with `{coolhostname.tld.com}`
* [Add clipboard support to VNC](https://askubuntu.com/questions/645176/editing-vnc-xstartup-to-launch-xfce-on-vnc-server) to allow you to cut/paste text from laptop to VM
* [Install Lynx](https://www.addictivetips.com/ubuntu-linux-tips/install-and-use-lynx-on-ubuntu/) to learn how to navigate webpages without a GUI desktop 

<!-- todo: cut-paste https://askubuntu.com/questions/645176/editing-vnc-xstartup-to-launch-xfce-on-vnc-server -->