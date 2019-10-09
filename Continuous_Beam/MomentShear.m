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
## @deftypefn {} {@var{retval} =} MomentShear (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Mu,Vu,Mu_Lim] = MomentShear (StaadTable,Fck,K,XDim,de_beam)
Mu=StaadTable(:,5);
Vu=StaadTable(:,3);
Mu_Lim=(0.36*Fck*K*XDim*de_beam*de_beam)*(1-0.416*K)/1000000
endfunction
