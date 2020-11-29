#!/bin/sh

# Disable network status checking
wachdogState=0

settings put global captive_portal_mode $wachdogState
settings put global captive_portal_detection_enabled $wachdogState 
settings put global wifi_watchdog_on $wachdogState
settings put global wifi_watchdog_background_check_enabled $wachdogState


