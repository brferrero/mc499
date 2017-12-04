import numpy as np
import datetime as dt
from netCDF4 import Dataset
import matplotlib.pyplot as plt

filename = 'climatology/climatology_timseries.nc'
nc = Dataset(filename, 'r') 
sst1920 = nc.variables['sst_climatology_1920'][:]
sst1950 = nc.variables['sst_climatology_1950'][:]
sst1980 = nc.variables['sst_climatology_1980'][:]
sst2020 = nc.variables['sst_climatology_2020'][:]
sst2050 = nc.variables['sst_climatology_2050'][:]
sst2080 = nc.variables['sst_climatology_2080'][:]
nc.close()
plt.figure(figsize=(8,8),dpi=90)

xlabels=['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez' ]
xdummy=range(1,13)

plt.plot(xdummy,sst1920,color='c',lw=1.5,alpha=1,label='1920')
plt.plot(xdummy,sst1950,color='dodgerblue',lw=1.5,alpha=1,label='1950')
plt.plot(xdummy,sst1980,color='darkblue',lw=1.5,alpha=1,label='2000')
plt.plot(xdummy,sst2020,color='indianred',lw=1.5,alpha=1,label='2020')
plt.plot(xdummy,sst2050,color='red',lw=1.5,alpha=1,label='2050')
plt.plot(xdummy,sst2080,color='darkred',lw=1.5,alpha=1,label='2080')
plt.xticks(xdummy, xlabels)
plt.ylabel('Temperatura (C)',fontsize=16)
plt.xlim(0, 13)
#plt.ylim(17.5, 21)
plt.legend(frameon=True)
plt.grid(True)
#plt.show()
plt.savefig('plot_climatology.png',format='png', bbox_inches=0)
