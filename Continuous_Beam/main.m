clc;
clear all;
load input.mat
load data.mat
dfile ='Results.txt';
if exist(dfile, 'file');
  delete(dfile); 
endif 
diary(dfile)
diary on
StaadTable= [csvread('Staad4.csv',1,0)];
[K] = Xumax (Es,Fy);
[XDim,YDim,de_beam,Ce,dia_st,C_cc,de_cr,r,c,dia_Anchorage] = Dimensions (Span,d,de_c,Cc,Cc_Data,dia_1,dia_2,dia_3,dia_3Data,dia_4,dia_4Data,R,Shut,D,B,StaadTable);[Esc,Fsc] = EscFsc (de_cr,K,de_beam,Es,Fy,Fsc_415,Fsc_500);
[Ast_max,Ast_min] = MaxMinSteel (XDim, de_beam,Fy,YDim);
[Mu,Vu,Mu_Lim] = MomentShear (StaadTable,Fck,K,XDim,de_beam);
[P_Moment,N_Moment,Section,TotalSteel_Required_Positive,TotalSteel_Required_Negative,Total_Steel_Required,Total_Steel_Provided,Total_Steel_Provided_TensionPositive,Total_Steel_Provided_CompressionNegative,Total_Steel_Provided_TensionNegative,Total_Steel_Provided_CompressionPositive,N_TensionPositive,N_CompressionPositive,N_TensionNegative,N_CompressionNegative,Total_Steel_Required_Bottom] = SteelRequirement (r,Mu,Mu_Lim,Fck,Fy,XDim,de_beam,K,de_cr,Fsc,dia_1,dia_2,Ast_min,Ast_max);
[Lo,Distance_of_ZeroMoment] = Zero_Moment_Distance (r,Mu,StaadTable,dia_1,de_beam);
[Required_Curtailment_Bottom,Required_Curtailment_Top] = Curtailment (Distance_of_ZeroMoment, Lo);
[Bars_TensionNegative,Bars_CompressionNegative,Max_N_TensionNegative,Max_N_CompressionNegative] = Bars_Bottom (N_TensionNegative, N_CompressionNegative);
[Max_N_CompressionPositive,Max_N_TensionPositive,Bars_TensionPositive,Bars_CompressionPositive,Section_Disptance] = Bars_Top (StaadTable,N_TensionPositive, N_CompressionPositive);
Curtailment_Destails
[N_TensionNegative,N_CompressionNegative, N_TensionPositive,N_CompressionPositive,Total_Steel_Provided,Total_Steel_Provided_Top,Total_Steel_Provided_Bottom]=Bars(Section,dia_1,dia_2,Max_N_TensionPositive,Bars_CompressionPositive,Bars_TensionPositive,Required_Curtailment_Top,r,Section_Disptance,Required_Curtailment_Bottom,Bars_TensionNegative,Bars_CompressionNegative,Max_N_TensionNegative);
[SpTP_Provided_1,SpTP_Provided_2,Layers_TP,N_TensionPositive_1,N_TensionPositive_2,SpCP_Provided_1,SpCP_Provided_2,Layers_CP,N_CompressionPositive_1,N_CompressionPositive_2,Sp_min] = Spacing_Positive (r,XDim,Ce,N_TensionPositive,dia_2,Sa,N_CompressionPositive);
[SpTN_Provided_1,SpTN_Provided_2,Layers_TN,N_TensionNegative_1,N_TensionNegative_2,SpCN_Provided_1,SpCN_Provided_2,Layers_CN,N_CompressionNegative_1,N_CompressionNegative_2] = Spacing_Negative (N_CompressionNegative,r,XDim,Ce,N_TensionNegative,dia_1,Sa,Sp_min);
[Total_Steel_Provided_TensionNP] = Total_Steel_NP (r,N_TensionPositive,N_TensionNegative,dia_1);
[N_st,Tc_max,Asv] = Shear (Fck, Maximum_Shear_Stress,dia_st,N_st);
[Nominal_Shear_Stress,Pt_P,Design_Shear_Stress,Sr_R, Sv_P] = Shear_Check (Asv,Fck,Fy,Total_Steel_Provided_TensionNP, XDim,de_beam,Vu,r,Design_Shear_Strength,Design_Shear_Strength_1,Design_Shear_Strength_2);
[LD_maximum,LD_provided,Check_2] = Deflection_Check (r,XDim,de_beam,Fy,Total_Steel_Provided_TensionNP,Total_Steel_Provided_Top,Total_Steel_Required_Bottom,Span,Modification_Factor_2);
[AA_1,BB_1 W_cr] = Crack_Width (Mu,C_cc,r,SpTN_Provided_1,Ce,dia_1,Sigma_cbc,Fck,Total_Steel_Provided_TensionNP,XDim,de_beam,YDim,Es);
[Ld] = Development_Length (N_TensionNegative,Vu,Tbd_1,Tbd_switch,Fck,dia_1,Mu,Section_Disptance,K,Fy,de_beam,Ast_min,Distance_of_ZeroMoment,XDim);
[MOR_Top,MOR_Bottom] = MOR (r,Fy,de_beam,XDim,Fck,Total_Steel_Provided_Top,Total_Steel_Provided_Bottom);
Figures (r,StaadTable,MOR_Top,MOR_Bottom);
diary off
open Results.txt
