# Code for creating scatterplots with colors based on selection

# Author: D. Kooijman 
# Last modified: 30-5-2019
# First run the mainMUVRcode.R file 

# VIP and Sr, sb and reg values calculated with matlab and imported to R via csv file. 

#Read in csv files made in Matlab
vip_scores = read.csv(file = 'vip_scores.csv')
sb = read.csv(file = 'sb.csv')
sr = read.csv(file = 'sr.csv')
reg = read.csv(file = 'reg.csv')

# Variables selected with max mode: 
Sr_max = as.data.frame(S$Fit$plsFitMax$mat.c[,1])
names(Sr_max) <- c("Sr")

VIP_max = as.data.frame(VIP$Fit$plsFitMax$mat.c[,1])
names(VIP_max) <- c("VIP")

# If variable selected with rank method corresponding element = 1
tabel_max = merge(VIP_max, Sr_max, by = 0, all = TRUE)
tabel_max2 = merge(VIP_max, Sr_max, by = 0, all = TRUE)
tabel_max[is.na(tabel_max)] = 0 
tabel_max[(tabel_max)!=0] = 1 
tabel_max[,1] = tabel_max2[,1]

#Combine selection with VIP & SR values
all = merge(vip_scores, tabel_max, by.x = "Varnames", by.y = "Row.names", all =TRUE)

all_data = cbind.data.frame(sr,vip_scores[,2],sb[,2],reg)
all_data = merge(all_data, tabel_max, by.x = "Varnames", by.y = "Row.names", all = TRUE)
names(all_data) = c("Varnames", "Sr", "VIP", "sgn", "reg", "VIP_Sel", "Sr_sel")
all_data[is.na(all_data)] = 0

#Add column with selection group
for (i in 1:1147) {
  if (all_data$VIP_Sel[i] == 1) {
    
    if (all_data$Sr_sel[i] == 1) {
      all_data$Sel[i] = "Both"
    }
    else {
      all_data$Sel[i] = "VIP"
    } 
  }
  
  else if (all_data$Sr_sel[i] == 1) {
    if (all_data$VIP_Sel[i] == 1) {
      all_data$Sel[i] = "Both"
    }
    else {
      all_data$Sel[i] = "Sr"
    } 
  }
  
  else { 
    all_data$Sel[i] = "None"
  }
}

#Scatter plots 
library(ggplot2)
REGvsVIP = ggplot(all_data, aes(x=reg,y =VIP, color = Sel ))
REGvsVIP = REGvsVIP + geom_point(size=3, shape=16, alpha = 0.5)

REGvsSr = ggplot(all_data, aes(x = reg, y = Sr, color = Sel ))
REGvsSr = REGvsSr + geom_point(size=3, shape=16, alpha = 0.5)

all_data$VIP_sgn = all_data$VIP*all_data$sgn
all_data$Sr_sgn = all_data$Sr*all_data$sgn

VIPvsSr = ggplot(all_data, aes(x=VIP_sgn,y =Sr_sgn, color = Sel ))
VIPvsSr = VIPvsSr + geom_point(size=3, shape=16, alpha = 0.5)



