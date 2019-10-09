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
## @deftypefn {} {@var{retval} =} Spacing_Positive (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [SpTP_Provided_1,SpTP_Provided_2,Layers_TP,N_TensionPositive_1,N_TensionPositive_2,SpCP_Provided_1,SpCP_Provided_2,Layers_CP,N_CompressionPositive_1,N_CompressionPositive_2,Sp_min] = Spacing_Positive (r,XDim,Ce,N_TensionPositive,dia_2,Sa,N_CompressionPositive)
%%%%%%%%%% Spacing Positive
for i=1:r  
    SpTP_provided_1=((XDim)-(2*Ce)-(((N_TensionPositive(i)-1)*dia_2)))/((N_TensionPositive(i)-1));
Sp_min=max([dia_2 Sa+5]);
if Sp_min<=SpTP_provided_1
   SpTP_Provided_1=SpTP_provided_1;
   SpTP_Provided_2=0;
   Layers_TP=1;
   N_TensionPositive_1=N_TensionPositive(i);
   N_TensionPositive_2=0;
elseif SpTP_provided_1==0
   SpTP_Provided_1=0;
   SpTP_Provided_2=0;
   Layers_TP=1;
   N_TensionPositive_1=1;
   N_TensionPositive_2=0;  
else
  Layers_TP=2;
  Mod_TP=mod(N_TensionPositive(i),2);
    if Mod_TP==0
      N_TensionPositive_1=(N_TensionPositive(i)/2);
      N_TensionPositive_2=(N_TensionPositive(i)/2);
      SpTP_Provided_1=((XDim)-(2*Ce)-((((N_TensionPositive_1)-1)*dia_2)))/((N_TensionPositive_1)-1);
      SpTP_Provided_2=((XDim)-(2*Ce)-((((N_TensionPositive_2)-1)*dia_2)))/((N_TensionPositive_2)-1);
    else
      N_TensionPositive_1=ceil((N_TensionPositive(i)/2));
      N_TensionPositive_2=N_TensionPositive(i)-ceil((N_TensionPositive(i)/2));
      SpTP_Provided_1=((XDim)-(2*Ce)-((((N_TensionPositive_1)-1)*dia_2)))/((N_TensionPositive_1)-1);
      SpTP_Provided_2=((XDim)-(2*Ce)-((((N_TensionPositive_2)-1)*dia_2)))/((N_TensionPositive_2)-1);
    endif 
 endif
 %%%%%%%%%%%%%%%%%
if N_CompressionPositive==0
  SpCP_Provided_1=0;
   SpCP_Provided_2=0;
   Layers_CP=0;
   N_CompressionPositive_1=0;
   N_CompressionPositive_2=0;
 else
   
 SpCP_provided_1=((XDim)-(2*Ce)-(((N_CompressionPositive(i)-1)*dia_2)))/((N_CompressionPositive(i)-1))
Sp_min=max([dia_2 Sa+5]);
if Sp_min<=SpCP_provided_1
   SpCP_Provided_1=SpCP_provided_1;
   SpCP_Provided_2=0;
   Layers_CP=1;
   N_CompressionPositive_1=N_CompressionPositive(i);
   N_CompressionPositive_2=0;
elseif SpCP_provided_1==0
   SpCP_Provided_1=0;
   SpCP_Provided_2=0;
   Layers_CP=1;
   N_CompressionPositive_1=1;
   N_CompressionPositive_2=0;  
else
  Layers_CP=2;
  Mod_TP=mod(N_CompressionPositive(i),2);
    if Mod_TP==0
      N_CompressionPositive_1=(N_CompressionPositive(i)/2);
      N_CompressionPositive_2=(N_CompressionPositive(i)/2);
      SpCP_Provided_1=((XDim)-(2*Ce)-((((N_CompressionPositive_1)-1)*dia_2)))/((N_CompressionPositive_1)-1);
      SpCP_Provided_2=((XDim)-(2*Ce)-((((N_CompressionPositive_1)-1)*dia_2)))/((N_CompressionPositive_1)-1);
    else
      N_CompressionPositive_1=ceil((N_CompressionPositive(i)/2));
      N_CompressionPositive_2=N_CompressionPositive(i)-ceil((N_CompressionPositive(i)/2));
      SpCP_Provided_1=((XDim)-(2*Ce)-((((N_CompressionPositive_1)-1)*dia_2)))/((N_CompressionPositive_1)-1);
      SpCP_Provided_2=((XDim)-(2*Ce)-((((N_CompressionPositive_2)-1)*dia_2)))/((N_CompressionPositive_2)-1);
    endif 
 endif
endif

 
 %%%%%%%%%%%%%%%%%
  ABCD_12(i,:)=[SpTP_Provided_1];
  ABCD_13(i,:)=[SpTP_Provided_2];
  ABCD_14(i,:)=[Layers_TP];
  ABCD_15(i,:)=[N_TensionPositive_1];
  ABCD_16(i,:)=[N_TensionPositive_2];
  ABCD_17(i,:)=[SpCP_Provided_1];
  ABCD_18(i,:)=[SpCP_Provided_2];
  ABCD_19(i,:)=[Layers_CP];
  ABCD_20(i,:)=[N_CompressionPositive_1];
  ABCD_21(i,:)=[N_CompressionPositive_2];
endfor

SpTP_Provided_1=[reshape(ABCD_12,[],1)];
SpTP_Provided_2=[reshape(ABCD_13,[],1)];
Layers_TP=[reshape(ABCD_14,[],1)];
N_TensionPositive_1=[reshape(ABCD_15,[],1)];
N_TensionPositive_2=[reshape(ABCD_16,[],1)];
SpCP_Provided_1=[reshape(ABCD_17,[],1)];
SpCP_Provided_2=[reshape(ABCD_18,[],1)];
Layers_CP=[reshape(ABCD_19,[],1)];
N_CompressionPositive_1=[reshape(ABCD_20,[],1)];
N_CompressionPositive_2=[reshape(ABCD_21,[],1)];
Sp_min

fprintf('\n')
disp('Spacing details of Tension Positive')
disp('Spacing_LT1 Spacing_LT2 Layers N_TP_1 N_TP_2')
R4=[SpTP_Provided_1 SpTP_Provided_2 Layers_TP N_TensionPositive_1 N_TensionPositive_2];
disp(num2str(R4))
fprintf('\n')
disp('Spacing details of Compression Positive')
disp('Spacing_LC1 Spacing_LC2 Layers N_CP_1 N_CP_2')
R5=[SpCP_Provided_1 SpCP_Provided_2 Layers_CP N_CompressionPositive_1 N_CompressionPositive_2];
disp(num2str(R5))
endfunction
