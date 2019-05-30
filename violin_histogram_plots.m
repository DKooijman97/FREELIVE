% Effect of LOG transformation on data (violin plots) 
% Violin functions downloaded from (30-5-2019): https://github.com/bastibe/Violinplot-Matlab

%% Violin plot original data
figure('Name','Original')
hold on 

violinplot(LCMSdata(:,100:110))

xlabel("Variable")
ylabel("Intensity")
hold off


%% Violin plot of log transformed data
figure('Name','Original')
hold on 

violinplot(log10(LCMSdata(:,100:110)))

xlabel("Variable")
ylabel("LOG(Intensity)")
hold off