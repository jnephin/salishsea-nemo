# open daily .RData files, calculate tidal and circulation speed and compute seasonal averages for all variables

# packages
require(abind)

# working directory
setwd('..')

# empty list for results
s.list <- list()

#---------------------------------------------------------------------------------#
# Calculate daily tidal and circulation current speed

# load u and v data
u.list <- list.files( path = "Data/Output/zbottom/u", pattern = "*.RData$", full.names = T )
v.list <- list.files( path = "Data/Output/zbottom/v", pattern = "*.RData$", full.names = T )


d.list <- list()
# for each day
for( d in 1:365 ){
  
  # load the day file
  u.dat <- get( load(u.list[[d]]) )
  v.dat <- get( load(v.list[[d]]) )
  
  # Calculate daily mean tidal current using root mean square (rms)
  uv <- u.dat^2+v.dat^2
  d.list[["mean.tidal"]][[d]] <- apply( uv, c(1,2), function(x) sqrt(mean(x)) )
  
  # Calculate daily mean circulation current 
  mean.u <- apply( u.dat, c(1,2), mean )
  mean.v <- apply( v.dat, c(1,2), mean )
  # Calculate speed from mean daily u and v
  d.list[["mean.circ"]][[d]] <- sqrt( mean.u^2 + mean.v^2 )
  
}

# calculate min and max over the year from daily values
# Get daily array
tidal.array <- abind( d.list[["mean.tidal"]], along=3 )
circ.array <- abind( d.list[["mean.circ"]], along=3 )

# Calculate min and max values 
s.list[["tidal"]][["min"]]  <- apply( tidal.array, c(1,2), min )
s.list[["tidal"]][["max"]]  <- apply( tidal.array, c(1,2), max )
s.list[["circ"]][["min"]]  <- apply( circ.array, c(1,2), min )
s.list[["circ"]][["max"]]  <- apply( circ.array, c(1,2), max )




#---------------------------------------------------------------------------------#
# for all other variables
vars <- c("salt", "temp", "nitrogen", "diatoms")

# loop through vars
for( var in vars ){

  # load data
  var.list <- list.files( path = paste0("Data/Output/zbottom/", var), pattern = "*.RData$", full.names = T )
  
  d.list <- list()
  # for each day
  for( d in 1:365 ){
    
    # load the day file
    var.dat <- get( load(var.list[[d]]) )
    # Calculate daily mean values 
    d.list[[d]]  <- apply( var.dat, c(1,2), mean, na.rm=T  )    
  }
  
  # calculate min and max over the year from daily values
  # Get daily array
  var.array <- abind( d.list, along=3 )

  # Calculate min and max values 
  s.list[[var]][["min"]]  <- apply( var.array, c(1,2), min )
  s.list[[var]][["max"]]  <- apply( var.array, c(1,2), max )
 
  
}


# Export
save( s.list, file = "Data/Output/ave/daily.minmax.RData" )
