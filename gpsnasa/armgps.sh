#!/bin/bash

# check if the radio transmitter works well or not
hackrf_info > /dev/null
if [ $? == 0 ]
then
    echo -e "\033[31m GPS mock ARMed, 非战斗人员立即撤退\033[0m "
    echo -e "\033[31m GPS mock ARMed, 非战斗人员立即撤退\033[0m "
    echo -e "\033[31m GPS mock ARMed, 非战斗人员立即撤退\033[0m "
    hackrf_transfer -t gpssim.bin -f 1575420000 -s 2600000 -a 1 -x 20  -R
else
    echo "Transmitter not work well, quit transfer."
    exit 1
fi

