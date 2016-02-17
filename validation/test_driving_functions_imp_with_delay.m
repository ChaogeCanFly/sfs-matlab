function boolean = test_driving_functions_imp_with_delay(modus)
%TEST_DRIVING_FUNCTIONS_IMP_WITH_DELAY tests the correctness of the time-domain
%driving functions, in the case of conf.wfs.removedelay=false
%
%   Usage: boolean = test_driving_functions_imp_with_delay(modus)
%
%   Input parameters:
%       modus   - 0: numerical
%                 1: visual
%
%   Output parameters:
%       booelan - true or false
%
%   TEST_DRIVING_FUNCTIONS_IMP_WITH_DELAY(MODUS) checks if the functions,
%   that calculates the WFS driving functions in time-domain work correctly
%   for the setting conf.wfs.removedelay = false.
%   Therefore different sound fields are simulated.

%*****************************************************************************
% Copyright (c) 2010-2016 Quality & Usability Lab, together with             *
%                         Assessment of IP-based Applications                *
%                         Telekom Innovation Laboratories, TU Berlin         *
%                         Ernst-Reuter-Platz 7, 10587 Berlin, Germany        *
%                                                                            *
% Copyright (c) 2013-2016 Institut fuer Nachrichtentechnik                   *
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

% TODO: add mode to save data as reference data


%% ===== Checking of input  parameters ===================================
nargmin = 1;
nargmax = 1;
narginchk(nargmin,nargmax);


%% ===== Configuration ===================================================
conf = SFS_config;
conf.wfs.removedelay = false;
conf.secondary_sources.size = 3;
conf.plot.useplot = false;
conf.plot.usenormalisation = true;
conf.plot.usedb = true;
conf.driving_functions = 'default';
% test scenarios
scenarios = { ...
    'WFS', '2D',   'linear',   'pw', [ 0.5 -1.0  0.0]; ...
    'WFS', '2D',   'linear',   'ls', [ 0.0  1.0  0.0]; ...
    'WFS', '2D',   'linear',   'fs', [ 0.0 -1.0  0.0  0.0 -1.0  0.0]; ...
    'WFS', '2D',   'circular', 'pw', [ 0.5  0.5  0.0]; ...
    'WFS', '2D',   'circular', 'ls', [ 0.0  2.5  0.0]; ...
    'WFS', '2D',   'circular', 'ps', [ 0.0  2.5  0.0]; ...
    'WFS', '2D',   'circular', 'fs', [ 0.0  0.5  0.0  0.0 -1.0  0.0]; ...
    'WFS', '2D',   'box',      'pw', [ 0.5  1.0  0.0]; ...
    'WFS', '2D',   'box',      'ls', [ 2.0  2.0  0.0]; ...
    'WFS', '2D',   'box',      'ps', [ 2.0  2.0  0.0]; ...
    'WFS', '2D',   'box',      'fs', [ 0.5  0.5  0.0  -1.0  -1.0  0.0]; ...
    'WFS', '2.5D', 'linear',   'pw', [ 0.5 -1.0  0.0]; ...
    'WFS', '2.5D', 'linear',   'ps', [ 0.0  1.0  0.0]; ...
    'WFS', '2.5D', 'linear',   'fs', [ 0.0 -1.0  0.0  0.0 -1.0  0.0]; ...
    'WFS', '2.5D', 'circular', 'pw', [ 0.5  0.5  0.0]; ...
    'WFS', '2.5D', 'circular', 'ps', [ 0.0  2.5  0.0]; ...
    'WFS', '2.5D', 'circular', 'fs', [ 0.0  0.5  0.0  0.0 -1.0  0.0]; ...
    'WFS', '2.5D', 'box',      'pw', [ 0.5  1.0  0.0]; ...
    'WFS', '2.5D', 'box',      'ps', [ 2.0  2.0  0.0]; ...
    'WFS', '2.5D', 'box',      'fs', [ 0.5  0.5  0.0 -1.0  -1.0  0.0]; ...
    'WFS', '3D',   'sphere',   'ps', [ 0.0  2.5  0.0]; ...
    'WFS', '3D',   'sphere',   'pw', [ 0.0 -1.0  0.0]; ...
    'WFS', '3D',   'sphere',   'fs', [ 0.0  0.5  0.0  0.0 -1.0  0.0]; ...
};

% Start testing
for ii=1:size(scenarios)

    % get current dimension
    conf.dimension = scenarios{ii,2};
   
    % get listening area
    switch scenarios{ii,3}
        case 'linear'
            X = [-2 2];
            Y = [-3 0.15];
            Z = 0;
            conf.xref = [0 -1.5 0];
            conf.secondary_sources.number = 20;
        case 'circular'
            X = [-2 2];
            Y = [-2 2];
            Z = 0;
            conf.xref = [0 0 0];
            conf.secondary_sources.number = 56;
        case 'box'
            X = [-2 2];
            Y = [-2 2];
            Z = 0;
            conf.xref = [0 0 0];
            conf.secondary_sources.number = 80;
        case 'sphere'
            X = [-2 2];
            Y = [-2 2];
            Z = 0;
            conf.xref = [0 0 0];
            conf.secondary_sources.number = 900;
    end

    conf.secondary_sources.geometry = scenarios{ii,3};
    t0 = secondary_source_diameter(conf)/conf.c; % max. travel time
    total_delay = round(t0*conf.fs) + conf.wfs.hpreFIRorder/2;
    t = total_delay + 30;        % some samples more to see the point source
    src = scenarios{ii,4};
    xs = scenarios{ii,5};

    % ===== WFS ==========================================================
    % spatio-temporal impulse response
    try
        [p,x,y,z,x0] = sound_field_imp_wfs(X,Y,Z,xs,src,t,conf);
        if modus
            conf.plot.normalisation = 'max';
            plot_sound_field(p,X,Y,Z,x0,conf);
            title_str = sprintf('WFS %s %s array, %s, impulse response', ...
                conf.dimension,conf.secondary_sources.geometry,src);
            title(title_str);
        end
    catch
        warning('%s: WFS impulse response %s array %s %s gives the following error message.', ...
            upper(mfilename),conf.secondary_sources.geometry,conf.dimension,src);
        lasterr
    end
    
end