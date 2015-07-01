function D = driving_function_mono_sdm_kx_ps(kx,xs,f,conf)
%DRIVING_FUNCTION_MONO_SDM_KX_PS returns the driving signal D for a point source in
%SDM in the kx domain
%
%   Usage: D = driving_function_mono_sdm_kx_ps(kx,xs,f,[conf])
%
%   Input parameters:
%       kx          - kx dimension [nx1]
%       xs          - position of point source / m [1x3]
%       f           - frequency of the monochromatic source / Hz
%       conf        - optional configuration struct (see SFS_config)
%
%   Output parameters:
%       D           - driving function signal [nx1]
%
%   DRIVING_FUNCTION_MONO_SDM_KX_PS(kx,xs,f,conf) returns SDM driving signals
%   for the given secondary sources, the virtual point source position and the
%   frequency f. The driving signal is calculated in the kx domain.
%
%   References:
%       H. Wierstorf, J. Ahrens, F. Winter, F. Schultz, S. Spors (2015) -
%       "Theory of Sound Field Synthesis"
%       S. Spors and J. Ahrens (2010) - "Reproduction of Focused Sources by the
%       Spectral Division Method", ISCCSP
%
%   See also: driving_function_mono_sdm_kx

%*****************************************************************************
% Copyright (c) 2010-2015 Quality & Usability Lab, together with             *
%                         Assessment of IP-based Applications                *
%                         Telekom Innovation Laboratories, TU Berlin         *
%                         Ernst-Reuter-Platz 7, 10587 Berlin, Germany        *
%                                                                            *
% Copyright (c) 2013-2015 Institut fuer Nachrichtentechnik                   *
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
nargmin = 3;
nargmax = 4;
narginchk(nargmin,nargmax);
isargmatrix(kx);
isargxs(xs);
isargpositivescalar(f);
if nargin<nargmax
    conf = SFS_config;
else
    isargstruct(conf);
end


%% ===== Configuration ==================================================
c = conf.c;
dimension = conf.dimension;
driving_functions = conf.driving_functions;
x0 = conf.secondary_sources.center;
xref = x0 - [0 1 0];
withev = conf.sdm.withev;


%% ===== Computation ====================================================
% Calculate the driving function in time-frequency domain

% Frequency
omega = 2*pi*f;
% Indexes for evanescent contributions and propagating part of the wave field
idxpr = (( abs(kx) <= (omega/c) ));
idxev = (( abs(kx) > (omega/c) ));
D = zeros(1,length(kx));

if strcmp('2D',dimension)

    % === 2-Dimensional ==================================================

    % Ensure 2D
    xs = xs(1:2);
    if strcmp('default',driving_functions)
        % --- SFS Toolbox ------------------------------------------------
        to_be_implemented;
    else
        error(['%s: %s, this type of driving function is not implemented ', ...
            'for a 2D point source.'],upper(mfilename),driving_functions);
    end


elseif strcmp('2.5D',dimension)

    % === 2.5-Dimensional ================================================

    if strcmp('default',driving_functions)
        % --- SFS Toolbox ------------------------------------------------
        % D_25D(kx,w) = e^(i kx xs) ...
        %                                   ____________
        %                         H1^(2)( \|(w/c)^2-kx^2 |yref-ys| )
        %                     / - --------------_-_-_-_-_-_---------, |kx|<|w/c|
        %                     |      H1^(2)( \|(w/c)^2-kx^2 yref )
        %                    <        ____________
        %                     | K1( \|kx^2-(w/c)^2 |yref-ys| )
        %                     \ ----------_-_-_-_-_-_---------,       |kx|>|w/c|
        %                          K1( \|kx^2-(w/c)^2 yref )
        %
        % see Wierstorf et al. (2015), eq.(#D:sdm:ps:2.5D)
        % A time reversed version of this driving function for focused sources
        % is given in Spors and Ahrens (2010), eq.(7).
        %
        D(idxpr) =  exp(1i*kx(idxpr)*xs(1)) .* ...
            besselh(1,2,sqrt( (omega/c)^2 - kx(idxpr).^2 )*abs(xref(2)-xs(2))) ./ ...
            besselh(1,2,sqrt( (omega/c)^2 - kx(idxpr).^2 )*abs(xref(2)-x0(2)));
        if(withev)
            D(idxev) =  exp(1i*kx(idxev)*xs(1)) .* ...
                besselk(1,sqrt(kx(idxev).^2 - (omega/c).^2)*abs(xref(2)-xs(2))) ./ ...
                besselk(1,sqrt(kx(idxev).^2 - (omega/c).^2)*abs(xref(2)-x0(2)));
        end

    else
        error(['%s: %s, this type of driving function is not implemented ', ...
            'for a 2.5D point source.'],upper(mfilename),driving_functions);
    end


elseif strcmp('3D',dimension)

    % === 3-Dimensional ==================================================

    if strcmp('default',driving_functions)
        % --- SFS Toolbox ------------------------------------------------
        to_be_implemented;
    else
        error(['%s: %s, this type of driving function is not implemented ', ...
            'for a 3D point source.'],upper(mfilename),driving_functions);
    end

else
    error('%s: the dimension %s is unknown.',upper(mfilename),dimension);
end
