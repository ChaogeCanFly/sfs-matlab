function boolean = test_driving_functions(modus)
%TEST_DRIVING_FUNCTIONS tests the correctness of the driving functions
%functions
%
%   Usage: boolean = test_driving_functions(modus)
%
%   Input parameters:
%       modus   - 0: numerical
%                 1: visual
%
%   Output parameters:
%       booelan - true or false
%
%   TEST_DRIVING_FUNCTIONS(MODUS) checks if the functions, that calculates
%   the driving functions working correctly. Therefore different wave
%   fields are simulated.
%   For full help see: help test_all
%
%   See also: test_all

% AUTHOR: Hagen Wierstorf
% $LastChangedDate: $
% $LastChangedRevision: $
% $LastChangedBy: $

% TODO: add mode to save data as reference data


%% ===== Checking of input  parameters ===================================
nargmin = 1;
nargmax = 1;
error(nargchk(nargmin,nargmax,nargin));


%% ===== Main ============================================================
conf = SFS_config;
L = 3;
f = 1000;
conf.useplot = modus;


%% ===== WFS 2D ==========================================================
% === Linear array ===
conf.array = 'linear';
conf.dx0 = 0.15;
conf.useplot = 1;
X = [-2,2];
Y = [-0.15,3];
conf.xref = [0 2];
% Plane wave
src = 'pw';
xs = [0.5,1];
% mono-frequent
[x,y,P_wfs2d_linear_pw,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D linear array, plane wave, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_linear_pw,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D linear array, plane wave, impulse response');
% Line source
src = 'ls';
xs = [0,-1];
% mono-frequent
[x,y,P_wfs2d_linear_ps,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D linear array, line source, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_linear_ps,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D linear array, line source, impulse response');
% Focused source
src = 'fs';
xs = [0,1];
% mono-frequent
[x,y,P_wfs2d_linear_fs,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D linear array, focused source, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_linear_fs,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D linear array, focused source, impulse response');

% === Circular array ===
conf.array = 'circle';
conf.dx0 = 0.15;
conf.useplot = 1;
X = [-2,2];
Y = [-2,2];
conf.xref = [0,0];
% Plane wave
src = 'pw';
xs = [0.5,1];
% mono-frequent
[x,y,P_wfs2d_circular_pw,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D circular array, plane wave, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_circular_pw,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D circular array, plane wave, impulse response');
% Line source
src = 'ls';
xs = [0.5,2];
% mono-frequent
[x,y,P_wfs2d_circular_ps,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D circular array, line source, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_circular_ps,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D circular array, line source, impulse response');
% Focused source
src = 'fs';
xs = [0.5,0.5];
% mono-frequent
[x,y,P_wfs2d_circular_fs,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D circular array, focused source, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_circular_fs,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D circular array, focused source, impulse response');

% === Box shaped array ===
conf.array = 'box';
conf.dx0 = 0.15;
conf.useplot = 1;
X = [-2,2];
Y = [-2,2];
conf.xref = [0,0];
% Plane wave
src = 'pw';
xs = [0.5,1];
% mono-frequent
[x,y,P_wfs2d_box_pw,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D box shaped array, plane wave, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_box_pw,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D box shaped array, plane wave, impulse response');
% Line source
src = 'ls';
xs = [0.5,2];
% mono-frequent
[x,y,P_wfs2d_box_ps,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D box shaped array, line source, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_box_ps,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D box shaped array, line source, impulse response');
% Focused source
src = 'fs';
xs = [0.5,0.5];
% mono-frequent
[x,y,P_wfs2d_box_fs,ls_activity] = wave_field_mono_wfs_2d(X,Y,xs,L,f,src,conf);
title('WFS 2D box shaped array, focused source, mono-frequent');
% spatio-temporal impulse response (not implemented yet)
%[x,y,p_wfs2d_box_fs,ls_activity] = wave_field_imp_wfs_2d(X,Y,xs,L,src,conf);
%title('WFS 2D box shaped array, focused source, impulse response');


%% ===== WFS 2.5D ========================================================
% === Linear array ===
conf.array = 'linear';
conf.dx0 = 0.15;
conf.useplot = 1;
X = [-2,2];
Y = [-0.15,3];
conf.xref = [0 2];
conf.frame = 200;
% Plane wave
src = 'pw';
xs = [0.5,1];
% mono-frequent
[x,y,P_wfs25d_linear_pw,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D linear array, plane wave [0.5,1], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_linear_pw,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D linear array, plane wave [0.5,1], impulse response');
% Point source
src = 'ps';
xs = [0,-1];
% mono-frequent
[x,y,P_wfs25d_linear_ps,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D linear array, point source [0,-1], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_linear_ps,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D linear array, point source [0,-1], impulse response');
% Focused source
src = 'fs';
xs = [0,1];
% mono-frequent
[x,y,P_wfs25d_linear_fs,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D linear array, focused source [0,1], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_linear_fs,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D linear array, focused source [0,1], impulse response');

% === Circular array ===
conf.array = 'circle';
conf.dx0 = 0.15;
conf.useplot = 1;
X = [-2,2];
Y = [-2,2];
conf.xref = [0,0];
% Plane wave
src = 'pw';
xs = [0.5,1];
% mono-frequent
[x,y,P_wfs25d_circular_pw,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D circular array, plane wave [0.5,1], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_circular_pw,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D circular array, plane wave [0.5,1], impulse response');
% Line source
src = 'ps';
xs = [0.5,2];
% mono-frequent
[x,y,P_wfs25d_circular_ps,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D circular array, point source [0.5,2], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_circular_ps,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D circular array, point source [0.5,2], impulse response');
% Focused source
src = 'fs';
xs = [0.5,0.5];
% mono-frequent
[x,y,P_wfs25d_circular_fs,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D circular array, focused source [0.5,0.5], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_circular_fs,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D circular array, focused source [0.5,0.5], impulse response');

% === Box shaped array ===
conf.array = 'box';
conf.dx0 = 0.15;
conf.useplot = 1;
X = [-2,2];
Y = [-2,2];
conf.xref = [0,0];
% Plane wave
src = 'pw';
xs = [0.5,1];
% mono-frequent
[x,y,P_wfs25d_box_pw,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D box shaped array, plane wave [0.5,1], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_box_pw,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D box shaped array, plane wave [0.5,1], impulse response');
% Line source
src = 'ps';
xs = [0.5,2];
% mono-frequent
[x,y,P_wfs25d_box_ps,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D box shaped array, point source [0.5,2], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_box_ps,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D box shaped array, point source [0.5,2], impulse response');
% Focused source
src = 'fs';
xs = [0.5,0.5];
% mono-frequent
[x,y,P_wfs25d_box_fs,ls_activity] = wave_field_mono_wfs_25d(X,Y,xs,L,f,src,conf);
title('WFS 2.5D box shaped array, focused source [0.5,0.5], mono-frequent');
% spatio-temporal impulse response
[x,y,p_wfs25d_box_fs,ls_activity] = wave_field_imp_wfs_25d(X,Y,xs,L,src,conf);
title('WFS 2.5D box shaped array, focused source [0.5,0.5], impulse response');