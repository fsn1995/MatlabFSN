function [lat,lon] = SWEREF2WGS84(projection,x,y)
%% SWEREF90_2_WGS84 converts the Swedish coordinate (RT90, SWEREF90) to WGS84
% [projection]: supported projection parameters can be found in the switch
% case list in script. If your projection is not found then it will use the
% default setting.
% [x,y]: the input of coordinates (N,E) e.g. 7536381,651026	
% e.g. [lon,lat] = SWEREF90_2_WGS84('sweref_99_tm',x,y)
% [lon,lat]: the output of coordinates in longitude and latitude
% reference source: http://www.lantmateriet.se/geodesi/
% It was adapted from Javascript written by 
% Arnold Andreasson, info@mellifica.se Copyright (c) 2007-2016 Arnold Andreasson 
% License: MIT License
% https://gist.github.com/plopp/70cacc85d8156435567e6e454d6b8c2d
%
% Shunan Feng: fsn.1995@gmail.com
% written for thesis work in Uppsala University, 20190225

%% default parameter
grs80Para.axis = 6378137.0; % GRS 80.
grs80Para.flattening = 1.0 / 298.257222101; % GRS 80.
grs80Para.central_meridian = [];
grs80Para.lat_of_origin = 0.0;

besselPara.axis = 6377397.155; % Bessel 1841.
besselPara.flattening = 1.0 / 299.1528128; % Bessel 1841.
besselPara.central_meridian = [];
besselPara.lat_of_origin = 0.0;
besselPara.scale = 1.0;
besselPara.false_northing = 0.0;
besselPara.false_easting = 1500000.0;

sweref99Para.axis = 6378137.0; % GRS 80.
sweref99Para.flattening = 1.0 / 298.257222101; % GRS 80.
sweref99Para.central_meridian = [];
sweref99Para.lat_of_origin = 0.0;
sweref99Para.scale = 1.0;
sweref99Para.false_northing = 0.0;
sweref99Para.false_easting = 150000.0;
%% parameter setting
switch projection
%  RT90 parameters, GRS 80 ellipsoid.
    case 'rt90_7.5_gon_v'
        grs80Para.central_meridian = 11 + 18.375/60;
        grs80Para.scale = 1.000006000000;
        grs80Para.false_northing = -667.282;
        grs80Para.false_easting = 1500025.141;
        proj = grs80Para;
    case 'rt90_5.0_gon_v'
        grs80Para.central_meridian = 13 + 33.376/60;
        grs80Para.scale = 1.000005800000;
        grs80Para.false_northing = -667.130;
        grs80Para.false_easting = 1500044.695;
        proj = grs80Para;
    case 'rt90_2.5_gon_v'
        grs80Para.central_meridian = 15.0 + 48.0/60.0 + 22.624306/3600.0;
        grs80Para.scale = 1.00000561024;
        grs80Para.false_northing = -667.711;
        grs80Para.false_easting = 1500064.274;
        proj = grs80Para;
    case 'rt90_0.0_gon_v'
        grs80Para.central_meridian = 18.0 + 3.378/60.0;
        grs80Para.scale = 1.000005400000;
        grs80Para.false_northing = -668.844;
        grs80Para.false_easting = 1500083.521;
        proj = grs80Para;
    case 'rt90_2.5_gon_o'
        grs80Para.central_meridian = 20.0 + 18.379/60.0;
        grs80Para.scale = 1.000005200000;
        grs80Para.false_northing = -670.706;
        grs80Para.false_easting = 1500102.765;
        proj = grs80Para;
    case 'rt90_5.0_gon_o'
        grs80Para.central_meridian = 22.0 + 33.380/60.0;
        grs80Para.scale = 1.000004900000;
        grs80Para.false_northing = -672.557;
        grs80Para.false_easting = 1500121.846;
        proj = grs80Para;
%  RT90 parameters, Bessel 1841 ellipsoid.
    case 'bessel_rt90_7.5_gon_v'
        besselPara.central_meridian = 11.0 + 18.0/60.0 + 29.8/3600.0;
        proj = besselPara;
    case 'bessel_rt90_5.0_gon_v' 
        besselPara.central_meridian = 13.0 + 33.0/60.0 + 29.8/3600.0;
        proj = besselPara;
    case 'bessel_rt90_2.5_gon_v'
        besselPara.central_meridian = 15.0 + 48.0/60.0 + 29.8/3600.0;
        proj = besselPara;
    case 'bessel_rt90_0.0_gon_v'
        besselPara.central_meridian = 18.0 + 3.0/60.0 + 29.8/3600.0;
        proj = besselPara;
    case 'bessel_rt90_2.5_gon_o'
        besselPara.central_meridian = 20.0 + 18.0/60.0 + 29.8/3600.0;   
        proj = besselPara;
    case 'bessel_rt90_5.0_gon_o'
        besselPara.central_meridian = 22.0 + 33.0/60.0 + 29.8/3600.0;   
        proj = besselPara;
%  SWEREF99TM and SWEREF99ddmm  parameters.
    case 'sweref_99_tm' 
        sweref99Para.central_meridian = 15.00;
        sweref99Para.lat_of_origin = 0.0;
        sweref99Para.scale = 0.9996;
        sweref99Para.false_northing = 0.0;
        sweref99Para.false_easting = 500000.0;
        proj = sweref99Para;
    case 'sweref_99_1200'
        sweref99Para.central_meridian = 12.00;
        proj = sweref99Para;
    case 'sweref_99_1330'
        sweref99Para.central_meridian = 13.50;
        proj = sweref99Para;
    case 'sweref_99_1500'
        sweref99Para.central_meridian = 15.00;
        proj = sweref99Para;
    case 'sweref_99_1630'
        sweref99Para.central_meridian = 16.50;
        proj = sweref99Para;
    case 'sweref_99_1800'
        sweref99Para.central_meridian = 18.00;
        proj = sweref99Para;
    case 'sweref_99_1415'
        sweref99Para.central_meridian = 14.25;
        proj = sweref99Para;
    case 'sweref_99_1545'
        sweref99Para.central_meridian = 15.75;
        proj = sweref99Para;
    case 'sweref_99_1715'
        sweref99Para.central_meridian = 17.25;
        proj = sweref99Para;
    case 'sweref_99_1845'
        sweref99Para.central_meridian = 18.75;
        proj = sweref99Para;
    case 'sweref_99_2015'
        sweref99Para.central_meridian = 20.25;
        proj = sweref99Para;
    case 'sweref_99_2145'
        sweref99Para.central_meridian = 21.75;
        proj = sweref99Para;
    case 'sweref_99_2315'
        sweref99Para.central_meridian = 23.25; 
        proj = sweref99Para;
    otherwise
        fprintf('Projection not in the list, using default parameters\n');
end

fprintf('ContertED from %s\n',projection);

e2 = proj.flattening * (2.0 - proj.flattening);
n = proj.flattening / (2.0 - proj.flattening);
a_roof = proj.axis / (1.0 + n) * (1.0 + n*n/4.0 + n*n*n*n/64.0);
delta1 = n/2.0 - 2.0*n*n/3.0 + 37.0*n*n*n/96.0 - n*n*n*n/360.0;
delta2 = n*n/48.0 + n*n*n/15.0 - 437.0*n*n*n*n/1440.0;
delta3 = 17.0*n*n*n/480.0 - 37*n*n*n*n/840.0;
delta4 = 4397.0*n*n*n*n/161280.0;
Astar = e2 + e2*e2 + e2*e2*e2 + e2*e2*e2*e2;
Bstar = -(7.0*e2*e2 + 17.0*e2*e2*e2 + 30.0*e2*e2*e2*e2) / 6.0;
Cstar = (224.0*e2*e2*e2 + 889.0*e2*e2*e2*e2) / 120.0;
Dstar = -(4279.0*e2*e2*e2*e2) / 1260.0;
lambda_zero = deg2rad(proj.central_meridian);

xi = (x - proj.false_northing) ./ (proj.scale * a_roof);
eta = (y - proj.false_easting) ./ (proj.scale * a_roof);

xi_prim = xi - delta1*sin(2.0*xi) .* cosh(2.0*eta) - ...
    delta2*sin(4.0*xi) .* cosh(4.0*eta) - ...
    delta3*sin(6.0*xi) .* cosh(6.0*eta) - ...
    delta4*sin(8.0*xi) .* cosh(8.0*eta);
eta_prim = eta -delta1*sin(2.0*xi) .* cosh(2.0*eta) - ...
    delta2*sin(4.0*xi) .* cosh(4.0*eta) - ...
    delta3*sin(6.0*xi) .* cosh(6.0*eta) - ...
    delta4*sin(8.0*xi) .* cosh(8.0*eta);
phi_star = asin(sin(xi_prim) ./ cosh(eta_prim));
delta_lambda = atan(sinh(eta_prim) ./ cos(xi_prim));

lon_radian = lambda_zero + delta_lambda;
lat_radian = phi_star + sin(phi_star) .* cos(phi_star) .* ...
    (Astar +...
    Bstar*(sin(phi_star).^2) +...
    Cstar*(sin(phi_star).^4) +...
    Dstar*(sin(phi_star).^6));
lat = rad2deg(lat_radian);
lon = rad2deg(lon_radian);
end