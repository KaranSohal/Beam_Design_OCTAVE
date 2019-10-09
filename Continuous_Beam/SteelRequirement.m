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
## Created: 2019-05-19

function [P_Moment,N_Moment,Section,TotalSteel_Required_Positive,TotalSteel_Required_Negative,Total_Steel_Required,Total_Steel_Provided,Total_Steel_Provided_TensionPositive,Total_Steel_Provided_CompressionNegative,Total_Steel_Provided_TensionNegative,Total_Steel_Provided_CompressionPositive,N_TensionPositive,N_CompressionPositive,N_TensionNegative,N_CompressionNegative,Total_Steel_Required_Bottom] = SteelRequirement (r,Mu,Mu_Lim,Fck,Fy,XDim,de_beam,K,de_cr,Fsc,dia_1,dia_2,Ast_min,Ast_max)

for i=1:r
  section=i;
  if Mu(i)>0    
   #disp('Posi')
   %% Singly
   if Mu_Lim>=Mu(i)
    Mu_P1=Mu(i);
   
    Ast_P1 = (0.5*Fck/Fy)*(1-sqrt(1-(4.6*(Mu(i)*1000000)/(Fck*XDim*de_beam*de_beam))))*(XDim*de_beam);
    Mu_P2=0;
    Ast_P2=0;
    Asc_P=0;
    #disp('Singly')
    %% Doubly
   elseif Mu_Lim<Mu(i)
    Mu_P1=Mu_Lim;
    Ast_P1=(Mu_P1*1000000)/(0.87*Fy*de_beam*(1-0.416*K));
    Mu_P2=(Mu(i)-Mu_Lim);
    Ast_P2=(Mu_P2*1000000)/(0.87*Fy*(de_beam-de_cr));
    Asc_P=(Mu_P2*1000000)/((Fsc-0.446*Fck)*(de_beam-de_cr));
    #disp('Doubly')
   endif
    Mu_N1=0;
    Ast_N1=0;
    Mu_N2=0;  
    Ast_N2=0;
    Asc_N=0; 
     AstR_N1=0;
     AsTP_N1=0;
     AsCP_N2=0;
   
        
      AstR_PT=Ast_P1+Ast_P2;
      As_PTC=Ast_P1+Ast_P2+Asc_P ;
      Nst_P(i,:)=[ceil((AstR_PT)/(0.25*pi*dia_1*dia_1))];
      
      if  Nst_P(i,:)<2
        Nst_P(i,:)=2;
      else 
         Nst_P(i,:)= Nst_P(i,:);
      endif
      Nsc_P(i,:)=[ceil((Asc_P/(0.25*pi*dia_2*dia_2)))];
      AsTP_P1=(Nst_P(i,:)*0.25*pi*dia_1*dia_1);
      AsCP_P2=(Nsc_P(i,:)*0.25*pi*dia_2*dia_2);
      
      
     if As_PTC>=Ast_min && As_PTC<=Ast_max
       AstR_P1=As_PTC;
     elseif As_PTC<Ast_min
       AstR_P1=Ast_min;
     elseif As_PTC>Ast_max
      AstR_P1=Ast_max;
     endif
     AstR_P1;
     Nst_N(i,:)=0;
      Nsc_N(i,:)=0;
         
   elseif Mu(i)<0
    AstR_P1=0;
   #disp('Negi')
   %% Singly
     Mu_1=abs(Mu(i));   
   if Mu_Lim>=Mu_1
    Mu_N1=Mu_1;
   
    Ast_N1 = (0.5*Fck/Fy)*(1-sqrt(1-(4.6*(Mu_1*1000000)/(Fck*XDim*de_beam*de_beam))))*(XDim*de_beam);
    Mu_N2=0;  
    Ast_N2=0;
    Asc_N=0;
    #disp('Singly')
   %% Doubly
   elseif Mu_Lim<Mu_1
    Mu_N1=Mu_Lim;
    Ast_N1=(Mu_N1*1000000)/(0.87*Fy*de_beam*(1-0.416*K));
    
    Mu_N2=(Mu_1-Mu_Lim);
    Ast_N2=(Mu_N2*1000000)/(0.87*Fy*(de_beam-de_cr));
    Asc_N=(Mu_N2*1000000)/((Fsc-0.446*Fck)*(de_beam-de_cr));
    #disp('Doubly')
   endif
   Mu_P1=0;
   AsTP_P1=0;
    Mu_P2=0;
    Ast_P2=0;
    Asc_P=0;
    
        AstR_NT=Ast_N1+Ast_N2;
    As_NTC=Ast_N1+Ast_N2+Asc_N ;
      Nst_N(i,:)=[ceil((AstR_NT)/(0.25*pi*dia_1*dia_1))];
      if Nst_N(i,:)<2
        Nst_N(i,:)=2;
      else 
        Nst_N(i,:)=Nst_N(i,:);
      endif
      
        
      Nsc_N(i,:)=[ceil((Asc_N/(0.25*pi*dia_2*dia_2)))];
      AsTP_N1=(Nst_N(i,:)*0.25*pi*dia_1*dia_1);
      AsCP_N2=(Nsc_N(i,:)*0.25*pi*dia_2*dia_2);
     if As_NTC>=Ast_min && As_NTC<=Ast_max
       AstR_N1=As_NTC;
     elseif As_NTC<Ast_min
       AstR_N1=Ast_min;
     elseif As_NTC>Ast_max
      AstR_N1=Ast_max;
     endif
     AstR_N1;
     
     
  elseif Mu(i)==0
    Mu_P1=0;
    Ast_P1=0;
    Mu_P2=0;
    Ast_P2=0;
    Asc_P=0;
    Mu_N1=0;
    Ast_N1=0;
    Mu_N2=0;
    Ast_N2=0;
    Asc_N=0 ;
    AstR_P1=0;
    AstR_N1=0;
    Nst_P(i,:)=0;
    Nsc_P(i,:)=0;
    AsTP_P1=0;
    AsCP_P2=0;
    Nst_N(i,:)=0;
    Nsc_N(i,:)=0;
    AsTP_N1=0;
    AsCP_N2=0;
  endif  

ABCD_1(i,:)=[section,Mu_P1,Ast_P1,Mu_P2,Ast_P2,Asc_P];
ABCD_2(i,:)=[section,Mu_N1,Ast_N1,Mu_N2,Ast_N2,Asc_N];
ABCD_3(i,:)=[AstR_P1];
ABCD_4(i,:)=[AstR_N1];
ABCD_5(i,:)=[section];
ABCD_6(i,:)=[AsTP_P1];
ABCD_7(i,:)=[AsCP_P2];
ABCD_8(i,:)=[AsTP_N1];
ABCD_9(i,:)=[AsCP_N2];

Total_Steel_Required_Bottom=(AsCP_P2+AstR_N1);
ABCD_32(i,:)=[Total_Steel_Required_Bottom];
endfor
P_Moment=[reshape(ABCD_1,[],6)];
N_Moment=[reshape(ABCD_2,[],6)];
Section=[reshape(ABCD_5,[],1)];
TotalSteel_Required_Positive=[reshape(ABCD_3,[],1)];
TotalSteel_Required_Negative=[reshape(ABCD_4,[],1)];
Total_Steel_Required=[TotalSteel_Required_Positive+TotalSteel_Required_Negative];
Total_Steel_Provided_TensionPositive=[reshape(ABCD_6,[],1)];
Total_Steel_Provided_CompressionPositive=[reshape(ABCD_7,[],1)];
Total_Steel_Provided_TensionNegative=[reshape(ABCD_8,[],1)];
Total_Steel_Provided_CompressionNegative=[reshape(ABCD_9,[],1)];
N_TensionPositive=[reshape(Nst_P,[],1)];
N_CompressionPositive=[reshape(Nsc_P,[],1)];
N_TensionNegative=[reshape(Nst_N,[],1)];
N_CompressionNegative=[reshape(Nsc_N,[],1)];
Total_Steel_Required_Bottom=[reshape(ABCD_32,[],1)];
Total_Steel_Provided=[Total_Steel_Provided_TensionPositive+Total_Steel_Provided_CompressionPositive+Total_Steel_Provided_TensionNegative+Total_Steel_Provided_CompressionNegative];
R1=[Section,Mu,Total_Steel_Required,N_TensionPositive,N_CompressionPositive,N_TensionNegative,N_CompressionNegative,Total_Steel_Provided];
#disp(num2str(P_Moment))
#disp(num2str(N_Moment))
fprintf('\n') 
disp('Section        Mu       Total_Req           N_TP            N_CP           N_TN           N_CN     Total_Provided ')

disp(num2str(R1))
endfunction
