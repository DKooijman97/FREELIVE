#' Performing the MUVR program on the freelive data with the VIP and selectivity ratio ranking method. 
#' Adjusted from the code included in the MUVR tutorial as downloaded on 6-5-2019 from: https://gitlab.com/CarlBrunius/MUVR 
#' Modified by: Dennis Kooijman
#' Last modification: 30-5-2019. 
#' Modified MUVR.R file, Sratio.R & plsInner.R files needed in working directory. 
#'
#' @return MUVR object
#' @export

# Call in relevant libraries, and source MUVR wrapper
library(doParallel)     # Parallel processing
library(MUVR)           # Multivariate modelling 
source("MUVR.R")

# Call in the "freelive" data from the MUVR package
data("freelive") 

# Set method parameters
nCore=detectCores()-1          # Number of processor threads to use
nRep= nCore - 1                # Number of MUVR repetitions
nOuter=  15                    # Number of outer cross-validation segments
varRatio=0.9                   # Proportion of variables kept per iteration 
method='PLS'                   # Selected core modelling algorithm
Variable_selection = "Sratio"  # Selection of variable ranking method, defaults to "vip"

# Set up parallel processing
cl=makeCluster(nCore)   
registerDoParallel(cl)

#LOG, mean centering and scaling 
XRVIP_new = XRVIP
XRVIP_new[XRVIP_new == 0] = .Machine$double.xmin           #change 0 values to smallest possible number possible with used system 
X = preProcess(XRVIP_new,scale = "UV", center = "mean", trans = 'log')

# Perform modelling
S = MUVR(X=X, Y=YR, ID=IDR, nRep=nRep, nOuter=nOuter, varRatio=varRatio, method=method, Variable_selection=Variable_selection , fitness = "RMSEP", scale = FALSE)
VIP = MUVR(X=X, Y=YR, ID=IDR, nRep=nRep, nOuter=nOuter, varRatio=varRatio, method=method, Variable_selection="vip" , fitness = "RMSEP", scale = FALSE)

# Stop parallel processing
stopCluster(cl)

#Plots 
plotVAL(S)
plotVAL(VIP)

#Calibration 
plotMV(S, model = "min")
plotMV(S, model = "mid")
plotMV(S, model = "max")

plotMV(VIP, model = "min")
plotMV(VIP, model = "mid")
plotMV(VIP, model = "max")


#Biplots
VIPFitMin = VIP$Fit$plsFitMin
biplotPLS(VIPFitMin)

VIPFitMid = VIP$Fit$plsFitMid
biplotPLS(VIPFitMid)

VIPFitMax = VIP$Fit$plsFitMax
biplotPLS(VIPFitMax)

SFitMin = S$Fit$plsFitMin
biplotPLS(SFitMin)

SFitMid = S$Fit$plsFitMid
biplotPLS(SFitMid)

SFitMax = S$Fit$plsFitMax
biplotPLS(SFitMax)
