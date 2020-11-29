#!/system/bin/sh

# Set permissions for scripts
set_perm $MODPATH/service.sh 0 0 750 
set_perm $MODPATH/customize.sh 0 0 750
set_perm $MODPATH/upAGWall.sh 0 0 750
set_perm $MODPATH/dumpIptables.sh 0 0 750
set_perm $MODPATH/logAGWall.sh 0 0 750
set_perm_recursive $MODPATH/lst/userscripts 0 0 640 750
set_perm_recursive $MODPATH/lst/patches 0 0 640 750
set_perm_recursive $MODPATH/lst/tables 0 0 640 750

