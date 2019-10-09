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
## @deftypefn {} {@var{retval} =} Deflection_Check (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [LD_maximum,LD_provided,Check_2] = Deflection_Check (r,XDim,de_beam,Fy,Total_Steel_Provided_TensionNP,Total_Steel_Provided_Top,Total_Steel_Required_Bottom,Span,Modification_Factor_2)
fprintf('\n')
disp('if beam stisfies the limit state of servicibility it is given by 0')
disp('if beam does not stisfies the limit state of servicibility it is given by 1')
for i=1:r
   PtP_Provided=(100*Total_Steel_Provided_TensionNP(i))/(XDim*de_beam);
   Fs=(0.58*Fy)*(Total_Steel_Required_Bottom(i)/Total_Steel_Provided_TensionNP(i));
   Kt=((1/((0.225)+(0.00322*Fs)-(0.625*log10(1/PtP_Provided)))));
   PtP_Compression=(Total_Steel_Provided_Top(i)/(XDim*de_beam))*100;
   Kc=interp1(Modification_Factor_2(:,1),Modification_Factor_2(:,2),PtP_Compression);
   Kf=1;  
   %% L/Dmax=LD
   LD_max=26*Kt*Kc*Kf;
   LD_Provided=(Span)/(de_beam);
   if LD_max>=LD_Provided
     Disp_2=0;
   elseif LD_max<LD_Provided
     Disp_2=1;
   endif
    O(i,:)=[LD_max];   
    P(i,:)=[LD_Provided]; 
    Q(i,:)=[Disp_2];
 endfor
LD_maximum=[reshape(O,[],1)];
LD_provided=[reshape(P,[],1)];
Check_2=[reshape(Q,[],1)];
R5=[LD_maximum,LD_provided,Check_2];
disp('Max_LD      Provided_LD        Check');
disp(num2str(R5))
endfunction
