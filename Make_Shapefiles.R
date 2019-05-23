# required packages
require(ncdf4)
require(raster)
require(rgdal)
require(rgeos)

# working directory
setwd('..')

# projections
latlon <- "+proj=longlat +datum=WGS84"
bcalbers <- "+proj=aea +lat_1=50 +lat_2=58.5 +lat_0=45 +lon_0=-126 +x_0=1000000 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs" 

#------------------------------------------------------------------------------------#

# bathy file
bfile <- "Data/Input/grid/ubcSSnBathymetryV17-02.nc"
# open bathy nc file
geonc <- nc_open(filename=bfile)

# get nc variables
long <- ncvar_get(geonc, varid="longitude")
lat <- ncvar_get(geonc, varid="latitude")
bathy <- ncvar_get(geonc, varid="bathymetry")

# remove first row and first column to match unstaggered u & v velocity
long <- long[-1,-1]
lat <- lat[-1,-1]
bathy <- bathy[-1,-1]

# melt
long <- c(long)
lat <- c(lat)
bathy <- c(bathy)

#bind together
dat <- data.frame(long,lat, bathy=bathy)

# remove NA records
dat <- dat[!is.na(dat$bathy),]

# convert to sp
spdat <- dat
coordinates(spdat) <- ~long+lat
proj4string(spdat) <- CRS(latlon)
spdat <- spTransform(spdat, bcalbers)
spplot(spdat)

# save
writeOGR(spdat,dsn="Data/Output/Shapefiles",layer="SalishSeaModel_Depth",
         driver = "ESRI Shapefile", overwrite_layer = TRUE)




#------------------------------------------------------------------------------------#
# load seasonal means data
load("Data/Output/ave/seasonal.means.RData" ) # s.list

for ( var in names(s.list) ){
  for ( s in c("sum","win") ){
    
    # bind together x,y,var
    dat <- data.frame( long,lat, var=c(s.list[[var]][[s]]) )
    
    # remove NA records
    dat <- dat[!is.na(dat$var),]
    
    # rename var
    varname <-  paste(var, s, sep = "_")
    names(dat)[3] <- varname
    
    # convert to sp
    spdat <- dat
    coordinates(spdat) <- ~long+lat
    proj4string(spdat) <- CRS(latlon)
    spdat <- spTransform(spdat, bcalbers)
    spplot(spdat)
    
    # save
    writeOGR(spdat,dsn="Data/Output/Shapefiles",layer=varname,
             driver = "ESRI Shapefile", overwrite_layer = TRUE)
    
  }
}




#------------------------------------------------------------------------------------#
# load seasonal means data
load("Data/Output/ave/daily.minmax.RData" ) # s.list

for ( var in names(s.list) ){
  for ( s in c("min","max") ){
    
    # bind together x,y,var
    dat <- data.frame( long,lat, var=c(s.list[[var]][[s]]) )
    
    # remove NA records
    dat <- dat[!is.na(dat$var),]
    
    # rename var
    varname <-  paste(var, s, sep = "_")
    names(dat)[3] <- varname
    
    # convert to sp
    spdat <- dat
    coordinates(spdat) <- ~long+lat
    proj4string(spdat) <- CRS(latlon)
    spdat <- spTransform(spdat, bcalbers)
    spplot(spdat)
    
    # save
    writeOGR(spdat,dsn="Data/Output/Shapefiles",layer=varname,
             driver = "ESRI Shapefile", overwrite_layer = TRUE)
    
  }
}





