#
# Lorenz Attractors
# 
# inspired by:
# https://scipython.com/blog/the-lorenz-attractor/
# https://github.com/gboeing/lorenz-system/blob/master/lorenz-system-attractor-animate.ipynb
#
import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Lorenz paramters and initial conditions
sigma, beta, rho = 10, 2.667, 28
u0, v0, w0 = 0, 1, 1.05
u1, v1, w1 = 0, 1.1, 1.15

# Maximum time point and total number of time points
tmax = 50 
n = 10000

def lorenz(X, t, sigma, beta, rho):
    """The Lorenz equations."""
    u, v, w = X
    up = -sigma*(u - v)
    vp = rho*u - v - u*w
    wp = -beta*w + u*v
    return up, vp, wp

# Integrate the Lorenz equations on the time grid t
t = np.linspace(1, tmax, n)
f1 = odeint(lorenz, (u0, v0, w0), t, args=(sigma, beta, rho))
f2 = odeint(lorenz, (u1, v1, w1), t, args=(sigma, beta, rho))
x1, y1, z1 = f1.T
x2, y2, z2 = f2.T

# Make the line multi-coloured by plotting it in segments of length s which
# change in colour across the whole time series.
s = 2
c = np.linspace(0,1,n)
save_folder = 'fig'

frame_count = 1
for i in range(0,n-s,s):
    fig = plt.figure(figsize=(6,6),dpi=90)
    ax1 = fig.add_subplot(1,1,1, projection='3d')
    ax1.plot(x1[0:i+s+1], y1[0:i+s+1], z1[0:i+s+1], color='blue', alpha=0.9)
    ax1.plot(x2[0:i+s+1], y2[0:i+s+1], z2[0:i+s+1], color='red', alpha=0.9)
    ax1.set_xlim((-20,20))
    ax1.set_ylim((-20,20))
    ax1.set_zlim((0,45))
    ax1.set_axis_off()
    plt.savefig(save_folder + '/fig_' + ('%05d' % frame_count) + '.png', bbox_inches='tight', pad_inches=0.1)
    frame_count += 1
    plt.close()
