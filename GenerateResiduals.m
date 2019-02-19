% Simulates the Residuals Generator for the 'Original 9' residuals based on the current sensors
% setup.
%
% (C) Mark Ng, 2019
% Ulster University, UK
%
%-------------------------------------------------------------------------%
%                    Main Codes For Residuals Generation                  
%-------------------------------------------------------------------------%
Log = PrintLog( Log, 'Simulating Residuals................. ', 1, handles.outputLog );

%-------------------------------------------------------------------------%
% Open and simulate the Simulink file. Requires modification to the
% Simulink file
%-------------------------------------------------------------------------%
load_system( 'ResidualsGen' );
sim( 'ResidualsGen', max( T_z ) );
bdclose 'ResidualsGen' ;

%-------------------------------------------------------------------------%
% Main codes here
%-------------------------------------------------------------------------%
thr = 5;    % threshold for detection of fault
load std_Data;
for ii = 1:size( Residuals.Data,2 )
    defRes(:,ii) = Residuals.Data(:,ii) / std_NF_def(ii);
end

defTime = Residuals.Time;
defRes = [defTime defRes];

assignin( 'base', 'defRes', defRes );
%-------------------------------------------------------------------------%

Log = PrintLog( Log, ' [ DONE ]', 3, handles.outputLog );
Log = PrintLog( Log, 'Residuals Generated.', 1, handles.outputLog );
Log = PrintLog( Log, ' ', 1, handles.outputLog );

%-------------------------------------------------------------------------%
% Run sync for time-varying vectors
%-------------------------------------------------------------------------%
load_system( 'SyncTime' );
set_param( 'SyncTime','StartTime', '1', 'StopTime', num2str( T_z(end) - 1 ) );
sim SyncTime;
bdclose SyncTime;

faultSig_sync.Name    = faultSig.Name;
inputSig_sync.Name    = inputSig.Name;
outputSig_sync.Name   = outputSig.Name;
statesSig_sync.Name   = statesSig.Name;
omega_eREF_sync.Name  = omega_eREF.Name;
Tq_eREF_sync.Name     = Tq_eREF.Name;
residualSig_sync.Name = {'rT_c' 'rp_c' 'rT_ic' 'rp_ic' 'rT_im' 'rp_im' 'rW_af' 'rTq_e' 'rp_em'};
assignin( 'base', 'residualSig_sync', residualSig_sync );
assignin( 'base', 'faultSig_sync', faultSig_sync );
assignin( 'base', 'inputSig_sync', inputSig_sync );
assignin( 'base', 'outputSig_sync', outputSig_sync );
assignin( 'base', 'statesSig_sync', statesSig_sync );
assignin( 'base', 'omega_eREF_sync', omega_eREF_sync );
assignin( 'base', 'Tq_eREF_sync', Tq_eREF_sync );

%-------------------------------------------------------------------------%
% Plot residual signals
%-------------------------------------------------------------------------%
Log   = PrintLog( Log, 'Plotting residual signals............', 1, handles.outputLog );
subplot( 1,1,1,'Parent',handles.res_plot );

for ii = 1:size( residualSig_sync.Data,2 )
    subplot( 3, 3, ii );
    plotResiduals = plot( residualSig_sync.Data(:,ii) );
    hold( 'on' );
    
    plotResiduals = plot( [0 length( residualSig_sync.Data(:,ii) )], [thr thr], 'r--' );
    plotResiduals = plot( [0 length( residualSig_sync.Data(:,ii) )], [-thr -thr], 'r--' );
        
    grid( 'on' );
    axis( [0 length( residualSig_sync.Time ) -inf inf] );
    title( residualSig_sync.Name{ii} );
    set( gca,'XTick',[] );
end

Log = PrintLog( Log, ' [ DONE ]', 3, handles.outputLog );
Log = PrintLog( Log, ' ', 1, handles.outputLog );
Log = PrintLog( Log, '------------------------------------------------', 1, handles.outputLog );
Log = PrintLog( Log, ' ', 1, handles.outputLog );

%-------------------------------------------------------------------------%

