#!/usr/bin/env bash
#
# Converts monthly values to annual values
#

VARS='SST SSH'
SCENARIOS='B20TRC5CNBDRD B1850C5CN'

for VAR in ${VARS};
do
    for SCENARIO in ${SCENARIOS};
    do
        LISTA=`ls regrid/${SCENARIO}/${VAR}/b.e11.${SCENARIO}.f09_g16.0*${VAR}*_regrid.nc`
        for f in $LISTA;
        do  
            fout=`basename ${f}`
            fout=${fout%_regrid.nc}
            fout='./yearly/'${fout}'_yearly.nc'
            cdo -P 4 --cmor yearmean  $f $fout
        done
    done
done
