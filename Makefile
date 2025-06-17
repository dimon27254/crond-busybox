SHELL := /bin/bash
VERSION := $(shell cat VERSION)

.DEFAULT_GOAL := crond-busybox

clean:
	rm -rf out/$(BUILD_DIR)

_clean:
	rm -rf out/$(BUILD_DIR)
	mkdir -p out/$(BUILD_DIR)/control
	mkdir -p out/$(BUILD_DIR)/data

_control:
	echo "Package: crond-busybox" > out/$(BUILD_DIR)/control/control
	echo "Version: $(VERSION)" >> out/$(BUILD_DIR)/control/control
	echo "Depends: busybox" >> out/$(BUILD_DIR)/control/control
	echo "Section: utils" >> out/$(BUILD_DIR)/control/control
	echo "URL: https://github.com/dimon27254/crond-busybox" >> out/$(BUILD_DIR)/control/control
	echo "Architecture: all" >> out/$(BUILD_DIR)/control/control
	echo "Description:  Files for busybox crond" >> out/$(BUILD_DIR)/control/control
	echo "" >> out/$(BUILD_DIR)/control/control

_scripts:
	cp ipk/postinst out/$(BUILD_DIR)/control/postinst
	cp ipk/prerm out/$(BUILD_DIR)/control/prerm
	chmod +x out/$(BUILD_DIR)/control/postinst
	chmod +x out/$(BUILD_DIR)/control/prerm

_startup:
	cp -r etc/init.d out/$(BUILD_DIR)/data/opt/etc/init.d
	chmod +x out/$(BUILD_DIR)/data/opt/etc/init.d/S05crond

_ipk:
	make _clean

	# control.tar.gz
	make _control
	make _scripts
	cd out/$(BUILD_DIR)/control; tar czvf ../control.tar.gz .; cd ../../..

	# data.tar.gz
	mkdir -p out/$(BUILD_DIR)/data/opt/etc
	
	make _startup

	cd out/$(BUILD_DIR)/data; tar czvf ../data.tar.gz .; cd ../../..

	# ipk
	echo 2.0 > out/$(BUILD_DIR)/debian-binary
	cd out/$(BUILD_DIR); \
	tar czvf ../$(FILENAME) control.tar.gz data.tar.gz debian-binary; \
	cd ../..

crond-busybox:
	@make \
		BUILD_DIR=crond-busybox \
		FILENAME=crond-busybox_$(VERSION)_all.ipk \
		_ipk