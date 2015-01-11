# Plot all plots on a single sheet

# Load in the common code to load the dataset, along with the generator
# functions for the two plots we reuse.
source("loadData.R")
source("plot2.R")
source("plot3.R")

# Plot a single line graph
#
# x - x co-ordinate values
# y - Y co-ordinate values
# ylabtext - Text for labeling the y axis
plotOther <- function (x, y, ylabtext ) {
  # Plot the chart, suppressing the x axis
  p1 <- plot(x, y, 
             main= "", 
             ylab=ylabtext, 
             type = "l",
             xaxt = "n",
             xlab=""
  )
  
  # Add the axes to the plot
  axis(1, 
       at=c(min(x),median(x),max(x)),
       labels=c("Thu", "Fri", "Sat"), 
       tick=TRUE, outer=FALSE)
  axis(2, at=axTicks(2),labels=TRUE, tick=TRUE, outer=FALSE)
  
}

# Produce s single combine plot showing four different views on the data
#
# Specify useScreen=TRUE to display the result. Otherwise, the graph is saved in
# the file 'plot4.png'

makePlot4<-function(useScreen=FALSE){
  if (!useScreen) {
    # Open the PNG graphics device if display not requested
    png("plot4.png")
  }

  # Load the data
  dt <- getCleanData()
  
  # Set up for a 2x2 grid
  par(mfcol=c(2,2))
  
  # First re-use the earlier graphs. Specifying useScreen=TRUE causes them
  # to draw on the current device.
  makePlot2(TRUE, FALSE)
  makePlot3(TRUE, FALSE)
  
  # Now add the lne graphs for Voltage and Global Reactive Power
  plotOther(dt$sample, dt$Voltage, "Voltage")
  plotOther(dt$sample, dt$Global_reactive_power, "Global_reactive_power")
  
  if (!useScreen){
    # Close the PNG device if it's open
    dev.off()
  }
  
  # The function has no value
  NULL
  
}