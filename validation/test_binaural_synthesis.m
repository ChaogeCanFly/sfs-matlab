function test_binaural_synthesis()
%TEST_BINAURAL_SYNTHESIS tests the correctness of the binaural synthesis
%functions
%
%   Usage: test_binaural_synthesis()
%
%   TEST_BINAURAL_SYNTHESIS() tests the ir_wfs_25d function for different
%   loudspeaker arrays and source models.

%*****************************************************************************
% Copyright (c) 2010-2014 Quality & Usability Lab, together with             *
%                         Assessment of IP-based Applications                *
%                         Telekom Innovation Laboratories, TU Berlin         *
%                         Ernst-Reuter-Platz 7, 10587 Berlin, Germany        *
%                                                                            *
% Copyright (c) 2013-2014 Institut fuer Nachrichtentechnik                   *
%                         Universitaet Rostock                               *
%                         Richard-Wagner-Strasse 31, 18119 Rostock           *
%                                                                            *
% This file is part of the Sound Field Synthesis-Toolbox (SFS).              *
%                                                                            *
% The SFS is free software:  you can redistribute it and/or modify it  under *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% The SFS is distributed in the hope that it will be useful, but WITHOUT ANY *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% The SFS is a toolbox for Matlab/Octave to  simulate and  investigate sound *
% field  synthesis  methods  like  wave  field  synthesis  or  higher  order *
% ambisonics.                                                                *
%                                                                            *
% http://github.com/sfstoolbox/sfs                      sfstoolbox@gmail.com *
%*****************************************************************************


%% ===== Checking of input  parameters ===================================
nargmin = 0;
nargmax = 0;
narginchk(nargmin,nargmax);


%% ===== Main ============================================================
conf = SFS_config;
L = 3;
irs = read_irs('QU_KEMAR_anechoic_3m.mat');
conf.ir.usehcomp = false;


%% ===== WFS 2.5D ========================================================
% === Linear array ===
conf.array = 'linear';
conf.dx0 = 0.15;
X = [0,2];
phi = pi/2;
conf.xref = [0 2];
% Plane wave
src = 'pw';
xs = [0.5,1];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
% Point source
src = 'ps';
xs = [0,-1];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
% Focused source
src = 'fs';
xs = [0,1];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);

% === Circular array ===
conf.array = 'circle';
conf.dx0 = 0.15;
X = [0,0];
conf.xref = [0,0];
% Plane wave
src = 'pw';
xs = [0.5,1];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
% Point source
src = 'ps';
xs = [0.5,2];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
% Focused source
src = 'fs';
xs = [0.5,0.5];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);

% === Box shaped array ===
conf.array = 'box';
conf.dx0 = 0.15;
X = [0,0];
conf.xref = [0,0];
% Plane wave
src = 'pw';
xs = [0.5,1];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
% Point source
src = 'ps';
xs = [0.5,2];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
% Focused source
src = 'fs';
xs = [0.5,0.5];
ir_wfs_25d(X,phi,xs,src,L,irs,conf);
