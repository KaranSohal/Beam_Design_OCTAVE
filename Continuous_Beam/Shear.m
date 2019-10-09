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
## @deftypefn {} {@var{retval} =} Shear (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [N_st,Tc_max,Asv] = Shear (Fck, Maximum_Shear_Stress,dia_st,N_st)
%%Shear_reinforcement
fprintf('\n')
%% Tc_max(maximum shear stress in concrete) N/mm2  
 if Fck<40
    Tc_max=interp1(Maximum_Shear_Stress(:,1),Maximum_Shear_Stress(:,2),Fck);
 elseif Fck>=40
    Tc_max=4;
 endif
    Tc_max    
%%%% N_st Legged stirrups
if N_st==2 
Asv= (N_st*pi*dia_st*dia_st)/(4)
elseif N_st==4 
Asv= (N_st*pi*dia_st*dia_st)/(4)
elseif N_st==6 
Asv= (N_st*pi*dia_st*dia_st)/(4)
else
disp("Provide 2, 4 and 6 legged only")
endif
N_st 
endfunction
