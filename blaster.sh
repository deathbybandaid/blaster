#!/bin/bash
##This is a shell dnsblaster

## Deps
WHATITIS=dnsutils
WHATPACKAGE=dnsutils
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
fi

WHATITIS=whiptail
WHATPACKAGE=whiptail
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
fi

## Vars
HOSTTOBLAST=$(whiptail --inputbox "What DNS SERVER?" 10 80 "" 3>&1 1>&2 2>&3)
DOMAINLISTURL="https://github.com/deathbybandaid/piholeparser/raw/master/Subscribable-Lists/CombinedBlacklists/CombinedBlackLists.txt"
DOMAINLIST="/home/domainlist"

## Get Domain List
wget -q -O $DOMAINLIST $DOMAINLISTURL

for source in `cat $DOMAINLIST`;
do
echo "Querying $source"
dig @$HOSTTOBLAST $source > /dev/null

## End Loop
done

## Remove hostlist
rm $DOMAINLIST
