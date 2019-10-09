clc;
clear all;
load input.mat
load data.mat
dfile ='Results.txt';
if exist(dfile, 'file');
  delete(dfile); 
endif 
diary(dfile )
diary on
StaadTable= [csvread('Staad.csv',1,0)];
[K] = Xumax (Es, Fy);
[XDim,YDim,de_beam,Ce,dia_st,C_cc,Span,de_cr,dia_Anchorage,r,c] = Dimensions (Span, Cc_Data,d,Cc,dia_1,dia_2,dia_3Data,dia_3,D,B,R,Shut,de_c,dia_4Data,dia_4,StaadTable);
[Mu,Vu,Mu_Lim] = MomentShear (StaadTable, Fck,K,XDim,de_beam);
[Esc,Fsc] = EscFsc(de_cr,K,de_beam, Fy,Es,Fsc_415,Fsc_500);
[Ast_min,Ast_max] = MaxMinSteel (XDim, de_beam,Fy,YDim);
[Steel,TotalSteel_Required,TotalSteel_Provided,N_Tension,N_Compression,AreaR_Tension,AreaP_Tension,AreaP_Compression] = SteelRequirement (r,Mu,Mu_Lim,Fck,Fy,XDim,de_beam,K,de_cr,dia_1,dia_2,Ast_min,Ast_max,Fsc);
[AreaP_Anchorage,Nst_3,Nsc_5,AreaP_Tension_2] = SteelDistribution (TotalSteel_Required,StaadTable,Steel,AreaP_Compression,r,dia_1,dia_2,dia_Anchorage ,TotalSteel_Provided,AreaP_Tension);
[Spacing_Tension_1,Spacing_Tension_2,Spacing_Compression_1,Spacing_Compression_2,Layers_Tension,Layers_Compression,Bars_T_1,Bars_T_2,Bars_C_1,Bars_C_2,SpT_Vertical,SpC_Vertical] = Spacing (r,Nst_3,XDim,Ce,dia_1,dia_2,Sa,Nsc_5);
[Tc_max,Asv] = Shear (Maximum_Shear_Stress, Fck,N_st,dia_st);
[Tc,Nominal_Shear_Stress,Design_Shear_Stress,Pt_P,Sr_R,Sv_P] = ShearCheck (AreaP_Tension_2, XDim,de_beam,r,Vu,Design_Shear_Strength,Design_Shear_Strength_1,Design_Shear_Strength_2,Fck,Fy,Asv);
[Tbd,Ld,Ld_1,CCC_2] = Development_Length_Check (XDim,Tbd_1, Tbd_switch,Fy,dia_1,Fck,Hook_Allowance,Bs,C_cc,r,AreaP_Tension_2,de_beam,Vu);
[LD_maximum,LD_Provided,Check_2] = Deflection_Check (r,AreaP_Tension_2,AreaP_Compression,Span,XDim,de_beam,Fy,AreaR_Tension,Modification_Factor_2);
[W_cr]=Crack_Width_Check(r,Mu,Es,C_cc,AreaP_Tension_2,Spacing_Tension_1,Ce,dia_1,Sigma_cbc,Fck,XDim,de_beam,YDim);
Figures (r,StaadTable,CCC_2)
diary off
open Results.txt