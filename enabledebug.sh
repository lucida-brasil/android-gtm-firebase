#!/bin/bash

cmd1="shell setprop debug.firebase.analytics.app br.com.zoly.firebase"
cmd2="shell setprop log.tag.FA VERBOSE"
run="run:\nadb $cmd1\nadb $cmd2"

which locate 2>\&1 > /dev/null
if [[ $? -ne 0 ]]; then
    echo -e $run;
    exit 1;
fi

adb=`locate adb|grep platform-tools|grep adb\$|head -n1`
if [[ $adb == "" || ! -x $adb ]]; then
    echo -e $run;
    exit 2;
fi

run="$adb $cmd1";
echo "Enabling debug:";
echo -n "$run";

$run 2> /dev/null;
if [[ $? -ne 0 ]]; then
    echo " - Error";
    exit 3;
fi
echo " - OK";

run="$adb $cmd2";
echo -n "$run";

$run 2> /dev/null;
if [[ $? -ne 0 ]]; then
    echo " - Error";
    exit 3;
fi

echo " - OK"
