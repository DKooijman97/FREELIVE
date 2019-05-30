%% Matlab function to create PLS model for VIP and SR comparison using the PLS toolbox
function [VIP SR sgn R] = VIP_S_R(X,Y, options)
  % Creating the PLS Model, log10 & autoscaled
  ncomp = 3;
  model = pls(X,Y,ncomp, options);

  %Calculating the VIP scores
  vip_scores = vip(model);

  %Calculating the Sr scores
  [sr,fstat,sb] = sratio(X,model);

  VIP       = vip_scores;
  SR        = sr' ;
  sgn       = sb' ;
  R         = model.reg;
end





