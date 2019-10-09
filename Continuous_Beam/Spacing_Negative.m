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
## @deftypefn {} {@var{retval} =} Spacing_Negative (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [SpTN_Provided_1,SpTN_Provided_2,Layers_TN,N_TensionNegative_1,N_TensionNegative_2,SpCN_Provided_1,SpCN_Provided_2,Layers_CN,N_CompressionNegative_1,N_CompressionNegative_2] = Spacing_Negative (N_CompressionNegative,r,XDim,Ce,N_TensionNegative,dia_1,Sa,Sp_min)
%%%%%%%%%% Spacing Negative
for i=1:r  
    SpTN_provided_1=((XDim)-(2*Ce)-(((N_TensionNegative(i)-1)*dia_1)))/((N_TensionNegative(i)-1));
Sp_min=max([dia_1 Sa+5]);
if Sp_min<=SpTN_provided_1
   SpTN_provided_1=SpTN_provided_1;
   SpTN_provided_2=0;
   Layers_TN=1;
   N_TensionNegative_1=N_TensionNegative(i);
   N_TensionNegative_2=0;
elseif SpTN_provided_1==0
   SpTN_provided_1=0;
   SpTN_provided_2=0;
   Layers_TN=1;
   N_TensionNegative_1=1;
   N_TensionNegative_2=0;  
else
  Layers_TN=2;
  Mod_TP=mod(N_TensionNegative(i),2);
    if Mod_TP==0
      N_TensionNegative_1=(N_TensionNegative(i)/2);
      N_TensionNegative_2=(N_TensionNegative(i)/2);
      SpTN_provided_1=((XDim)-(2*Ce)-((((N_TensionNegative_1)-1)*dia_1)))/((N_TensionNegative_1)-1);
      SpTN_provided_2=((XDim)-(2*Ce)-((((N_TensionNegative_2)-1)*dia_1)))/((N_TensionNegative_2)-1);
    else
      N_TensionNegative_1=ceil((N_TensionNegative(i)/2));
      N_TensionNegative_2=N_TensionNegative(i)-ceil((N_TensionNegative(i)/2));
      SpTN_provided_1=((XDim)-(2*Ce)-((((N_TensionNegative_1)-1)*dia_1)))/((N_TensionNegative_1)-1);
      SpTN_provided_2=((XDim)-(2*Ce)-((((N_TensionNegative_2)-1)*dia_1)))/((N_TensionNegative_2)-1);
    endif 
 endif
 %%%%%%%%%%%%%%%%%
if N_CompressionNegative==0
  SpCN_Provided_1=0;
   SpCN_Provided_2=0;
   Layers_CN=0;
   N_CompressionNegative_1=0;
   N_CompressionNegative_2=0;
 else
   
 SpCN_Provided_1=((XDim)-(2*Ce)-(((N_CompressionNegative(i)-1)*dia_1)))/((N_CompressionNegative(i)-1))
Sp_min=max([dia_1 Sa+5]);
if Sp_min<=SpCN_provided_1
   SpCN_Provided_1=SpCN_provided_1;
   SpCN_Provided_2=0;
   Layers_CN=1;
   N_CompressionNegative_1=N_CompressionNegative(i);
   N_CompressionNegative_2=0;
elseif SpCN_provided_1==0
   SpCN_Provided_1=0;
   SpCN_Provided_2=0;
   Layers_CN=1;
   N_CompressionNegative_1=1;
   N_CompressionNegative_2=0;  
else
  Layers_CN=2;
  Mod_TN=mod(N_CompressionNegative(i),2);
    if Mod_TN==0
      N_CompressionNegative_1=(N_CompressionNegative(i)/2);
      N_CompressionNegative_2=(N_CompressionNegative(i)/2);
      SpCN_Provided_1=((XDim)-(2*Ce)-((((N_CompressionNegative_1)-1)*dia_1)))/((N_CompressionNegative_1)-1);
      SpCN_Provided_2=((XDim)-(2*Ce)-((((N_CompressionNegative_2)-1)*dia_1)))/((N_CompressionNegative_2)-1);
    else
      N_CompressionNegative_1=ceil((N_CompressionNegative(i)/2));
      N_CompressionNegative_2=N_CompressionNegative(i)-ceil((N_CompressionNegative(i)/2));
      SpCN_Provided_1=((XDim)-(2*Ce)-((((N_CompressionNegative_1)-1)*dia_1)))/((N_CompressionNegative_1)-1);
      SpCN_Provided_2=((XDim)-(2*Ce)-((((N_CompressionNegative_2)-1)*dia_1)))/((N_CompressionNegative_2)-1);
    endif 
 endif
endif

 
 %%%%%%%%%%%%%%%%%
  ABCD_22(i,:)=[SpTN_provided_1];
  ABCD_23(i,:)=[SpTN_provided_2];
  ABCD_24(i,:)=[Layers_TN];
  ABCD_25(i,:)=[N_TensionNegative_1];
  ABCD_26(i,:)=[N_TensionNegative_2];
  ABCD_27(i,:)=[SpCN_Provided_1];
  ABCD_28(i,:)=[SpCN_Provided_2];
  ABCD_29(i,:)=[Layers_CN];
  ABCD_30(i,:)=[N_CompressionNegative_1];
  ABCD_31(i,:)=[N_CompressionNegative_2];
endfor

SpTN_Provided_1=[reshape(ABCD_22,[],1)];
SpTN_Provided_2=[reshape(ABCD_23,[],1)];
Layers_TN=[reshape(ABCD_24,[],1)];
N_TensionNegative_1=[reshape(ABCD_25,[],1)];
N_TensionNegative_2=[reshape(ABCD_26,[],1)];
SpCN_Provided_1=[reshape(ABCD_27,[],1)];
SpCN_Provided_2=[reshape(ABCD_28,[],1)];
Layers_CN=[reshape(ABCD_29,[],1)];
N_CompressionNegative_1=[reshape(ABCD_30,[],1)];
N_CompressionNegative_2=[reshape(ABCD_31,[],1)];
fprintf('\n')
disp('Spacing details of Tension Negative')
disp('Spacing_LT1 Spacing_LT2 Layers N_TN_1 N_TN_2')
R6=[SpTN_Provided_1 SpTN_Provided_2 Layers_TN N_TensionNegative_1 N_TensionNegative_2];
disp(num2str(R6))
fprintf('\n')
disp('Spacing details of Compression Negative')
disp('Spacing_LC1 Spacing_LC2 Layers N_CN_1 N_CN_2')
R7=[SpCN_Provided_1 SpCN_Provided_2 Layers_CN N_CompressionNegative_1 N_CompressionNegative_2];
disp(num2str(R7))
endfunction
