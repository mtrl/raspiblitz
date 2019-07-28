#!/bin/bash
# see issue: https://github.com/rootzoll/raspiblitz/issues/681

source /home/admin/raspiblitz.info
source /mnt/hdd/raspiblitz.conf

# command info
if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "-help" ]; then
 echo "flip/rotate the LCD screen"
 echo "blitz.lcdrotate.sh [on|off]"
 exit 1
fi

###################
# SWITCH ON
###################

if [ "$1" = "1" ] || [ "$1" = "on" ]; then

  echo "Turn ON: LCD ROTATE"

  # add default 'lcdrotate' raspiblitz.conf if needed
  if [ ${#lcdrotate} -eq 0 ]; then
    echo "lcdrotate=0" >> /mnt/hdd/raspiblitz.conf
  fi
  
  sudo sed -i "s/^dtoverlay=.*/dtoverlay=tft35a:rotate=90/g" /boot/config.txt
  sudo sed -i "s/^lcdrotate=.*/lcdrotate=1/g" /mnt/hdd/raspiblitz.conf
  echo "OK - a restart is needed: sudo shutdown -r now"

fi

###################
# SWITCH OFF
###################

if [ "$1" = "0" ] || [ "$1" = "off" ]; then

  echo "Turn OFF: LCD ROTATE"
  sudo sed -i "s/^dtoverlay=.*/dtoverlay=tft35a:rotate=270/g" /boot/config.txt
  sudo sed -i "s/^lcdrotate=.*/lcdrotate=0/g" /mnt/hdd/raspiblitz.conf
  echo "OK - a restart is needed: sudo shutdown -r now"

fi
