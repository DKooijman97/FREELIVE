%% Matlab code to create PLS model for VIP and SR comparison using the PLS toolbox
% Results are 4 csv files containing reg, sr, vip and sgn values
% Loading of the freelife dataset
load('Freelife_data.mat');

% Creating the PLS Model
x = LCMSdata;
y = Response;
ncomp = 3;
options = pls('options');
options.preprocessing = preprocess;
model = pls(x,y,ncomp, options);

%Calculating the VIP scores
vip_scores = zeros(size(LCMSdata,2));
vip_scores = vip(model);
vip_scores = table(Varnames,vip_scores );

%Calculating the Sr scores
[sr,fstat,sb] = sratio(x,model);
sr = table(Varnames,sr');
sb = table(Varnames,sb');

%Extracting reg scores from pls object 
reg = model.reg;
reg = table(Varnames, reg);

%Write variables to csv file in order to export to R
writetable(sr, "sr.csv")
writetable(vip_scores, "vip_scores.csv")
writetable(sb, "sb.csv")
writetable(reg, "reg.csv")






