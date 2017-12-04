#!/usr/bin/env bash
#
# curv to rect remap
#

SCENARIOS='1850_control 20TR_historical'
VARS='SST SSH TEMP'
GRID='r360x180'
for SCENARIO in ${SCENARIOS}; 
do
    for VAR in ${VARS}; 
    do
        DIR=/chuva/db2/CESM-LENS/fully_coupled/mon/OCN/${VAR}/${SCENARIO}/
        for f in `ls ${DIR} | grep 'CN'`;
        do
            out=${f%.nc}_regrid.nc
            if [ "$VAR"  == "TEMP" ];
            then
                cdo -P 2 --cmor remapbil,${GRID} ${DIR}${f} regrid/${out}
            else    
                cdo -P 2 --cmor --reduce_dim remapbil,${GRID} ${DIR}${f} regrid/${out}
            fi
        done
    done
done
