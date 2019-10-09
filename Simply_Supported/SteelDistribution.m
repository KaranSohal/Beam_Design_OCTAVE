## Copyright (C) 2019 admin
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} SteelDistribution (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-18

function [AreaP_Anchorage,Nst_3,Nsc_5,AreaP_Tension_2] = SteelDistribution (TotalSteel_Required,StaadTable,Steel,AreaP_Compression,r,dia_1,dia_2,dia_Anchorage ,TotalSteel_Provided,AreaP_Tension)

%%% Distribution of Compression steel
Max_Steel_Provided_Comp=max(AreaP_Compression)
MSPC_11=0.75*Max_Steel_Provided_Comp;
MSPC_12=0.6*Max_Steel_Provided_Comp;
for i=1:r
if Max_Steel_Provided_Comp==0
   AreaP_Compression_2(i)=0;
   Nsc_5(i)=0;
  elseif MSPC_11<=AreaP_Compression(i) && AreaP_Compression(i)<=Max_Steel_Provided_Comp
  AreaP_Compression_1(i)=Max_Steel_Provided_Comp;
  Nsc_4(i,:)=[ceil((AreaP_Compression_1(i))/(0.25*pi*dia_2*dia_2))];
   if Nsc_4(i)>0 && Nsc_4(i)<=2
      Nsc_5(i)=2;
   elseif Nsc_4(i)>2
      Nsc_5(i)=Nsc_4(i);
   endif
  AreaP_Compression_2(i)=(0.25*pi*dia_2*dia_2)*Nsc_5(i);
  
 elseif MSPC_12<=AreaP_Compression(i) && AreaP_Compression(i)<MSPC_11
  AreaP_Compression_1(i)=0.80*Max_Steel_Provided_Comp;
  Nsc_4(i,:)=[ceil((AreaP_Compression_1(i))/(0.25*pi*dia_2*dia_2))];
  if Nsc_4(i)>0 && Nsc_4(i)<=2
      Nsc_5(i)=2;
   elseif Nsc_4(i)>2
      Nsc_5(i)=Nsc_4(i);
   endif
  AreaP_Compression_2(i)=(0.25*pi*dia_2*dia_2)*Nsc_5(i);
  
 elseif AreaP_Compression(i)<MSPC_12
  AreaP_Compression_1(i)=0.6*Max_Steel_Provided_Comp;
  Nsc_4(i,:)=[ceil((AreaP_Compression_1(i))/(0.25*pi*dia_2*dia_2))];
  if Nsc_4(i)>0 && Nsc_4(i)<=2
      Nsc_5(i)=2;
   elseif Nsc_4(i)>2
      Nsc_5(i)=Nsc_4(i);
   endif
  AreaP_Compression_2(i)=(0.25*pi*dia_2*dia_2)*Nsc_5(i);
 endif 
 
 if AreaP_Compression_2==0
  %%provide 2 anchorage bars on the top to hold the stirrups
    As_Anchorage=2*(0.25*pi*dia_Anchorage*dia_Anchorage);
  else
    As_Anchorage=0;
 endif
  L(i,:)=[ As_Anchorage];
endfor
AreaP_Anchorage=[reshape(L,[],1)];
%%% Distribution of Tension steel
Max_Steel_Provided_Tension=max(TotalSteel_Provided)
MSP_11=0.75*Max_Steel_Provided_Tension;
MSP_12=0.5*Max_Steel_Provided_Tension;
for i=1:r
if MSP_11<=AreaP_Tension(i) && AreaP_Tension(i)<=Max_Steel_Provided_Tension
  AreaP_Tension_1(i)=Max_Steel_Provided_Tension;
  Nst_3(i,:)=[ceil((AreaP_Tension_1(i))/(0.25*pi*dia_1*dia_1))];
  AreaP_Tension_2(i)=(0.25*pi*dia_1*dia_1)*Nst_3(i);
elseif MSP_12<=AreaP_Tension(i) && AreaP_Tension(i)<MSP_11
  AreaP_Tension_1(i)=0.80*Max_Steel_Provided_Tension;
  Nst_3(i,:)=[ceil((AreaP_Tension_1(i))/(0.25*pi*dia_1*dia_1))];
  AreaP_Tension_2(i)=(0.25*pi*dia_1*dia_1)*Nst_3(i);
else
  AreaP_Tension_1(i)=0.5*Max_Steel_Provided_Tension;
  Nst_3(i,:)=[ceil((AreaP_Tension_1(i))/(0.25*pi*dia_1*dia_1))];
  AreaP_Tension_2(i)=(0.25*pi*dia_1*dia_1)*Nst_3(i);
endif
endfor

R=[StaadTable];
S=[Steel];
disp('Member   Distance        Fy MAX           FY MIN          MZ MAX        MZ MIN')
disp(num2str(R))
fprintf('\n')
disp('   Mu_1            Ast_1              Mu_2          Ast_2          Asc')
disp(num2str(S))
fprintf('\n')
dia_1
dia_2
dia_Anchorage
fprintf('\n')
R1=[TotalSteel_Required,Nst_3,AreaP_Tension_2',Nsc_5',AreaP_Compression_2',AreaP_Anchorage];
disp('Steel_Required         NT     Steel_P_T              NC     Steel_P_C        Anchorage steel')
disp(num2str(R1)) 
fprintf('\n')
endfunction
