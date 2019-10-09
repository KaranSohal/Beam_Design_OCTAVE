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
## @deftypefn {} {@var{retval} =} Bars (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [N_TensionNegative,N_CompressionNegative, N_TensionPositive,N_CompressionPositive,Total_Steel_Provided,Total_Steel_Provided_Top,Total_Steel_Provided_Bottom]=Bars(Section,dia_1,dia_2,Max_N_TensionPositive,Bars_CompressionPositive,Bars_TensionPositive,Required_Curtailment_Top,r,Section_Disptance,Required_Curtailment_Bottom,Bars_TensionNegative,Bars_CompressionNegative,Max_N_TensionNegative)
  for i=1:r
   if Section_Disptance(i)<Required_Curtailment_Bottom(1,1)
     N_TensionNegative=Bars_TensionNegative;
     N_CompressionNegative=Bars_CompressionNegative;
   elseif Section_Disptance(i)>Required_Curtailment_Bottom(1,1) && Section_Disptance(i)<Required_Curtailment_Bottom(1,2)
     N_TensionNegative=Max_N_TensionNegative;
     N_CompressionNegative=Bars_CompressionNegative;
   elseif Section_Disptance(i)>Required_Curtailment_Bottom(1,2)
     N_TensionNegative=Bars_TensionNegative;
     N_CompressionNegative=Bars_CompressionNegative;
   endif
   ABCD_10(i,:)=[N_TensionNegative];
   ABCD_11(i,:)=[N_CompressionNegative];
endfor

N_TensionNegative=[reshape(ABCD_10,[],1)];
N_CompressionNegative=[reshape(ABCD_11,[],1)];
 for i=1:r
   if Section_Disptance(i)<Required_Curtailment_Top(1,1)
     N_TensionPositive=Max_N_TensionPositive;
     N_CompressionPositive=Bars_CompressionPositive;
   elseif Section_Disptance(i)>Required_Curtailment_Top(1,1) && Section_Disptance(i)<Required_Curtailment_Top(1,2)
     N_TensionPositive=Bars_TensionPositive;
     N_CompressionPositive=Bars_CompressionPositive;
   elseif Section_Disptance(i)>Required_Curtailment_Top(1,2)
     N_TensionPositive=Max_N_TensionPositive;
     N_CompressionPositive=Bars_CompressionPositive;
   endif
   ABCD_10(i,:)=[N_TensionPositive];
   ABCD_11(i,:)=[N_CompressionPositive];
endfor

N_TensionPositive=[reshape(ABCD_10,[],1)];
N_CompressionPositive=[reshape(ABCD_11,[],1)];
Total_Steel_Provided=(pi/4)*(N_TensionNegative+N_CompressionPositive)*(dia_1*dia_1)+(pi/4)*(N_TensionPositive+N_CompressionNegative)*(dia_1*dia_1);
Total_Steel_Provided_Top=(pi/4)*(N_TensionPositive+N_CompressionNegative)*(dia_2*dia_2);
Total_Steel_Provided_Bottom=(pi/4)*(N_TensionNegative+N_CompressionPositive)*(dia_1*dia_1);
disp('Section    Distance           N_TP           N_CP           N_TN          N_CN     Total_Provided')
R3=[Section Section_Disptance N_TensionPositive N_CompressionPositive N_TensionNegative N_CompressionNegative Total_Steel_Provided];
disp(num2str(R3))

endfunction
