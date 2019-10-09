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
## @deftypefn {} {@var{retval} =} Bars_Bottom (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Bars_TensionNegative,Bars_CompressionNegative,Max_N_TensionNegative,Max_N_CompressionNegative] = Bars_Bottom (N_TensionNegative, N_CompressionNegative)
%%%%%%%%%  Bottom face
Max_N_TensionNegative=max(N_TensionNegative);
Max_N_CompressionNegative=max(N_CompressionNegative) ;
Bars_TensionNegative=[ceil(Max_N_TensionNegative/2)];
if Bars_TensionNegative<2
  Bars_TensionNegative=2;
else
  Bars_TensionNegative=Bars_TensionNegative;
endif
Bars_CompressionNegative=[ceil(Max_N_CompressionNegative)];

endfunction
