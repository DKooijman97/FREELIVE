#' Get PLS Sratio values
#' Author: Dennis Kooijman
#' Last modification: 30-5-2019
#' 
#' Calculates the selectivity ratio in order to rank variables, as alternitive
#' to the VIP approach. Based on the orginal vip module of the MUVR algorithm (as downloaded on 6-5-2019). 
#'
#' Saves the Sratio in a vip object because this object has central role through out the MUVR module.
#' 
#' @param object pls(da) object
#'
#' @return vip object (in which the Sratio is stored)
#' @export

Sratio <- function(object) {
  #-- initialisation of needed matrices --#
  #b = object$mat.c                   # Matrix with coefficients (nrow = number of variables, ncol = number of PCs)
  H = object$ncomp                    # H is number of latent variables (componements)      
  X = object$X                        # The preprocessed X-data
  scores  =  object$variates$Y        # Scores (t)
  loadings = object$loadings$X        # Loadings (p)
  
  #Getting number of samples and variables
  n = nrow(X)  
  nVariables = ncol(X)
  
  # Initialization of Sratio matrix  
  Sratio = matrix(0, nrow = nVariables, ncol = 1 )
  
  # Calculation of Sratio per variable 
  SS_explained = (scores%*%t(loadings))^2
  
  SS_explained = colSums(SS_explained)
  SS_unexplained = colSums((X-scores%*%t(loadings)^2)); 
  
  for (i in 1:nVariables) {
    Sratio[i,]=SS_explained[i]/SS_unexplained[i]
    }
  
  # Returning Sratio in VIP object 
  rownames(Sratio) = rownames(loadings)
  colnames(Sratio)= "Comp 1"
  
  return(invisible(Sratio))
}
