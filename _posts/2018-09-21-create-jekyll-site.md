---
layout: post
title:  "Creating A Jekyll Site"
date:   2018-09-21 17:40:00 -0500
# categories: jekyll update
---

To start, just follow the [github instructions](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/).  I'll go through a few of them here.  Change `{jksite}`, and `{userid}` to something appropriate (without `{}`). 

#### Install dependencies

```bash
sudo apt-get make gcc lynx ruby ruby-dev g++ zlib1g-dev
sudo gem install bundler
```

#### Create the repo

* Browse to github [new repo page](https://github.com/new)
* Set name to `{jksite}`
* Check `Initialize with Readme`
* Set `.gitignore` to `Ruby`
* Set `License` to `Apache`
* Click `Create Repository`

#### Create the branch

From the shell perform the following to checkout the repo and create a `gh-pages` branch
```bash
mkdir ~/src
cd ~/src
git clone https://github.com/{userid}/{jksite}.git
cd {jksite}
git config --local user.email "{userid}@users.noreply.github.com"
git config --local user.name "{userid}"
git checkout -b gh-pages
```

#### Install Jekyll
```bash
sudo apt-get install make gcc g++ zlib1g-dev ruby ruby-dev lynx
ruby --version
sudo gem install bundler
vi Gemfile # add the following to lines to Gemfile and save
   source 'https://rubygems.org'
   gem 'github-pages', group: :jekyll_plugins
bundle install
```

#### Create Jekyll site
```bash
cd ~/src
jekyll new {jksite}
cd {jksite}
vi Gemfile # modify the file to comment out jekyll and add github-pages 
   -> # gem "jekyll", "~> 3.7.4"
   -> gem "github-pages", group: :jekyll_plugins
bundle update
bundle install
```

#### Test the site
```bash
bundle exec jekyll serve &
lynx http://127.0.0.1:4000 # 'q' to quit lynx
kill %1
```

#### Push back to repo
```bash
git add -A
git commit -a -m "Jekyll Pages"
git push -u origin gh-pages
```

#### Further Tasks

* [Install NoIP Service]({{ site.baseurl }}{% post_url 2018-09-22-install-noip %}) to get `coolhostname.tld.com`
* [Set up DynDNS on Github Pages](https://help.github.com/articles/troubleshooting-custom-domains/) with noip service to point to `mygithub.tld.com`
* [Learn Lynx](https://www.addictivetips.com/ubuntu-linux-tips/install-and-use-lynx-on-ubuntu/) to navigate webpages without a GUI desktop 
