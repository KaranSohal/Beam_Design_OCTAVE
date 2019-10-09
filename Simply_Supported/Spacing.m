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
## @deftypefn {} {@var{retval} =} Spacing (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-18

function [Spacing_Tension_1,Spacing_Tension_2,Spacing_Compression_1,Spacing_Compression_2,Layers_Tension,Layers_Compression,Bars_T_1,Bars_T_2,Bars_C_1,Bars_C_2,SpT_Vertical,SpC_Vertical] = Spacing (r,Nst_3,XDim,Ce,dia_1,dia_2,Sa,Nsc_5)
%% spacing of bars in mm
for i=1:r
if Nst_3(i)<=1
    SpT_provided_1=0;
  else
    SpT_provided_1=((XDim)-(2*Ce)-(((Nst_3(i)-1)*dia_1)))/((Nst_3(i)-1));
endif

Sp_min=max([dia_1 Sa+5]);
if Sp_min<=SpT_provided_1
   SpT_Provided_1=SpT_provided_1;
   SpT_Provided_2=0;
   Layers_T=1;
   Nst_1=Nst_3(i);
   Nst_2=0;
   SpT_Vertical=0;
elseif SpT_provided_1==0
   SpT_Provided_1=0;
   SpT_Provided_2=0;
   Layers_T=1;
   Nst_1=1;
   Nst_2=0;  
   SpT_Vertical=0;
else
  Layers_T=2;
  SpT_Vertical_1=[15 0.66*Sa dia_1];
  SpT_Vertical=max(SpT_Vertical_1);  
  Mod_T=mod(Nst_3(i),2);
    if Mod_T==0
      Nst_1=(Nst_3(i)/2);
      Nst_2=(Nst_3(i)/2);
      SpT_Provided_1=((XDim)-(2*Ce)-((((Nst_1)-1)*dia_1)))/((Nst_1)-1);
      SpT_Provided_2=((XDim)-(2*Ce)-((((Nst_2)-1)*dia_1)))/((Nst_2)-1);
    else
      Nst_1=ceil((Nst_3(i)/2));
      Nst_2=Nst_3(i)-ceil((Nst_3(i)/2));
      SpT_Provided_1=((XDim)-(2*Ce)-((((Nst_1)-1)*dia_1)))/((Nst_1)-1);
      SpT_Provided_2=((XDim)-(2*Ce)-((((Nst_2)-1)*dia_1)))/((Nst_2)-1);
    endif 
 endif

%% compression bars
if Nsc_5(i)<=1
  SpC_provided_1=0;
else
  SpC_provided_1=((XDim)-(2*Ce)-(((Nsc_5(i)-1)*dia_1)))/((Nsc_5(i))-1);
endif

Sp_min=max([dia_1 Sa+5]);
if SpC_provided_1>=Sp_min
   SpC_Provided_1=SpC_provided_1;
   SpC_Provided_2=0;
   Layers_C=1;
   SpC_Vertical=0;  
   Nsc_1=Nsc_5(i);
   Nsc_2=0;
elseif SpC_provided_1==0
   SpC_Provided_1=0;
   SpC_Provided_2=0;
   SpC_Vertical=0;  
   Layers_C=1;
   Nsc_1=Nsc_5(i);
   Nsc_2=0;  
else
  Layers_C=2;
  SpC_Vertical_1=[15 0.66*Sa dia_2];
  SpC_Vertical=max(SpT_Vertical_1);  
  Mod_C=mod(Nsc_5(i),2);
    if Mod_C==0
      Nsc_1=(Nsc_5(i)/2);
      Nsc_2=(Nsc_5(i)/2);
      SpC_Provided_1=((XDim)-(2*Ce)-((((Nsc_1)-1)*dia_1)))/((Nsc_1)-1);
      SpC_Provided_2=((XDim)-(2*Ce)-((((Nsc_2)-1)*dia_1)))/((Nsc_2)-1);
    else
      Nsc_1=ceil((Nsc_5(i)/2));
      Nsc_2=Nsc_5(i)-ceil((Nsc_5(i)/2));
      SpC_Provided_1=((XDim)-(2*Ce)-((((Nsc_1)-1)*dia_1)))/((Nsc_1)-1);
      SpC_Provided_2=((XDim)-(2*Ce)-((((Nsc_2)-1)*dia_1)))/((Nsc_2)-1);
    endif 
endif
  T(i,:)=[SpT_Provided_1];
  U(i,:)=[SpT_Provided_2];
  V(i,:)=[Layers_T];
  N1T(i,:)=[Nst_1];
  N2T(i,:)=[Nst_2];
  W(i,:)=[SpC_Provided_1];
  X(i,:)=[SpC_Provided_2];
  Y(i,:)=[Layers_C];
  N1C(i,:)=[Nsc_1];
  N2C(i,:)=[Nsc_2];
  DD_1(i,:)=[SpT_Vertical];
  DD_2(i,:)=[SpC_Vertical];
endfor
Spacing_Tension_1=[reshape(T,[],1)];
Spacing_Tension_2=[reshape(U,[],1)];
Layers_Tension=[reshape(V,[],1)];
Bars_T_1=[reshape(N1T,[],1)];
Bars_T_2=[reshape(N2T,[],1)];
SpT_Vertical=[reshape(DD_1,[],1)];
SpT_Vertical=max(SpT_Vertical);

Spacing_Compression_1=[reshape(W,[],1)];
Spacing_Compression_2=[reshape(X,[],1)];
Layers_Compression=[reshape(Y,[],1)];
Bars_C_1=[reshape(N1C,[],1)];
Bars_C_2=[reshape(N2C,[],1)];
SpC_Vertical=[reshape(DD_2,[],1)];
SpC_Vertical=max(SpC_Vertical);


R6=[Bars_T_1,Spacing_Tension_1,Bars_T_2,Spacing_Tension_2,Layers_Tension,Bars_C_1,Spacing_Compression_1,Bars_C_2,Spacing_Compression_2,Layers_Compression];
disp('N_T1  SP_T1  N_T2  SP_T2  Layers_T    N_CC1  SP_C1  N_C2  SP_C2  Layers_C ')
disp(num2str(R6)) 
fprintf('\n')

if SpT_Vertical>0
  disp(['Provide vertical spacing between layers on tension face= ' num2str(SpT_Vertical)])
endif
if SpC_Vertical>0
  disp(['Provide vertical spacing between layers on Compression face= ' num2str(SpC_Vertical)])
endif
fprintf('\n')
endfunction