#!/usr/bin/env bash
#
# run global mean calculation script for all variables
#

SCENARIOS=BRCP85C5CNBDRD

#VARS='SSH SST TEMP'
VARS='SSH SST'
VARS=TEMP

for SCENARIO in ${SCENARIOS}
do
    for VAR in ${VARS} 
do
        #LISTA=`ls ./yearly/${SCENARIO}/${VAR}/b.e11.${SCENARIO}.f09*${VAR}*_yearly.nc`
        LISTA=`ls ./RCP85_projection/${VAR}/b.e11.${SCENARIO}.f09*${VAR}*_yearly_regrid.nc`
        for f in ${LISTA};
        do
            NEWVAR='GM'${VAR}
            fout=`echo ${f} | sed 's/'${VAR}'/'${NEWVAR}'/g'`
            ./global_mean_calc.sh ${VAR,,} $f ${fout} 
        done
    done
done
