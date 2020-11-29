make_magisk_module: 
	zip -r agwall.zip \
	META-INF \
    LICENSE \
	README.md \
	module.prop \
	customize.sh \
	service.sh \
	lst \
	dumpIptables.sh \
	logAGWall.sh 

push:
	adb push agwall.zip /sdcard/

clean: 
	rm agwall.zip
