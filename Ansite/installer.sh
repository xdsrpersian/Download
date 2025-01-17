#!/bin/sh
# ###########################################
# SCRIPT : DOWNLOAD AND INSTALL ANSITE
# ###########################################
#
# Command: wget https://raw.githubusercontent.com/MOHAMED19OS/Download/main/Ansite/installer.sh -qO - | /bin/sh
#
# ###########################################

###########################################
# Configure where we can find things here #
VERSION='1.5'
TMPDIR='/tmp'
PACKAGE='enigma2-plugin-extensions-ansite'
MY_URL='https://raw.githubusercontent.com/MOHAMED19OS/Download/main/Ansite/'

####################
#  Image Checking  #

if [ -f /etc/opkg/opkg.conf ] ; then
    OSTYPE='Opensource'
    OPKG='opkg update'
    OPKGINSTAL='opkg install'
    OPKGLIST='opkg list-installed'
    OPKGREMOV='opkg remove --force-depends'
fi

if python --version 2>&1 | grep -q '^Python 3\.'; then
    echo ":You have Python3 image ..."
    sleep 1; clear
else
    echo ":You have Python2 image ..."
    sleep 1; clear
fi

##################################
# Remove previous files (if any) #
rm -rf $TMPDIR/"${PACKAGE:?}"* > /dev/null 2>&1

if [ "$($OPKGLIST $PACKAGE |  awk '{ print $3 }')" = $VERSION ]; then
    echo " You are use the laste Version: $VERSION"
    exit 1
elif [ -z "$($OPKGLIST $PACKAGE | awk '{ print $3 }')" ]; then
    echo; clear
else
    $OPKGREMOV $PACKAGE
fi
$OPKG > /dev/null 2>&1
###################
#  Install Plugin #
if python --version 2>&1 | grep -q '^Python 3\.'; then
    echo "Insallling Ansite plugin Please Wait ......"
    wget $MY_URL/${PACKAGE}_${VERSION}_py3_all.ipk -qP $TMPDIR
    $OPKGINSTAL $TMPDIR/${PACKAGE}_${VERSION}_py3_all.ipk
else
    echo "Insallling Ansite plugin Please Wait ......"
    wget $MY_URL/${PACKAGE}_${VERSION}_py2_all.ipk -qP $TMPDIR
    $OPKGINSTAL $TMPDIR/${PACKAGE}_${VERSION}_py2_all.ipk
fi

#########################
# Remove files (if any) #
rm -rf $TMPDIR/"${PACKAGE:?}"* > /dev/null 2>&1


sleep 2; clear
echo ""
echo "***********************************************************************"
echo "**                                                                    *"
echo "**                       Ansite     : $VERSION                             *"
echo "**                       Uploaded by: MOHAMED_OS                      *"
echo "**                       Develop by : aime_jeux                       *"
echo "**  Support    : https://www.tunisia-sat.com/forums/threads/4209147/  *"
echo "**                                                                    *"
echo "***********************************************************************"
echo ""
killall -9 enigma2
exit 0
