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
## @deftypefn {} {@var{retval} =} Zero_Moment_Distance (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Lo,Distance_of_ZeroMoment] = Zero_Moment_Distance (r,Mu,StaadTable,dia_1,de_beam)
%%% To find the value of distacne for 0 Moment
for i=1:r-1
    Ii=i+1;
  Mu_multiple=Mu(i)*Mu(Ii);
  if Mu_multiple<0
      Moment_Zero=[StaadTable(i,2),Mu(i);StaadTable(Ii,2),Mu(Ii)];
      dist_0=interp1(Moment_Zero(:,2),Moment_Zero(:,1),0) ;
     ABCD_10(i,:)=[dist_0];
  endif
endfor

Dist_0=[reshape(ABCD_10,1,[])];
n1 = find(Dist_0 >0) ;
Lo=12*dia_1;
if Lo<=de_beam
  Lo=de_beam;
else
  Lo=Lo;
endif
Lo
%%% Distance for extension of bars from first support
Distance_of_ZeroMoment=Dist_0(n1)'*1000;
endfunction
