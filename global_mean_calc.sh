#!/usr/bin/env bash
#
# calculate global mean weighted average for a given variable
# create & execute a Ferret script file
#


VAR=$1
INPUT=$2
OUTPUT=$3

cat <<EOF > global_mean_tmp.jnl
can mode logo; can mode upcase
set mem/size=10000

define symbol var = ${VAR}
define symbol file_in = ${INPUT}
define symbol file_out = ${OUTPUT}

use (\$file_in)

let gm(\$var) = (\$var)[x=@ave,y=@ave,z=@ave]
set att/like=(\$var) gm(\$var)

save/clobber/outtype=float/file="(\$file_out)" gm(\$var)

EOF

ferret -server -nojnl -script global_mean_tmp.jnl
rm -f global_mean_tmp.jnl
