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
## @deftypefn {} {@var{retval} =} Curtailment (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Required_Curtailment_Bottom,Required_Curtailment_Top] = Curtailment (Distance_of_ZeroMoment, Lo)
Required_Curtailment_Bottom(1,:)=(Distance_of_ZeroMoment(1)-Lo);
Required_Curtailment_Bottom(1,2)=(Distance_of_ZeroMoment(2)+Lo);
Required_Curtailment_Top(1,:)=(Distance_of_ZeroMoment(1)+Lo);
Required_Curtailment_Top(1,2)=(Distance_of_ZeroMoment(2)-Lo);
disp('Req_Curt    Pr_Curt_Bottom    Pr_Curt_Top')
R2=[Distance_of_ZeroMoment,Required_Curtailment_Bottom',Required_Curtailment_Top'];
disp(num2str(R2))
endfunction
