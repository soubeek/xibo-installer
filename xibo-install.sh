#!/bin/bash

set -e

# Checks to ensure the user is running as root since we will be making system wide changes

if [ ! "`whoami`" = "root" ]; then
		echo " "
		echo "========================================================"
		echo " This script must be run as root or with sudo... Exiting"
		echo "========================================================" 1>&2
		sleep 3
	exit 1
fi

echo " "
echo "========================================================"
echo " Xibo Python Client Installation Script v1"
echo " Ubuntu 12.04"
echo " Script by Brian Mathis - http://www.brianmathis.net (c)2010-2011"
echo " Updates by Alex Harrington (c) 2014"
echo " This script will update, download, and install the Python"
echo " client for use with Xibo - Open Source Digital Signage"
echo "========================================================"
echo " "
echo "Please select an option to continue..."
echo " "
echo "   [1] Install client"
echo "   [q] Quit"
echo " "
echo " "

read OPTION

	case "$OPTION" in
		"1")

			# Stops the script if dir already exists. 
			if [ -d "/opt/xibo/pyclient" ]; then 

				echo "Error: /opt/xibo already exists. If you would like to upgrade"
				echo "your client, please choose option 2. Otherwise, please check"
				echo "the directory and try again."
				exit 1

			else

				# Creates dir
				mkdir -p /opt/xibo 

			fi

			# Check which version of Ubuntu the user is running and then selects what to do
			codename=`lsb_release -c | awk '{print $2}'`

			if [ "$codename" == "precise" ]

				then
					echo " "
					echo "========================================================"
					echo " Installing Xibo Python Client for Ubuntu 12.04"
					echo " Required packages and binaries will now be installed"
					echo "========================================================"
					echo " "
					# Updates the package manager
					dpkg -i deb/*
					
					# extracts the tar to /
					tar xf libavg-* -C /

					# removes tar file after extract
					rm libavg-*

					# runs ldconfig
					ldconfig

					# moves to dir and downloads pyclient
					cd /opt/xibo && git clone https://github.com/xibosignage/xibo-pyclient.git pyclient
					
					# grants 777 read/write permissions to all
					chmod -R 777 /opt/xibo


					echo " "
					echo "========================================================"
					echo " All done. Navigate to /opt/xibo/pyclient/client/python"
					echo " to make changes to site.cfg "
					echo " For more info on the Python client, visit: "
					echo " http://xibo.org.uk/manual"
					echo "========================================================"
					echo " "

					sleep 3

				;;
				
				"Q"|"q")
	
					echo " "
					echo "Thanks for using Xibo - Open Source Digital Signage"
					echo " "
					echo " "

				;;
 esac		






