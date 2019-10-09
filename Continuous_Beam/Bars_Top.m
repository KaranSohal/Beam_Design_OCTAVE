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
## @deftypefn {} {@var{retval} =} Bars_Top (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Max_N_CompressionPositive,Max_N_TensionPositive,Bars_TensionPositive,Bars_CompressionPositive,Section_Disptance] = Bars_Top (StaadTable,N_TensionPositive, N_CompressionPositive)
%%%%%% Top Face
Max_N_TensionPositive=max(N_TensionPositive);
Max_N_CompressionPositive=max(N_CompressionPositive) ;
Bars_TensionPositive=[ceil(Max_N_TensionPositive/2)];
if Bars_TensionPositive<2
  Bars_TensionPositive=2;
else
  Bars_TensionPositive=Bars_TensionPositive;
endif
Bars_CompressionPositive=[ceil(Max_N_CompressionPositive)];
Section_Disptance=StaadTable(:,2)*1000;
endfunction
