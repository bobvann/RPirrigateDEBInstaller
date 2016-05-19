#!/usr/bin/env bash

VERSION="1.0.0"
PACKAGENAME="debs/rpirrigate-$VERSION.deb"

rm -rf /tmp/RPirrigate

(cd /tmp && git clone https://github.com/bobvann/RPirrigate )

rm -rf debian/srv
rm -rf debian/etc
mkdir -p debian/srv/rpirrigate
mkdir -p debian/etc/init.d
mkdir -p debian/etc/logrotate.d

cp -R /tmp/RPirrigate/data debian/srv/rpirrigate/
cp -R /tmp/RPirrigate/daemon debian/srv/rpirrigate/
cp -R /tmp/RPirrigate/web debian/srv/rpirrigate/

cp /tmp/RPirrigate/install/logrotate.erb debian/etc/logrotate.d/rpirrigate

cp /tmp/RPirrigate/install/init.d.erb debian/etc/init.d/rpirrigate

#change version in DEBIAN/control
sed "s/Version: 0.0.0/Version: $VERSION/" default-control > debian/DEBIAN/control

dpkg-deb --build debian

mv debian.deb $PACKAGENAME

git add $PACKAGENAME