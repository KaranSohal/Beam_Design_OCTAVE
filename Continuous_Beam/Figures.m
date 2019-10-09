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
## @deftypefn {} {@var{retval} =} Figures (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function Figures (r,StaadTable,MOR_Top,MOR_Bottom);  
ABCD_1=[0,StaadTable(:,2)',StaadTable(r,2)];
ABCD_2=[0,StaadTable(:,3)',0];
ABCD_3=[0,StaadTable(:,4)',0];
ABCD_4=[0,StaadTable(:,8)',0];
figure(1)
plot(ABCD_1,ABCD_2)
hold on
plot(ABCD_1,ABCD_3)
hold on
plot(ABCD_1,ABCD_4,'k')
hold off
grid on
title('Shear Force ')
xlabel('x, meter')
ylabel('FY, kN-m')
legend('Vu Max','Vu Min')
print(1,'-dpng','-r300','figure(1)')

#figure(2)
#plot(abs(StaadTable(:,2)),abs(StaadTable(:,5)))
#hold on
#plot(StaadTable(:,2),StaadTable(:,6))
#hold off
#grid
#title('Bending Moment ')
#xlabel('x, meter')
#ylabel('MZ, kN-m')

%%%%%%%%%%%%%
#Distance_Section_Mid=((StaadTable(r,2)/(r-1)))/2
#for i=1:r-1
  #Ii=i+1;
  #if CCC_2(i)==CCC_2(Ii)
  #else
  #CP_M=[StaadTable(i,2)*1000,CCC_2(i);StaadTable(Ii,2)*1000,CCC_2(Ii)];
  #Avg=[CCC_2(i) CCC_2(Ii)];
  #Avg=mean(Avg);
  #CP=interp1(CP_M(:,2),CP_M(:,1),Avg)
 #  ABCD_10(i,:)=[CP];
#endif
#endfor
#Dist_0=[reshape(ABCD_10,1,[])];
#n1 = find(Dist_0 >0) 
#for i=1:r
#if StaadTable(i,5)<0
#  MR=-M(i);
#elseif StaadTable(i,5)>=0
 # MR=M(i);
#endif
#ABCD_10(i,:)=[MR];
#endfor
#MoR=[reshape(ABCD_10,1,[])];

  

figure(3)
plot((StaadTable(:,2)),(StaadTable(:,5)))
hold on
plot(StaadTable(:,2),StaadTable(:,6))
plot(StaadTable(:,2),MOR_Top)
plot(StaadTable(:,2),(-1*MOR_Bottom))
hold on
plot(ABCD_1,ABCD_4,'k')
hold off
grid
title('Bending Moment ')
xlabel('x, meter')
ylabel('MZ, kN-m')
legend('MuMax','MuMin','MorTop','MorBottom')
print(3,'-dpng','-r300','figure(3)')
endfunction
