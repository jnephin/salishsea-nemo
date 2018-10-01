# open daily .RData files, calculate tidal and circulation speed and compute seasonal averages for all variables

# packages
require(abind)

# working directory
setwd('..')

# empty list for results
s.list <- list()

#---------------------------------------------------------------------------------#
# Calculate seasonal tidal and circulation current speed

# load u and v data
u.list <- list.files( path = "Data/Output/zbottom/u", pattern = "*.RData$", full.names = T )
v.list <- list.files( path = "Data/Output/zbottom/v", pattern = "*.RData$", full.names = T )

# get months
mnths <- sub(sub("_.*","",u.list)[1], "", u.list)
mnths <- substr(mnths, 5,6)

m.list <- list()
# for each month
for( m in unique(mnths) ){
  
  # load each file into a list
  u.dat <- lapply( u.list[mnths == m], function(x) get(load(x)) )
  v.dat <- lapply( v.list[mnths == m], function(x) get(load(x)) )
  
  # Get monthly array
  u.array <- abind( u.dat, along=3 )
  v.array <- abind( v.dat, along=3 )
  
  # Calculate monthly mean tidal current using root mean square (rms)
  uv <- u.array^2+v.array^2
  m.list[["mean.tidal"]][[m]] <- apply( uv, c(1,2), function(x) sqrt(mean(x)) )
  
  # Calculate monthly mean circulation current 
  mean.u <- apply( u.array, c(1,2), mean )
  mean.v <- apply( v.array, c(1,2), mean )
  # Calculate speed from mean monthly u and v
  m.list[["mean.circ"]][[m]] <- sqrt( mean.u^2 + mean.v^2 )
  
}

# convert months to seasons (sum or win)
seasons <- rep("win", length(names(m.list[["mean.tidal"]])))
seasons[names(m.list[["mean.tidal"]]) %in% c("04","05","06","07","08","09")] <- "sum"

# seasonal means from monthly means
for( s in unique(seasons) ){
  
  # Get monthly indices for s
  ind <- which(seasons == s)
  
  # Get seasonal array
  tidal.array <- abind( m.list[["mean.tidal"]][ind], along=3 )
  circ.array <- abind( m.list[["mean.circ"]][ind], along=3 )
  
  # Calculate seasonal mean values 
  s.list[["tidal"]][[s]]  <- apply( tidal.array, c(1,2), mean )
  s.list[["circ"]][[s]] <- apply( circ.array, c(1,2), mean )
  
}



#---------------------------------------------------------------------------------#
# for all other variables
vars <- c("salt", "temp", "nitrogen", "diatoms")

# loop through vars
for( var in vars ){

  # load data
  var.list <- list.files( path = paste0("Data/Output/zbottom/", var), pattern = "*.RData$", full.names = T )

  # get months
  mnths <- sub(sub("_.*","",var.list)[1], "", var.list)
  mnths <- substr(mnths, 5,6)
  
  m.list <- list()
  # monthly means of hourly values
  for( m in unique(mnths) ){
    
    # load each file into a list
    var.dat <- lapply( var.list[mnths == m], function(x) get(load(x)) )
    
    # Get monthly array
    var.array <- abind( var.dat, along=3 )
    
    # Calculate monthly mean values 
    m.list[[m]]  <- apply( var.array, c(1,2), mean, na.rm=T  )
    
  }
  
  # convert months to seasons (sum or win)
  seasons <- rep("win", length(names(m.list)))
  seasons[names(m.list) %in% c("04","05","06","07","08","09")] <- "sum"
  
  # seasonal means from monthly means
  for( s in unique(seasons) ){
    
    # Get monthly indices for s
    ind <- which(seasons == s)
    
      # Get seasonal array
    var.array <- abind( m.list[ind], along=3 )
    
    # Calculate seasonal mean values 
    s.list[[var]][[s]]  <- apply( var.array, c(1,2), mean )
    
  }
  
}


# Export
save( s.list, file = "Data/Output/ave/seasonal.means.RData" )
