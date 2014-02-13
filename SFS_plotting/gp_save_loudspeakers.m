function gp_save_loudspeakers(file,x0)
% GP_SAVE_LOUDSPEAKERS save x0 as a text file in a Gnuplot compatible format
%
%   Usage: gp_save_loudspeakers(file,x0)
%
%   Input parameters:
%       file        - filename of the data file
%       x0          - secondary sources [nx7]
%
%   GP_SAVE_LOUDSPEAKERS(file,x0) saves x0(:,1:2) as positions of the
%   loudspeakers, an orientation value calculated from x0(:,4:6), and the
%   activity x0(:,7) of the loudspeakers in a text file useable by gnuplot.
%
%   see also: gp_save, gp_save_matrix

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


%% ===== Checking of input  parameters ==================================
nargmin = 2;
nargmax = 2;
narginchk(nargmin,nargmax);
isargchar(file);
isargsecondarysource(x0);


%% ===== Main ============================================================
% Write header to the file
fid = fopen(file,'w');
fprintf(fid,'# Loudspeaker file generated by gp_save_loudspeakers.m\n');
fprintf(fid,'# x0 y0 phi ls_activity\n');
fclose(fid);

% Calculate phi
loudspeaker(:,1:2) = x0(:,1:2);
[loudspeaker(:,3),~,~] = cart2sph(x0(:,4),x0(:,5),x0(:,6));
loudspeaker(:,4) = x0(:,7);


% Append the data to the file using tabulator as a delimiter between the data
if isoctave
    dlmwrite(file,loudspeaker,'\t','-append');
else
    dlmwrite(file,loudspeaker,'delimiter','\t','-append');
end
