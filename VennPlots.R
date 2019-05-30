# Code for creating the VennDiagrams 
# Last modified: 30-5-2019
# Uses the VennDiagram library

# Last Modified: 30-05-2019 

# run mainMUVRcode.R first

library(VennDiagram)
#Min 
Sr_min = as.data.frame(S$Fit$plsFitMin$mat.c[,1])
VIP_min = as.data.frame(VIP$Fit$plsFitMin$mat.c[,1])

names(Sr_min) <- c("Sr")
names(VIP_min) <- c("VIP")


tabel_min = merge(VIP_min, Sr_min, by = 0, all = TRUE)
tabel_min[is.na(tabel_min)] = 0 
tabel_min[(tabel_min)!=0] = 1 

n_VIP_min = sum(tabel_min[,2])
n_SR_min  = sum(tabel_min[,3])

dubbelmid = tabel_min[,2] + tabel_min[,3]
amid = dubbelmid[dubbelmid==2]

n_VIP_SR_min = length(amid)

grid.newpage()
draw.pairwise.venn(area1 = n_VIP_min, area2 = n_SR_min, cross.area = n_VIP_SR_min, category = c("VIP",  "SR"), lty = rep("blank", 2), fill = c("light blue", "pink"), alpha = rep(0.5, 2), cat.pos = c(0, 0), cat.dist = rep(0.025, 2))


#Mid 
Sr_mid = as.data.frame(S$Fit$plsFitMid$mat.c[,1])
VIP_mid = as.data.frame(VIP$Fit$plsFitMid$mat.c[,1])

names(Sr_mid) <- c("Sr")
names(VIP_mid) <- c("VIP")


tabel_mid = merge(VIP_mid, Sr_mid, by = 0, all = TRUE)
tabel_mid[is.na(tabel_mid)] = 0 
tabel_mid[(tabel_mid)!=0] = 1 

n_VIP_mid = sum(tabel_mid[,2])
n_SR_mid  = sum(tabel_mid[,3])

dubbel = tabel_mid[,2] + tabel_mid[,3]
a = dubbel[dubbel==2]

n_VIP_SR_mid = length(a)

grid.newpage()
draw.pairwise.venn(area1 = n_VIP_mid, area2 = n_SR_mid, cross.area = n_VIP_SR_mid, category = c("VIP",  "SR"), lty = rep("blank", 2), fill = c("light blue", "pink"), alpha = rep(0.5, 2), cat.pos = c(0, 0), cat.dist = rep(0.025, 2))

#Max
Sr_max = as.data.frame(S$Fit$plsFitMax$mat.c[,1])
VIP_max = as.data.frame(VIP$Fit$plsFitMax$mat.c[,1])

names(Sr_max) <- c("Sr")
names(VIP_max) <- c("VIP")


tabel_max = merge(VIP_max, Sr_max, by = 0, all = TRUE)
tabel_max2 = merge(VIP_max, Sr_max, by = 0, all = TRUE)
tabel_max[is.na(tabel_max)] = 0 
tabel_max[(tabel_max)!=0] = 1 
tabel_max[,1] = tabel_max2[,1]

n_VIP_max = sum(tabel_max[,2])
n_SR_max  = sum(tabel_max[,3])

dubbel = tabel_max[,2] + tabel_max[,3]
a = dubbel[dubbel==2]

n_VIP_SR_max = length(a)

grid.newpage()
draw.pairwise.venn(area1 = n_VIP_max, area2 = n_SR_max, cross.area = n_VIP_SR_max, category = c("VIP",  "SR"), lty = rep("blank", 2), fill = c("light blue", "pink"), alpha = rep(0.5, 2), cat.pos = c(0, 0), cat.dist = rep(0.025, 2))