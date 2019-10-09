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
## @deftypefn {} {@var{retval} =} Crack_Width_Check (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [W_cr]=Crack_Width_Check(r,Mu,Es,C_cc,AreaP_Tension_2,Spacing_Tension_1,Ce,dia_1,Sigma_cbc,Fck,XDim,de_beam,YDim)
  %% Crack width check
fprintf('\n')
disp('if beam stisfies the limit of Crack width requirement it is given by 0')
disp('if beam does not stisfies the limit of Crack width requirement it is given by 1')
for i=1:r
  Section=i;
Acr=sqrt(((Spacing_Tension_1(i)/2)*(Spacing_Tension_1(i)/2))+(Ce*Ce))-(dia_1/2);
Sigma_CBC= interp1(Sigma_cbc(:,1),Sigma_cbc(:,2),Fck);
Modular_ratio=280/(3*Sigma_CBC);
PtP_Provided=(100*AreaP_Tension_2'(i))/(XDim*de_beam);
Rho=(PtP_Provided/100);
k=((2*(Rho*Modular_ratio))+(Rho*Modular_ratio*Rho*Modular_ratio))-(Rho*Modular_ratio);
x=(k*de_beam);
I_cr=((XDim*x*x*x)/(3))+(Modular_ratio*(AreaP_Tension_2'(i))*(de_beam-x)*(de_beam-x))+((((AreaP_Tension_2'(i))*((1.5*Modular_ratio)-1))*(x-Ce)*(x-Ce)));
Fst=(((Modular_ratio*Mu(i)*1000000)*(de_beam-x))/(I_cr));
Strain_m=((YDim-x)/(Es*(de_beam-x)))*((Fst)-(((XDim)*(YDim-x))/(3*AreaP_Tension_2'(i))));
W_cr=abs((3*Acr*Strain_m)/(1+(2*((Acr-C_cc)/(YDim-x)))));
if W_cr<=0.3
  Disp_3=0;
else
  Disp_3=1;
endif
    AA(i,:)=[Section];   
    BB(i,:)=[Disp_3]; 
endfor
AA_1=[reshape(AA,[],1)];
BB_1=[reshape(BB,[],1)];
R7=[AA_1,BB_1];
disp('Section      Check');
disp(num2str(R7));
endfunction
