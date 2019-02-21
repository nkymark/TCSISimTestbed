% Simulates the engine system by calling the Simulink model 'Engine.mdl'. 
%
% (C) Mark Ng, 2019
% Ulster University, UK
%
%-------------------------------------------------------------------------%
%                          Load Driving Cycle
%-------------------------------------------------------------------------%
d_cycle = get( handles.drivingcycle, 'Value' ); % choice of driving cycle as selected from GUI

if d_cycle == 1
    load WLTP_MAN;
    dCycle = 'WLTP';
elseif d_cycle == 2
    load NEDC_MAN;
    dCycle = 'NEDC';
elseif d_cycle == 3
    load EUDC_MAN;
    dCycle = 'EUDC';
elseif d_cycle == 4
    load FTP75_MAN;
    dCycle = 'FTP_75';
end

%-------------------------------------------------------------------------%
%                          Fault settings
%-------------------------------------------------------------------------%
fault          = get( handles.faultcond, 'Value' ); % choice of fault as selected from GUI
faultSig.Name  = {'No_fault' 'fp_af' 'fC_vol' 'fW_af' 'fW_c' 'fW_ic' 'fW_th' 'fx_th' 'fyp_ic' 'fyp_im' 'fyT_ic' 'fyW_af'};
toggle         = zeros( 1,size( faultSig.Name, 2 ) + 1 );

% Fault to be simulated gets status of 1 (ON). Others are set to 0 (OFF).
toggle(fault)  = 1;
fault_free     = toggle(1);
toggle_paf     = toggle(2);
toggle_vol     = toggle(3);
toggle_Waf     = toggle(4);
toggle_Wc      = toggle(5);
toggle_Wic     = toggle(6);
toggle_Wth     = toggle(7);
toggle_xth     = toggle(8);
toggle_ypic    = toggle(9);
toggle_ypim    = toggle(10);
toggle_yTic    = toggle(11);
toggle_yWaf    = toggle(12);

%-------------------------------------------------------------------------%
%                        Print Initialisations to Log
%-------------------------------------------------------------------------%
Log = PrintLog( Log, '------------------------------------------------', 2, handles.outputLog );
Log = PrintLog( Log, sprintf( 'Simulation for %s Scenario', faultSig.Name{fault} ), 2, handles.outputLog );
Log = PrintLog( Log, '------------------------------------------------', 1, handles.outputLog );
Log = PrintLog( Log, sprintf( ' ' ), 2, handles.outputLog );
Log = PrintLog( Log, sprintf( 'Driving Cycle: %s (%d seconds)', dCycle, T_z(end) ), 2, handles.outputLog );
Log = PrintLog( Log, sprintf( ' ' ), 2, handles.outputLog );
Log = PrintLog( Log, '------------------------------------------------', 2, handles.outputLog );
Log = PrintLog( Log, sprintf( ' ' ), 2, handles.outputLog );

%-------------------------------------------------------------------------%
%        Load vehicle and engine parameters based on driving cycle
%-------------------------------------------------------------------------%
EngineData;                                            % Engine parameter and data
omega_min = TC_ENGINE.turbo.omega_min;                 
gearV = getGearShiftingVec( V_z );                     % Get gear shift data for 8 speed gearbox
car   = vehicleData;                                   % Vehicle parameter and data
Fair  = 0.5 * car.rho_a * car.cd * car.Af * V_z.^2;    % Air Drag Force
Froll = car.mv * car.cr * car.g * ( V_z ~= 0 );        % Roll Resistance Force (following V_z)

%-------------------------------------------------------------------------%
%   Put variables to workspace to be used by Engine System in Simulink
%-------------------------------------------------------------------------%
assignin( 'base', 'Fair', Fair );
assignin( 'base', 'Froll', Froll );
assignin( 'base', 'gearV', gearV );
assignin( 'base', 'car', car );
assignin( 'base', 'T_z', T_z );
assignin( 'base', 'V_z', V_z );
assignin( 'base', 'fault', fault );

%-------------------------------------------------------------------------%
% Generate reference signals for engine speed and torque based on driving cycle
%-------------------------------------------------------------------------%
Log = PrintLog( Log, 'Generating reference signals.........', 1, handles.outputLog );
load_system( 'RefGen' );
sim( 'RefGen', max( T_z ) );
bdclose RefGen;
Log = PrintLog( Log, ' [ DONE ]', 3, handles.outputLog );

%-------------------------------------------------------------------------%
%                          Simulate engine system
%-------------------------------------------------------------------------%
myVarList  = who;
for indVar = 1:length( myVarList )
    assignin( 'base', myVarList{indVar}, eval( myVarList{indVar} ) )
end

Log = PrintLog( Log, 'Loading engine system................', 1, handles.outputLog );
pause( 0.1 );
% open( 'Engine' );
load_system( 'Engine' );
open_system( 'Engine/Torque Measurements' );
open_system( 'Engine/Sensor Measurements' );
Log = PrintLog( Log, ' [ DONE ]', 3, handles.outputLog );
Log = PrintLog( Log, 'Simulating engine system.............', 1, handles.outputLog );
sim( 'Engine',T_z(end) );
bdclose Engine;
Log = PrintLog( Log, ' [ DONE ]', 3, handles.outputLog );

%-------------------------------------------------------------------------%
%          Collection of fault, inputs, and outputs signals
%-------------------------------------------------------------------------%
faultSig.Time = outputSig.Time;
faultSig.Data = [zeros( size( faultSig.Time, 1 ),1) fpafSig.Data fCvolSig.Data fWafSig.Data fWcSig.Data fWicSig.Data fWthSig.Data...
    fxthSig.Data fypicSig.Data fypimSig.Data fyTicSig.Data fyWafSig.Data];
for ii = 1:size( outputSig.Data,2 ) 
    outputSig.Data(:,ii) = addNoise( outputSig.Data(:,ii), mag2db( 120 ) );
end

inputSig.Name  = {'A_th' 'omega_e' 'u_wg' 'p_amb' 'T_amb' };
outputSig.Name = {'T_c' 'p_c' 'T_ic' 'p_ic' 'T_im' 'p_im' 'W_af' 'Tq_e' 'p_em'};
statesSig.Name = {'T_af' 'p_af' 'T_c' 'p_c' 'T_ic' 'p_ic' 'T_im' 'p_im' 'T_em' 'p_em' 'T_t' 'p_t' 'omega_t'};

assignin( 'base', 'faultSig', faultSig );
assignin( 'base', 'inputSig', inputSig );
assignin( 'base', 'outputSig', outputSig );
assignin( 'base', 'statesSig', statesSig );

%-------------------------------------------------------------------------%
%                          Plot ref vs actual torque
%-------------------------------------------------------------------------%
subplot( 1,1,1, 'Parent', handles.tq_plot );
plotTorque = plot( Tq_eREF.Time, Tq_eREF.Data, outputSig.Time, outputSig.Data(:,8) );
plotTorque(1).LineWidth = 1.5;
plotTorque(2).LineWidth = 1;
xlabel( 'Time (s)' );
ylabel( 'Torque (Nm)' );
title( 'Reference vs Measured Engine Torque' );
xlim( [0 outputSig.Time(end)] );
ylim( [0 max( Tq_eREF.Data )+50] );
legend( 'Reference torque','Engine torque' );
grid( 'on' );

%-------------------------------------------------------------------------%
%                              Plot fault 
%-------------------------------------------------------------------------%
subplot( 1,1,1, 'Parent', handles.fault_plot );
plotFault = plot( faultSig.Time(:), normalize( faultSig.Data(:,fault), 'range' ) );
xlabel( 'Time (s)' );
title( ['Fault Signal for ' faultSig.Name{fault} ' (normalised)'] );
xlim( [0 faultSig.Time(end)] );
grid( 'on' );
Log = PrintLog( Log, sprintf( ' ' ), 1, handles.outputLog );
Log = PrintLog( Log, '------------------------------------------------', 2, handles.outputLog );
Log = PrintLog( Log, sprintf( ' ' ), 1, handles.outputLog );

%-------------------------------------------------------------------------%
