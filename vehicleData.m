function car = generateVehicle8()
% GENERATEVEHICLE        Creates a struct that contains vehicle parameters
%                        (mv, cd, cr, Af) and also contants related to
%                        forces on the vehicle (g and rho_a)
%
%   Input:      '-'             - No inputs
%
%   Output:     'car'           - Struct containing fields of parameters
%
%   Author: Peter Nyberg
%   Created: 2013-10-07
%   Last modified: 2013-10-29

% Constants (not realy vehicle parameters but are here anyway)
g     = 9.81;    % acc due to gravity m/s^2
rho_a = 1.29;    % air density kg/m^3

% Vehicle parameter
mv = 1700;
cd = 0.29;
cr = 0.013;
Af = 2.28;

% Struct for passing parameters for the car
car.mv    = mv;
car.rho_a = rho_a;
car.Af    = Af;
car.cd    = cd;
car.g     = g;
car.cr    = cr;
car.rw    = 0.3234; % assuming 215/50R17
car.amax  = 2.8;    % Estimated, can be used in the MTF algorithms
car.eta_in = 1;     % Maybe used in the future?
car.eta_ut = 1;     % maybe used in the future?

% Parameters related to the engine efficiency
car.H_l   = 44.5e6; % J/kg
car.rho_f = 737.2;  % kg/m^3
car.J_e   = 0.2;    % kgm^2
car.V_d   = 3e-3;   % m^3 % 1.497e-3
car.e_g   = 0.4;    % -
car.p_me0 = 0.1e6;  % Pa
car.fr    = 2.774;
car.gr1   = 5.25*car.fr;
car.gr2   = 3.029*car.fr;
car.gr3   = 1.95*car.fr;
car.gr4   = 1.457*car.fr;
car.gr5   = 1.221*car.fr;
car.gr6   = car.fr;
car.gr7   = 0.809*car.fr;
car.gr8   = 0.673*car.fr;
car.T_e_max = 350;  % Nm

end
