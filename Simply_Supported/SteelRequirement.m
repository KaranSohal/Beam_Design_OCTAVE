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
## @deftypefn {} {@var{retval} =} SteelRequirement (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-18

function [Steel,TotalSteel_Required,TotalSteel_Provided,N_Tension,N_Compression,AreaR_Tension,AreaP_Tension,AreaP_Compression] = SteelRequirement (r,Mu,Mu_Lim,Fck,Fy,XDim,de_beam,K,de_cr,dia_1,dia_2,Ast_min,Ast_max,Fsc)

for i=1:r
%% Singly
 if Mu_Lim>=Mu(i)
   Mu_1=Mu(i);
   Ast_1=(0.5*Fck/Fy)*(1-sqrt(1-(4.6*Mu(i)*1000000/(Fck*XDim*de_beam*de_beam))))*(XDim*de_beam);
   Mu_2=0;
   Ast_2=0;
   Asc=0;
%% Doubly
 elseif Mu_Lim<Mu(i)
   Mu_1=Mu_Lim;
   Ast_1=(Mu_1*1000000)/(0.87*Fy*de_beam*(1-0.416*K));
   Mu_2=(Mu(i)-Mu_Lim);
   Ast_2=(Mu_2*1000000)/(0.87*Fy*(de_beam-de_cr));
   Asc=(Mu_2*1000000)/((Fsc-0.446*Fck)*(de_beam-de_cr));
  endif
 

AstR_T=Ast_1+Ast_2;
As_TC=Ast_1+Ast_2+Asc ;
if As_TC>=Ast_min && As_TC<=Ast_max
    AstR_1=As_TC;
  elseif As_TC<Ast_min
   AstR_1=Ast_min;
  elseif As_TC>Ast_max
   AstR_1=Ast_max;
  endif

A(i,:)=[Mu_1 Ast_1 Mu_2 Ast_2 Asc];
B(i,:)=[AstR_1];
J(i,:)=[AstR_T];
Nst(i,:)=[ceil((Ast_1+Ast_2)/(0.25*pi*dia_1*dia_1))];
Nsc(i,:)=[ceil((Asc/(0.25*pi*dia_2*dia_2)))];
AsTP_1=(Nst(i,:)*0.25*pi*dia_1*dia_1);
AsCP_2=(Nsc(i,:)*0.25*pi*dia_2*dia_2);
C(i,:)=[AsTP_1+AsCP_2];
C_1(i,:)=[AsTP_1];
C_2(i,:)=[AsCP_2];

endfor
Steel=[reshape(A,[],5)];
TotalSteel_Required=[reshape(B,[],1)];
TotalSteel_Provided=[reshape(C,[],1)];
N_Tension=[reshape(Nst,[],1)];
N_Compression=[reshape(Nsc,[],1)];
AreaR_Tension=[reshape(J,[],1)];
AreaP_Tension=[reshape(C_1,[],1)];
AreaP_Compression=[reshape(C_2,[],1)];
endfunction
