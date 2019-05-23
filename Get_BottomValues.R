# open nc, get variables at the bottom z layer and unstagger (u,v to t nodes)

# working directory
setwd('..')

# variable
vars <- c("temp", "nitrogen", "diatoms","u","v", "salt")


#---------------------------------------------------------------------------------#
# function

# open nc, get variables at the bottom layer, unstagger (u,v to t)
bottomlev <- function(varfile){
  
  #require
  require(ncdf4)
  require(abind)

  # open nc
  nc <- nc_open(filename=varfile)
  # get nc variables, count = x,y,z,t, where z=1 is the surface layer
  if(var == "u" | var == "v") varid=paste0(var,"Velocity")
  if(var == "u" | var == "v") varid=paste0(var,"Velocity")
  if(var == "temp") varid="temperature"
  if(var == "salt") varid="salinity"
  if(var == "diatoms") varid="diatoms"
  if(var == "nitrogen") varid="dissolved_organic_nitrogen"
  vel <- ncvar_get(nc, varid=varid, start=c(1,1,1,1), count=c(398,898,40,24))
  # close nc
  nc_close(nc)
  
  # open mask
  maskfile=paste0("Data/Input/grid/ubcSSn3DMeshMaskV17-02_mask.nc")
  ncmask <- nc_open(filename=maskfile)
  if(var == "u"){
    mask <- ncvar_get(ncmask, varid='umask')
  } else if(var == "v"){
    mask <- ncvar_get(ncmask, varid='vmask')
  } else {
    mask <- ncvar_get(ncmask, varid='tmask')
  }
  # close ncmask
  nc_close(ncmask)
  
  # get index of bottom cells
  cummask <- aperm(apply(mask, 1:2, cumsum), c(2,3,1)) 
  maxmask <- apply(cummask, c(1,2), function(x) which.max(x))
  lev <- c(maxmask)
  
  # sample array using index from bottom depth matrix
  index <- as.matrix(cbind(expand.grid(1:dim(vel)[1],1:dim(vel)[2]),zlev=lev))
  index <- as.matrix( merge(index, 1:24) )
  velbot <- array( vel[index], dim=dim(vel)[c(1,2,4)] )
  
  # convert zeros to NA (need to before unstagger)
  velbot[velbot == 0] <- NA
  
  # Linear interpolation to unstagger u and v and place in the 
  # center of the node (T) to match the lat, long coordinates.
  if(var == "u"){
    var_array <- abind(velbot[,-1,], velbot[,-ncol(velbot),], along=4) # rem first col, rm last col
    var_t <- apply(var_array , 1:3, mean, na.rm=T )
    var_t <- var_t[-1,,] # remove first row, because you count up from the bottom on the NEMO grid
  } else if(var == "v"){
    var_array <- abind(velbot[-1,,], velbot[-nrow(velbot),,], along=4) # rem first row, rm last row
    var_t <- apply(var_array , 1:3, mean, na.rm=T )
    var_t <- var_t[,-1,] # remove first column
  } else {
    var_t <- velbot[-1,,] # remove first row, because you count up from the bottom on the NEMO grid
    var_t <- var_t[,-1,] # remove first column
  }
  
  # export
  outfile <- sub("Input", "Output/zbottom", varfile)
  outfile <- sub(".nc", ".RData", outfile)
  save( var_t, file = outfile )
  
  # reset
  gc(reset=T)
}


#---------------------------------------------------------------------------------#
# for each variable
for( var in vars ){
  
  # Create output directory
  dir.create(path=paste0("Data/Output/zbottom/", var ), recursive = T)
  
  # list files
  file.list <- list.files(path = paste0("Data/Input/",var), pattern = "*.nc$", full.names = T )
  
  # run in parallel apply
  cl <- parallel::makeCluster(parallel::detectCores() - 1)
  ## make variables available to cluster
  parallel::clusterExport(cl, varlist=c("var"))
  # run on cluster
  predlist <- parallel::parLapply(cl, file.list, bottomlev)
  ## stop cluster
  parallel::stopCluster(cl)
  
}


#---------------------------------------------------------------------------------#
# get unit of each variable

#require
require(ncdf4)


for( var in vars ){
  
  # list files
  file.list <- list.files(path = paste0("Data/Input/",var), pattern = "*.nc$", full.names = T )

  # open nc
  nc <- nc_open(filename=file.list[1])
  
  # print
  print(nc)
  nc_close(nc)
  
  
}


