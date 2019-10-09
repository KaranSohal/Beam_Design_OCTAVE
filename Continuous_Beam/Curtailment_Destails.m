fprintf('\n')
disp(['Provide ' num2str(Bars_TensionNegative) ' bars throughout the span along bottom face'])
disp(['Provide ' num2str(Max_N_TensionNegative) ' bars from ' num2str(Required_Curtailment_Bottom(1,1)) ' upto ' num2str(Required_Curtailment_Bottom(1,2)) ' from left support'])  

disp(['Provide ' num2str(Bars_TensionPositive) ' bars throughout the span along Top face'])
disp(['Provide ' num2str(Max_N_TensionPositive) ' bars from ' num2str(Section_Disptance(1)) ' to ' num2str(Required_Curtailment_Top(1,1)) ' and ' num2str(Required_Curtailment_Top(1,2)) ' to ' num2str(Section_Disptance(r))  ' from left support'])
fprintf('\n')