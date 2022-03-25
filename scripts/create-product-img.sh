#!/bin/bash -ex
# Guides:
# https://fedoraproject.org/wiki/Anaconda/ProductImage#Product_image
# https://git.fedorahosted.org/cgit/fedora-logos.git/tree/anaconda


ISFINAL=${ISFINAL:-False}
VERSION=4.5

DST=$(realpath ${1:-$PWD/product.img})
DATADIR=$(dirname $0)/../data
SRCDIR=$DATADIR/pixmaps
PRDDIR=product/
PIXMAPDIR=$PRDDIR/usr/share/anaconda/pixmaps/
KSDIR=$PRDDIR/usr/share/anaconda/
SSGDIR=$PRDDIR/usr/share/xml/scap/ssg/content

mkdir -p "$PRDDIR" "$PIXMAPDIR" "$KSDIR"
cp "$SRCDIR"/sidebar-logo.png "$PIXMAPDIR/"

product_conf_dir=$PRDDIR/etc/anaconda/product.d
mkdir -p $product_conf_dir
cp $DATADIR/ovirt.conf $product_conf_dir

mkdir -p $SSGDIR

ln -sf "/usr/share/xml/scap/ssg/content/ssg-rhel$(rpm --eval "%rhel")-ds.xml" $SSGDIR/ssg-onn${VERSION:0:1}-ds.xml

cat > "$PRDDIR/.buildstamp" <<EOF
[Main]
Product=oVirt Node Next
Version=${VERSION}
BugURL=https://bugzilla.redhat.com
IsFinal=${ISFINAL}
UUID=$(date +%Y%m%d).x86_64
[Compose]
Lorax=21.30-1
EOF

pushd $PRDDIR
  find . | cpio -c -o --quiet | pigz -9c > $DST
popd

rm -rf $PRDDIR

#unpigz < $DST | cpio -t
