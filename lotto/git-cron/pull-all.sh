#!/bin/bash
# fetches all repos in all sites.
SCRIPTNAME=`basename "$0"`;
LCKDIR="/var/lock";

# strip script's file extension.
LCKFN="$(echo $SCRIPTNAME | rev | cut -d "." -f 2- | rev)";
LCKFILE="$LCKDIR/$LCKFN.lck";
DATESTAMP="$(date -Is)";

#paths to websites dir
WEBSITES="websites";
SCRIPTS="$WEBSITES/_maint_scripts";

#create lock
if [ -f "$LCKFILE" ]; then
    echo "[ERROR] $SCRIPTNAME is already running. $LCKFILE present."
    exit;
else
    echo "$DATESTAMP" > $LCKFILE;
fi

#get list of all sites
cd /$WEBSITES/;
ALLSITES="$(ls -1 | grep '^\(20[0-9][0-9]\([ab]\)\?\|NEXT\)_' | sort -r)";

#prime logs so we know where we are in the loop:
echo "### $SCRIPTNAME STARTING AT $DATESTAMP";

# iterate over list and pull all.
for THIS_SITE in $ALLSITES; do
  cd /$WEBSITES/$THIS_SITE;
  sh /$SCRIPTS/repo-pull.sh;
done;

echo;

#release lock
rm $LCKFILE;
