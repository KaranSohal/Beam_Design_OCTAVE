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
## @deftypefn {} {@var{retval} =} MOR (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [MOR_Top,MOR_Bottom] = MOR (r,Fy,de_beam,XDim,Fck,Total_Steel_Provided_Top,Total_Steel_Provided_Bottom)
for i=1:r
M1=(0.87*Fy*Total_Steel_Provided_Top(i))*(de_beam-((Fy*Total_Steel_Provided_Top(i))/(Fck*XDim)));
M2=(0.87*Fy*Total_Steel_Provided_Bottom(i))*(de_beam-((Fy*Total_Steel_Provided_Bottom(i))/(Fck*XDim)));
CC_1(i,:)=[M1/1000000]; 
CC_2(i,:)=[M2/1000000]; 
endfor
MOR_Top=[reshape(CC_1,[],1)];
MOR_Bottom=[reshape(CC_2,[],1)];
endfunction
