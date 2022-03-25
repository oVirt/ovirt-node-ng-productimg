
product.img:
	ISFINAL=False scripts/create-product-img.sh $@

all: product.img

dist:
	git ls-files | tar --files-from /proc/self/fd/0 -czf "ovirt-node-ng-productimg-4.5.0.tar.gz"