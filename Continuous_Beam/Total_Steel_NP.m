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
## @deftypefn {} {@var{retval} =} Total_Steel_NP (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Total_Steel_Provided_TensionNP] = Total_Steel_NP (r,N_TensionPositive,N_TensionNegative,dia_1)

%%%%%%%%%%% Tension Reinforcement Negative Positive
for i=1:r
  if N_TensionPositive(i)>=N_TensionNegative(i)
    N_TensionNP=N_TensionPositive(i);
  else
    N_TensionNP=N_TensionNegative(i);
  endif
  ABCD_33(i,:)=[N_TensionNP];   
endfor
N_TensionNP=[reshape(ABCD_33,[],1)];
Total_Steel_Provided_TensionNP=(pi*0.25)*(dia_1*dia_1)*(N_TensionNP);
Total_Steel_Provided_TensionNP=[Total_Steel_Provided_TensionNP];

endfunction
