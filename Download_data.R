
# working directory
setwd('..')


### Need to manually delete days that do not exist after (e.g. Feb 31st)

#---------------------------------------------------------------------------------#
# download daily u and v by hour


# download u velocity for 2017
for(m in 1:12){ # months
  for(d in 1:31){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DuGridFields1hV17-02.nc?uVelocity",
                "[(2017-",month,"-",day,"T",00,":30:00Z):1:(2017-",month,"-",day,"T",23,":30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/u/uVelocity_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}



# download v velocity for 2017
for(m in 1:12){ # months
  for(d in 1:31){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DvGridFields1hV17-02.nc?vVelocity",
                "[(2017-",month,"-",day,"T",00,":30:00Z):1:(2017-",month,"-",day,"T",23,":30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/v/vVelocity_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}


#---------------------------------------------------------------------------------#
# download daily tracer fields by hour

# salt for 2017
for(m in 1:12){ # months
  for(d in 1:31){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DTracerFields1hV17-02.nc?salinity",
                "[(2017-",month,"-",day,"T00:30:00Z):1:(2017-",month,"-",day,"T23:30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/salt/salt_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}

# temp for 2017
for(m in 4){ # months
  for(d in 28:30){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DTracerFields1hV17-02.nc?temperature",
                "[(2017-",month,"-",day,"T00:30:00Z):1:(2017-",month,"-",day,"T23:30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/temp/temp_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}


# temp for 2017
for(m in 8){ # months
  for(d in 5:31){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DTracerFields1hV17-02.nc?temperature",
                "[(2017-",month,"-",day,"T00:30:00Z):1:(2017-",month,"-",day,"T23:30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/temp/temp_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}


# temp for 2017
for(m in 11){ # months
  for(d in 22:30){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DTracerFields1hV17-02.nc?temperature",
                "[(2017-",month,"-",day,"T00:30:00Z):1:(2017-",month,"-",day,"T23:30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/temp/temp_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}


#---------------------------------------------------------------------------------#
# download daily bio fields by hour

# diatoms  for 2017
for(m in 10){ # months
  for(d in 29:31){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DBiologyFields1hV17-02.nc?diatoms",
                "[(2017-",month,"-",day,"T00:30:00Z):1:(2017-",month,"-",day,"T23:30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/diatoms/diatoms_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}


# nitrogen  for 2017
for(m in 1:12){ # months
  for(d in 1:31){ # days
    month=sprintf("%02d", m) 
    day=sprintf("%02d", d)
    furl=paste0("https://salishsea.eos.ubc.ca/erddap/griddap/",
                "ubcSSg3DBiologyFields1hV17-02.nc?dissolved_organic_nitrogen",
                "[(2017-",month,"-",day,"T00:30:00Z):1:(2017-",month,"-",day,"T23:30:00Z)]",
                "[(0.5000003):1:(441.4661)]",
                "[(0.0):1:(897.0)][(0.0):1:(397.0)]")
    try( download.file(url=furl, 
                       destfile=paste0("Data/Input/nitrogen/nitrogen_",day,"_",month,"_2017.nc"), 
                       method="wget", 
                       quiet=FALSE) 
    )
  }
}


#---------------------------------------------------------------------------------#
#grids

# download lat, long and bathymetry
bathyurl <- "https://salishsea.eos.ubc.ca/erddap/griddap/ubcSSnBathymetryV17-02.nc?bathymetry[(0.0):1:(897.0)][(0.0):1:(397.0)],latitude[(0.0):1:(897.0)][(0.0):1:(397.0)],longitude[(0.0):1:(897.0)][(0.0):1:(397.0)]"

download.file(url=bathyurl, 
              destfile="Data/Input/grid/ubcSSnBathymetryV17-02.nc", 
              method="wget", 
              quiet=FALSE)

# download depth at T-grid points
depthurl <- "https://salishsea.eos.ubc.ca/erddap/griddap/ubcSSn3DMeshMaskV17-02.nc?gdept_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)]"

download.file(url=depthurl, 
              destfile="Data/Input/grid/ubcSSn3DMeshMaskV17-02_depth.nc", 
              method="wget", 
              quiet=FALSE)

# download mask
maskurl <- "https://salishsea.eos.ubc.ca/erddap/griddap/ubcSSn3DMeshMaskV17-02.nc?tmask[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],umask[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],vmask[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],fmask[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],e3t_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],e3u_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],e3v_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],e3w_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],gdept_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],gdepu[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],gdepv[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)],gdepw_0[(2014-09-12T00:30:00Z):1:(2014-09-12T00:30:00Z)][(0.0):1:(39.0)][(0.0):1:(897.0)][(0.0):1:(397.0)]"

download.file(url=maskurl, 
              destfile="Data/Input/grid/ubcSSn3DMeshMaskV17-02_mask.nc", 
              method="wget", 
              quiet=FALSE)



