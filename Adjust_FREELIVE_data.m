% Creating adjusted Freelive data set by adding variables

%Setting constants and int
B1 = 1000; 
B2 = 10000; 
N = 100;
int = abs(randn(112,1));

%% Create new variables 
for i=1:112 %variables
      % Variables directly related to the response 
      test_data(i,1) = (Response(i).*B1) *(1-(abs(randn(1,1))/3)) ;
  
      % Variables directly related to a interferent which is present in random
      % concentrations
      test_data(i,2) = (int(i).*B2).*(1-(abs(randn(1,1))./100000000));
   
      % Variables related to inteferent + variable directly related to
      % response
      for j = 3:20
       test_data(i,j) = test_data(i,1)*0.2 +  test_data(i,2)*0.8;
      end
      %Variable which is only noise 
      test_data(i,21)= abs(randn(1,1));
end

% creation of LCMSdata_adjusted
LCMSdata_adjusted = [LCMSdata test_data];

