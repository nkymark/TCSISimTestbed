% Script for setting up parameters for TCSI engine
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             Parameter initialization file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generic TCSI engine model approximating an 1.8 liter engine.
%% The model is built using the MVEM_lib v0.6 by Lars Eriksson.
%%
%%

%% Version 1.0: 2008-07-19
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Things to identify the engine.
TC_ENGINE.name = 'Generic TCSI engine model, 1.8 liter';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Ambient and generic gas data.
TC_ENGINE.ambient.p  = 101300;
TC_ENGINE.ambient.T  = 298;
TC_ENGINE.fuel.q_lhv = 4.4e+007;
TC_ENGINE.fuel.AFs   = 15.1;

TC_ENGINE.gasProp.air.cp    = 1005.2;
TC_ENGINE.gasProp.air.kappa = 1.4;
TC_ENGINE.gasProp.air.R     = 287.2;

TC_ENGINE.gasProp.exh.cp    = 1256.67;
TC_ENGINE.gasProp.exh.kappa = 1.3;
TC_ENGINE.gasProp.exh.R     = 290;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Air filter model parameters
TC_ENGINE.airFilter.H       = 2e+008;
TC_ENGINE.airFilter.p_lin   = 2000;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compressor model parameters
TC_ENGINE.compressor.D       = 0.06;
TC_ENGINE.compressor.Psi_max = 2.3;   % head parameter
TC_ENGINE.compressor.Phi_max = .12;   % flow parameter
TC_ENGINE.compressor.eta_max = .8;
TC_ENGINE.compressor.Phi_at_eta_max = TC_ENGINE.compressor.Phi_max/2;
TC_ENGINE.compressor.minEfficiency  = 0.3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Intercooler model parameters
TC_ENGINE.interCooler.epsilon = 0.8;
TC_ENGINE.interCooler.H       = 4e+008;
TC_ENGINE.interCooler.p_lin   = 500;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Throttle
TC_ENGINE.throttle.gamma = 2.0;
TC_ENGINE.throttle.maxPressureRatio = 0.9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Engine geometry parameters
TC_ENGINE.geometry.bore   = 0.0831;
TC_ENGINE.geometry.stroke = 0.0831;
TC_ENGINE.geometry.connectingRodLength = 0.14;
TC_ENGINE.geometry.V_d    = 0.0018;
TC_ENGINE.geometry.r_c    = 9.5;
TC_ENGINE.geometry.n_cyl  = 4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Engine model parameters
TC_ENGINE.air2cylinder.airMassFlowGain = 0.95;
TC_ENGINE.air2cylinder.fuelEvapPar     = 110;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Engine torque model parameters 
TC_ENGINE.torque.bmep.fit.C_tq1 = 2.3e5;
TC_ENGINE.torque.bmep.fit.C_tq2 = 1.23e+006;
TC_ENGINE.torque.etaOtto        = 0.4;
TC_ENGINE.torque.Pi_bl          = 2.0;
TC_ENGINE.torque.aux_dev_fric   = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
TC_ENGINE.controlVolumes.airFilter.V       = 0.010;
TC_ENGINE.controlVolumes.compressor.V      = 0.005;
TC_ENGINE.controlVolumes.interCooler.V     = 0.005;
TC_ENGINE.controlVolumes.intakeManifold.V  = 0.0018;
TC_ENGINE.controlVolumes.exhaustManifold.V = 0.0025;
TC_ENGINE.controlVolumes.exhaustSystem.V   = 0.02;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exhauast system model parameters - Turbine inlet temperature model
TC_ENGINE.exhMan.eManDiam   = 0.04;
TC_ENGINE.exhMan.eManLen    = 0.45;
TC_ENGINE.exhMan.nrOfParallelPipes = 4;
TC_ENGINE.exhMan.h_ext      = 95;
TC_ENGINE.exhMan.exh_mu     = 4e-005;
TC_ENGINE.exhMan.exh_lambda = 0.07;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Engine out temperature, linear model
TC_ENGINE.exhTemp.zeroFlowTemp       = 1100;
TC_ENGINE.exhTemp.tempChangeWithFlow = 3000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Turbocharger parameters
TC_ENGINE.turbo.damp_tc    = 1e-006;
TC_ENGINE.turbo.inertia_tc = 3e-005;
TC_ENGINE.turbo.omega_init = 3e3;
TC_ENGINE.turbo.omega_max  = 2.4e4;
TC_ENGINE.turbo.omega_min  = 2e3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Turbine parameters
TC_ENGINE.turbine.massFlow.fit.k1 = 0.017; 
TC_ENGINE.turbine.massFlow.fit.k2 = 1.4;
TC_ENGINE.turbine.efficiency.fit.maxEfficiency    = 0.75;
TC_ENGINE.turbine.efficiency.fit.maxEfficiencyBSR = 0.7;
TC_ENGINE.turbine.efficiency.fit.minEfficiency    = 0.3;
TC_ENGINE.turbine.D = 0.05;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exhaust system model parameters
TC_ENGINE.exhaustSystem.H     = 3e+008;
TC_ENGINE.exhaustSystem.p_lin = 300;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Wastegate
TC_ENGINE.wastegate.Amax = 0.00035;
TC_ENGINE.wastegate.Cd   = 0.9;

%% Controller parameters
KpThr = 2.0000e-07;
KpWg  = 2.0000e-07;
TiThr = 1.0000e-04;
TiWg  = 1.0000e-04;
V_D   = 0.0018;
a0    = 1.1647e-05;
a1    = 3.0718e-05;
a2    = 0.0029;
n_r   = 2;
r_c   = 9.5000;
dP_thrREF = 10000;
