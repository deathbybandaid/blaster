#!/bin/bash
This is a shell dnsblaster

## Vars
HOSTTOBLAST=$(whiptail --inputbox "What DNS SERVER?" 10 80 "" 3>&1 1>&2 2>&3)
DOMAINLISTURL="https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/parsedall/1111ALLPARSEDLISTS1111.txt"
DOMAINLIST="/home/domainlist"

## Deps
WHATITIS=wamerican
WHATPACKAGE=wamerican
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
echo "* $WHATITIS already installed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
echo "* $WHATITIS was installed $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

WHATITIS=dnsutils
WHATPACKAGE=dnsutils
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
echo "* $WHATITIS already installed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
echo "* $WHATITIS was installed $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

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
