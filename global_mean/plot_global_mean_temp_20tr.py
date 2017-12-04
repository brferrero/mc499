import numpy as np
import datetime as dt
from netCDF4 import Dataset
import matplotlib.pyplot as plt
from lens_tools import *

basedir = './yearly/B20TRC5CNBDRD/GMTEMP'

plt.figure(figsize=(8,9),dpi=90)
d0 = dt.date(1920,01,01)

for i in range(2,36):
    fi = str('%03d' % i)
    f = 'b.e11.B20TRC5CNBDRD.f09_g16.'+fi+'.pop.h.GMTEMP.192001-200512_yearly.nc'
    print f
    nc_fname = basedir + '/' + f
    nc = Dataset(nc_fname, 'r') 
    # Extract variables from NetCDF file
    time = nc.variables['time'][:]           # "days since 0000-01-01"
    gmtemp = nc.variables['gmtemp'][:]
    nc.close()
    #gmtemp_smooth = smooth(gmtemp,365,'hanning')

    if i == 2:
        ntime = (time - time[0]) + d0.toordinal()
        dtime = np.zeros(time.size, int);
        #ensmean = np.zeros(time.size)
        ensmean = gmtemp
        dateList = []
        for j in np.arange(time.size):
            data=dt.datetime.fromordinal(int(ntime[j]))
            dateList.append(data)

    ensmean = (ensmean+gmtemp)/2
    plt.plot(dateList,gmtemp,color='blue',alpha=0.2)

plt.plot(dateList,ensmean,color='navy',lw=2,alpha=1)
plt.ylabel('Temperatura (C)',fontsize=16)
plt.title('Temperatura global media',fontsize=16)
plt.xlim(dt.datetime(1920,1,1), dt.datetime(2009,12,31))
plt.ylim(3.76, 3.81)
plt.grid(True)
plt.savefig('plot_global_mean_temp_20tr.png',format='png', bbox_inches=0)
plt.show()
