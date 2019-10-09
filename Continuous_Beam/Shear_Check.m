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
## @deftypefn {} {@var{retval} =} Shear_Check (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [Nominal_Shear_Stress,Pt_P,Design_Shear_Stress,Sr_R, Sv_P] = Shear_Check (Asv,Fck,Fy,Total_Steel_Provided_TensionNP, XDim,de_beam,Vu,r,Design_Shear_Strength,Design_Shear_Strength_1,Design_Shear_Strength_2)

disp('if Shear reinforcement not required it is given by 0 ')
disp('if Shear reinforcement required it is given by 1 ')
disp('if Shear reinforcement is not required minimum shear reinforcement is provided')    
fprintf('\n')
%% Check for shear
for i=1:r
  %%Pt_Provided in %
  Pt_Provided=(100*Total_Steel_Provided_TensionNP(i))/(XDim*de_beam);
   Tv=(abs(Vu(i))*1000)/(XDim*de_beam);
 #Fck
%% Design shear strength Tc in N/mm2
if Pt_Provided>=0.15
   if Fck>=40
      Tc=interp1(Design_Shear_Strength_1(:,1),Design_Shear_Strength_1(:,7),Pt_Provided);
   elseif Fck>=15
      Tc = interp2(Design_Shear_Strength,Design_Shear_Strength,Design_Shear_Strength,Fck,Pt_Provided);
   else
      Tc=disp("Value_NA");
   endif
endif

if Pt_Provided<0.15
   if Fck>=40
      Tc=0.3;
   elseif Fck>=15
      Tc=interp1(Design_Shear_Strength_2(:,1),Design_Shear_Strength_2(:,2),Fck);
   else
      Tc=disp("Value_NA");
   endif
endif


if Pt_Provided>=3.00
    if Fck>=40
       Tc=1.01;
    elseif Fck>=15
       Tc=interp1(Design_Shear_Strength_2(:,1),Design_Shear_Strength_2(:,3),Fck); 
    else
       Tc=disp("Value_NA");
    endif
endif


if Tc>Tv
  Disp_1=0;
  Sv_1=(0.87*Fy*Asv)/(0.4*XDim);
  Sv_2=(0.75*de_beam);
  Sv_3=(300);
  Sv=min([Sv_1 Sv_2 Sv_3]);
elseif Tv>=Tc
  Disp_1=1; 
  Tus=(Tv-Tc);
  Vus=(Tus*XDim*de_beam);
  Sv_1P=(0.87*Fy*Asv*de_beam)/(Vus);
  Sv_1=(0.87*Fy*Asv)/(0.4*XDim);
  Sv_2=(0.75*de_beam);
  Sv_3=(300);
  Sv=min([Sv_1P Sv_1 Sv_2 Sv_3]);
endif
E(i,:)=[Tv];
F(i,:)=[Tc];
G(i,:)=[Pt_Provided];
H(i,:)=[Disp_1];
I(i,:)=[Sv];
endfor
Nominal_Shear_Stress=[reshape(E,[],1)];
Design_Shear_Stress=[reshape(F,[],1)];
Pt_P=[reshape(G,[],1)];
Sr_R=[reshape(H,[],1)];
Sv_P=[reshape(I,[],1)];
R2=[Nominal_Shear_Stress,Pt_P,Design_Shear_Stress,Sr_R, Sv_P];
disp('    Tv      Pt_Provided       Tc     Shear reinforcement  Spacing_Shear')
disp(num2str(R2)) 
fprintf('\n')
endfunction
