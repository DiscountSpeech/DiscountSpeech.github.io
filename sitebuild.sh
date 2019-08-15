#!/bin/bash
eval docroot="~www-data/html"
eval i2proot="~i2psvc"
eval jsite_conf="~freenet/jSite.conf"
eval jsite_jar="~freenet/jSite-12-jSite-0.13-jar-with-dependencies.jar"

function mk_env() {
   sudo sed 's#<#"\n#g;s#>#="#g;s#request-##g' $jsite_conf | \
      grep "^uri\|^edition\|^path\|^name"
}

function bld_docroot() {
   umask 0027
   sudo bundle exec jekyll build --destination ${docroot}
   sudo chown -R root:www-data $docroot
   sudo chmod -R g+r,o-rwx,g-w $docroot
   sudo ln -s "${i2proot}/i2p-config/published.txt" "${docroot}/hosts.txt"
   sudo chown i2psvc:www-data ${docroot}/hosts.txt
}

function upld_freesite() {
   source <(mk_env)
   freecfg="80-freenet.conf"
   (( edition++ ))
   freeroot="/freenet:USK@${uri}/${path}"
   baseurl="baseurl: \"${freeroot}/${edition}\""
   freeurl="${baseurl/baseurl:/freeurl:}"
   echo > _freenet.yml "${baseurl}"
   sed -i "1s#^#${freeurl}\n#;s#\nfreeurl:.*##" _config.yml
   bundle exec jekyll build --config _config.yml,_freenet.yml
   sudo java -cp ${jsite_jar} \
      "de.todesbaum.jsite.main.CLI" \
      "--config-file=${jsite_conf}" \
      "--project=${name}"
   printf "%s\n%s\n%s\n" \
          "var.freeRoot      = \"${freeroot}\"" \
          "var.freeRootShort = \"${freeroot/freenet:/}\"" \
          "var.freeEdition   = \"${edition}\""  \
          | > /dev/null sudo tee "/etc/lighttpd/conf-available/$freecfg"
   sudo ln -fs "../conf-available/$freecfg" "/etc/lighttpd/conf-enabled/$freecfg"
   sudo chmod o+r "/etc/lighttpd/conf-available/$freecfg"
}

IFS='' read -r -d '' header <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
EOF

function mk_sitemap() {
   redirects=$(sudo grep "\"\^/[^\n].*[$]\"" /etc/lighttpd/lighttpd.conf | sed 's#"\^/##g;s#\$"##g' | awk '{print $1}')
   bundle exec jekyll build
   uris=$(find _site -iname "*.html" | sed "s#/index.html#/#g;s#_site##g" | egrep -v "^/google[0-9a-z.]*html$")
   uris=$(tr "\n" "\n" <<< "$uris")
   ghphost="dwghp.ddns.net"
   for line in $(egrep "^Sitemap:" robots.txt | awk '{print $2}'); do
      IFS='/' read -r proto null host sm null <<< "$line"
      echo "$header" > "$sm"
      for uri in $uris; do
         echo "<url><loc>${proto}//${host}${uri}</loc></url>" >> "$sm"
         if [ "$host" != "$ghphost" ]; then
            for rd in $redirects; do
               echo "<url><loc>${proto}//${host}/${rd}${uri}</loc></url>" >> "$sm"
            done
         fi
      done
      echo "</urlset>" >> "$sm"
   done
}

function update_wa() {
   sudo rm /var/log/wa.log
   sudo /etc/cron.daily/web-archive-update
}

function ping_seo() {
   for uri in $(grep "^Sitemap:" robots.txt |egrep -v "onion/|i2p/" |awk '{print $2}'); do
      for engine in "http://google.com/ping" "http://www.bing.com/ping"; do
         curl -vv -s -o /dev/null --data-urlencode "sitemap=$uri" -G "$engine" 2>&1 | egrep "^> GET|^> Host:|^< HTTP"
      done
   done
}
echo "#### Uploading Freesite"
#upld_freesite
echo "#### Building Sitemap"
#mk_sitemap
echo "#### Building Main"
bld_docroot
echo "#### Restarting Web-Server"
sudo systemctl restart lighttpd
echo "#### Building SEO Stats"
#sudo /etc/cron.hourly/seo-status
echo "#### Pinging SEO"
#ping_seo
echo "#### Updating Web-Archive"
#update_wa
