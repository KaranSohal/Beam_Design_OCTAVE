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
## @deftypefn {} {@var{retval} =} EscFsc (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Esc,Fsc] = EscFsc (de_cr,K,de_beam,Es,Fy,Fsc_415,Fsc_500)
Esc=(0.0035)*(1-((de_cr)/(K*de_beam)))
if Fy<415
    if Esc<=0.00125
       Fsc=(0.87*Es*Esc);
    elseif Esc>0.00125
       Fsc=(0.87*Fy);
     endif
     elseif Fy>=415 && Fy<500
    if Esc>=0.00380
      Fsc=360.9;
    else
      Fsc=interp1(Fsc_415(:,1),Fsc_415(:,2),Esc);
    endif
elseif Fy>=500
    if Esc>=0.00417
      Fsc=434.8;
    else
      Fsc=interp1(Fsc_500(:,1),Fsc_500(:,2),Esc)
    endif
endif
Fsc
endfunction
