% Loop repeating the adjusting of the freelive data
% After loop de new data is plotted scatter plots

% Loop repeating the adjustment of the FREELIVE data and the fitting of the
% model
Adjust_FREELIVE_data
len = size(LCMSdata_adjusted,2);
reps = 100

VIP_FINAL = zeros(len, reps);
SR_FINAL  = zeros(len, reps);
sgn_FINAL = zeros(len, reps);
R_FINAL   = zeros(len, reps);

options_LOG_AUTOSCALE = pls('options')
options_LOG_AUTOSCALE.preprocessing = preprocess;
options_LOG_AUTOSCALE.display = 0
options_LOG_AUTOSCALE.plots = "off"

 for z = 1:reps
     Adjust_FREELIVE_data;
     [VIP SR sgn R] = VIP_S_R(LCMSdata_adjusted,Response,options_LOG_AUTOSCALE);
     VIP_FINAL(:,z) = VIP; 
     SR_FINAL(:,z)  = SR;
     sgn_FINAL(:,z) = sgn;
     R_FINAL(:,z)   = R;
 end
 
%% PLOTS OF THE ADJUSTED DATA 
%% VIP vs. SR
%plot VIP vs. SR with the created variables highlighted
sr_sgn = SR_FINAL.*sgn_FINAL;
VIP_sgn = VIP_FINAL.*sgn_FINAL;
figure('Name','VIP vs. SR ');
 
xlabel("VIP");
ylabel("Sratio");
hold on 
scatter(VIP_sgn(1:1147,1),sr_sgn(1:1147,1), 'r')    %Only included for one rep, otherwise added variables would not be visible
for i = 1:reps
 scatter(VIP_sgn(1148,i),sr_sgn(1148,i),'g')
 scatter(VIP_sgn(1149,i),sr_sgn(1149,i),'b')
 scatter(VIP_sgn(1150,i),sr_sgn(1167,i),'black')
 scatter(VIP_sgn(1168,i),sr_sgn(1168,i),'cyan');legend('Original','Analyte+noise ','Analyte+Interference+noise','Interference+noise','Noise')
end 
hold off


 %% VIP vs.REG
%plot VIP vs. REG with the created variables highlighted
sr_sgn = SR_FINAL.*sgn_FINAL;
VIP_sgn = VIP_FINAL.*sgn_FINAL;
figure('Name','VIP vs. SR ');
 
xlabel("Reg. coef");
ylabel("VIP");
hold on 
scatter(R_FINAL(1:1147,1),VIP_FINAL(1:1147,1), 'r')
for i = 1:reps
 scatter(R_FINAL(1148,i),VIP_FINAL(1148,i),'g')
 scatter(R_FINAL(1149,i),VIP_FINAL(1149,i),'b')
 scatter(R_FINAL(1150,i),VIP_FINAL(1167,i),'black')
 scatter(R_FINAL(1168,i),VIP_FINAL(1168,i),'cyan');legend('Original','Analyte+noise ','Interference+noise','Analyte+Interference+noise','Noise')
end 
hold off

 %% SR vs.REG
%plot VIP vs. REG with the created variables highlighted
sr_sgn = SR_FINAL.*sgn_FINAL;
VIP_sgn = VIP_FINAL.*sgn_FINAL;
figure('Name','VIP vs. SR ');
 
xlabel("Reg. coef");
ylabel("SR");
hold on 
scatter(R_FINAL(1:1147,1),SR_FINAL(1:1147,1), 'r')
for i = 1:reps
 scatter(R_FINAL(1148,i),SR_FINAL(1148,i),'g')
 scatter(R_FINAL(1149,i),SR_FINAL(1149,i),'b')
 scatter(R_FINAL(1150,i),SR_FINAL(1167,i),'black')
 scatter(R_FINAL(1168,i),SR_FINAL(1168,i),'cyan');legend('Original','Analyte+noise ','Interference+noise','Analyte+Interference+noise','Noise')
end 
hold off
