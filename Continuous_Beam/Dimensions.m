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
## @deftypefn {} {@var{retval} =} Dimensions (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: admin <admin@WORKBOT>
## Created: 2019-05-19

function [XDim,YDim,de_beam,Ce,dia_st,C_cc,de_cr,r,c,dia_Anchorage] = Dimensions (Span,d,de_c,Cc,Cc_Data,dia_1,dia_2,dia_3,dia_3Data,dia_4,dia_4Data,R,Shut,D,B,StaadTable)
Span
%% effective depth of beam drop plus slab thickness
if Span<=10000
 if d==0
  d_e=(Span/26);
 else
  d_e=d; 
 endif
elseif Span>10000
 if d==0
   d_e=(Span/26)*(Span/10000);
 else
  d_e=d;
 endif
endif


%% Clear cover
if Cc==0
  C_c=Cc_Data;
else
  C_c=Cc;
endif

if C_c<20
  disp('Minimum clear cover should be 20 mm')
  C_c=20;
endif
if Cc==0
  C_cc=max([C_c, dia_1, dia_2]);
else
  C_cc=C_c;
endif
C_cc

%% Shear reinforcement
if dia_3==0
  dia_st=dia_3Data;
else
  dia_st=dia_3;
endif
dia_st

%% Total Depth of beam
if D==0
  D_t=(d_e+C_cc+(dia_1/2)+dia_st);
else 
  D_t=(D);
  endif
%% Width of beam
if B==0
  if R>=1.5 && R<=2
     B_t=(D_t/R);
  else
    disp('D/B should be between 1.5 and 2')
    R_c=1.5
    B_t=(D_t/R_c);
  endif
 else
  B_t=B;
endif
%% Size of shuttering plates available in mm
if B==0
[m,n]=min(abs(B_t-Shut(:,1)));
XDim= (Shut(n));
else
XDim=B;
endif
XDim
if D==0
[o,p]=min(abs(D_t-Shut(:,1)));
YDim= (Shut(p));
else
YDim=D;
endif
YDim
%% Effective Depth of the beam
de_beam=(YDim-C_cc-dia_st-(dia_1/2))
%% Effective cover
Ce=(YDim-de_beam)
fprintf('\n');
[r,c] = size(StaadTable);

%% Effective depth of compression reinforcement
if de_c==0
  de_cr=(YDim-de_beam);
else
  de_cr=de_c;
endif

%% Anchorage reinforcement 
if dia_4==0
  dia_Anchorage=dia_4Data;
else
  dia_Anchorage=dia_4;
endif
endfunction
