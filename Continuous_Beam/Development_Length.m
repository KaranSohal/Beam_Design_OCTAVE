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
## @deftypefn {} {@var{retval} =} Development_Length (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Ld] = Development_Length (N_TensionNegative,Vu,Tbd_1,Tbd_switch,Fck,dia_1,Mu,Section_Disptance,K,Fy,de_beam,Ast_min,Distance_of_ZeroMoment,XDim)
%%% Development length check at Mid
Tbd=interp1(Tbd_1(:,1),Tbd_1(:,2),Fck)
switch (Tbd_switch)
  case 1
        Ld=((0.87*Fy*dia_1)/(4* Tbd));
  case 2
        Ld=((0.87*Fy*dia_1)/(4* 1.6*Tbd));
  endswitch
Ld
disp(['Development length at section having maximum negative moment= ' num2str(Ld)])
[m,n]=min(Mu);
Mid_Point=Section_Disptance(n);
Point_Upto_LD=Mid_Point-Ld;
Mu_LD=interp1(Section_Disptance,Mu,Point_Upto_LD);
AstR_LD=abs((Mu_LD*1000000)/(0.87*Fy*de_beam*(1-0.416*K)));
if AstR_LD<=Ast_min
  AstR_LD=Ast_min;
else
  AstR_LD=AstR_LD;
endif
NstR_LD=ceil((AstR_LD)/(0.25*pi*dia_1*dia_1));
NstP_LD=ceil(interp1(Section_Disptance,N_TensionNegative,Point_Upto_LD));
if NstP_LD>=NstR_LD
  disp('Development Length is satisfied at Mid Section')
  else
  disp('Development Length is not satisfied at Mid Section')
endif
fprintf('\n')
%%%%%%% development length at zero moment
Moment_Zero_Point=Distance_of_ZeroMoment(1);
Steel_Zero_Point=interp1(Section_Disptance,N_TensionNegative,Moment_Zero_Point);
Ast_Provided_Zero_Point=(Steel_Zero_Point)*(0.25*pi)*(dia_1*dia_1);
Moment_Resistance_Zero_Point=(0.87*Fy*Ast_Provided_Zero_Point)*(de_beam-((Fy*Ast_Provided_Zero_Point)/(Fck*XDim)));
Shear_Zero_Point=interp1(Section_Disptance,Vu,Moment_Zero_Point)*1000;
LD_Zero_Point=(Moment_Resistance_Zero_Point)/(Shear_Zero_Point)
if LD_Zero_Point>=Ld
  disp('Development Length is satisfied at Zero moment Section')
  else
  disp('Development Length is not satisfied at Zero moment Section')
endif
fprintf('\n')
%%%%%%%%%%%%%%%% Development length at support section
[m,n]=max(Mu);
End_Point=Section_Disptance(n);
Required_Theoratical_Curtailment_Point=End_Point+Ld
Provided_Theoratical_Curtailment_Point=Distance_of_ZeroMoment(1)
if Distance_of_ZeroMoment(1)>=Required_Theoratical_Curtailment_Point
  disp('Development Length is satisfied at maximum positive moment Section')
  else
  disp('Development Length is not satisfied at maximum positive moment Section')
endif
endfunction
