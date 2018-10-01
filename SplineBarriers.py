# Name: SplineBarriers.py
# Description: Interpolate a series of point features onto a
#    raster using a barrier, using a minimum curvature
#    spline technique.
# Requirements: Spatial Analyst Extension and Java Runtime
# Author: Jessica Nephin

# Import system modules
import os
import arcpy
from arcpy import env
from arcpy.sa import *

var = "WC" # Bottom or WC

# Set local variables
infeature = os.getcwd()+"/Data/output/Shapefiles/SalishSea_RMS_"+var+"Speed_pts.shp"
zField = "rms"
inBarrierFeature =  os.getcwd()+"/Boundary/SOGcoastline_100m_simplified.shp"
maskFeature =  os.getcwd()+"/Boundary/SOGocean_50m.shp"
cellSize =  100.0
smoothing = 1

# Check out the ArcGIS Spatial Analyst extension license
arcpy.CheckOutExtension("Spatial")

# Execute Spline with Barriers
outSB = SplineWithBarriers(infeature, zField, inBarrierFeature, cellSize, smoothing)
# Use splitext to set the output name
outfilename = os.getcwd()+"/Data/output/Rasters/SalishSea_"+var+"_CurrentSpeed_spline.tif"
# Save the output
outSB.save(outfilename)

# Execute Mask
outMask = ExtractByMask (outSB, maskFeature)
# Use splitext to set the output name
outfilename = os.getcwd()+"/Data/output/Rasters/SalishSea_"+var+"_CurrentSpeed_mask.tif"
# Save the output
outMask.save (outfilename)

# Neighborhood
neighborhood = NbrRectangle(13, 13, "CELL")

# Execute FocalStatistics
outFocalStatistics = FocalStatistics(outMask, neighborhood, "MEAN","")

# Use splitext to set the output name
outfilename = os.getcwd()+"/Data/output/Rasters/SalishSea_"+var+"_CurrentSpeed.tif"

# Save the output
outFocalStatistics.save(outfilename)
