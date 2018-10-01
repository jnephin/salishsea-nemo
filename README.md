Contact
=======
Jessica Nephin    
Affiliation:  Fisheries and Oceans Canada (DFO)     
Group:        Marine Spatial Ecology and Analysis     
Location:     Institute of Ocean Sciences     
Contact:      e-mail: jessica.nephin@dfo-mpo.gc.ca | tel: 250.363.6564


Final datasets
==============
Average summer and winter bottom level variables from 2017. Variable include
tidal current speed, circulation current speed, temperature, salinity, nitrogen
and diatom concentration.


NEMO Model Overview
===================
The Salish Sea NEMO model is a three-dimensional coupled ocean biogeochemical model
for the Strait of Georgia and Salish Sea. The region covered by the model includes
the Straight of Georgia, Straight of Juan de Fuca, Johnstone Strait, Fraser River,
and other connecting waterways. The horizontal resolution is 440 m by 500 m. The
model version used (v17-02) is a hindcast from 2014 to 2018. The model has 40
z- levels which are non-unifrom depth levels that are clustered near
the surface (1m near surface to 27m near the bottom).

More information can be found here: https://salishsea.eos.ubc.ca/nemo/

Data was accessed here: https://salishsea.eos.ubc.ca/erddap/index.html


Methods
=======
Data processing was completed in R using ncdf4, abind, sp, rgdal and parallel
packages. Bottom level values for each variable were extracted using the
appropriate mask file. To calculate current speed from the u and v directional
velocities, they need to be horizontally shifted to the central nodes, which are
the rho points where salinity, temperature, nitrogen and diatom values are
located. Velocities were shifted horizontally using linear interpolation. For
circulation current, speed was calculated by taking the monthly mean of the
hourly u and v directional velocities than calculating the speed with the
equation: sqrt( mean.u^2 + mean.v^2 ). For tidal current, speed was calculated
monthly from u and v using the root mean square: sqrt( mean(u^2 + v^2) ).

Final datasets are stored as shapefiles with one file for each variable.
Point data can be interpolated to a raster dataset using the
'SplineBarriers.py' script. Smoothing the raster layers was necessary because of
some noise in the current layers.

Code for processing the model data can be found at:
https://gccode.ssc-spc.gc.ca/jnephin/NEMOSalishSeaModelProducts


Caveats
=======
Interpolated (raster) data may extend past the model domain in several
inlets, rivers and estuaries. The interpolated data should be constrained to the
modelling extent or used/interpreted with caution in those areas.


References
==========

Soontiens, N., Allen, S., Latornell, D., Le Souef, K., Machuca, I., Paquin, J.-P.,
Lu, Y., Thompson, K., Korabel, V., 2016. Storm surges in the Strait of Georgia
simulated with a regional model. Atmosphere-Ocean 54 1-21.
https://dx.doi.org/10.1080/07055900.2015.1108899

Moore-Maley, B. L., S. E. Allen, and D. Ianson, 2016. Locally-driven interannual
variability of near-surface pH and OA in the Strait of Georgia. J. Geophys. Res.
Oceans, 121(3), 1600�1625.https://dx.doi.org/10.1002/2015JC011118

Soontiens, N. and Allen, S. Modelling sensitivities to mixing and advection in a
sill-basin estuarine system. Ocean Modelling, 112, 17-32.�
https://dx.doi.org/10.1016/j.ocemod.2017.02.008


Description of model variables
==============================

temp
----
long_name: temperature   
standard_name: sea_water_conservative_temperature   
units: degC   

salt
----
long_name: salinity   
standard_name: sea_water_reference_salinity    
units: g kg-1   

nitrogen
--------
long_name: Dissolved Organic N Concentration    
standard_name: mole_concentration_of_organic_detritus_expressed_as_nitrogen_in_sea_water    
units: mmol m-3   

diatoms
-------
long_name: Diatoms Concentration    
standard_name: mole_concentration_of_diatoms_expressed_as_nitrogen_in_sea_water   
units: mmol m-3   

u velocity
----------
long_name: ocean current along x-axis    
standard_name: sea_water_x_velocity    
units: m/s    

v velocity
----------
long_name: ocean current along y-axis    
standard_name: sea_water_y_velocity    
units: m/s   