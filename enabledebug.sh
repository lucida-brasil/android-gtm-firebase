#!/bin/bash

cmd="shell setprop debug.firebase.analytics.app br.com.zoly.firebase"
run="run: adb $cmd"

which locate 2>\&1 > /dev/null
if [[ $? -ne 0 ]]; then
    echo $run;
    exit 1;
fi

adb=`locate adb|grep platform-tools|grep adb\$|head -n1`
if [[ $adb == "" || ! -x $adb ]]; then
    echo $run;
    exit 2;
fi

run="$adb $cmd"
echo "Enabling debug:";
echo -n "$run";

$run 2> /dev/null
if [[ $? -ne 0 ]]; then
    echo " - Error";
    exit 3;
fi

echo " - OK"
