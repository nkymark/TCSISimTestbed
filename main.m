% Runs the GUI for the engine benchmark model and subsequently the simulation process. 
%
% (C) Mark Ng, 2019
% Ulster Universitym UK

function varargout = main(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
set( handles.faultcond, 'Value', 1 );
set( handles.drivingcycle, 'Value', 1 );

axes( handles.SEBD );
[im,map,alpha] = imread( 'SEBD.png' );
BD = imshow( im );
set( BD, 'AlphaData', alpha );
format compact;
set( 0, 'DefaultTextInterpreter', 'none' ); % remove LaTeX syntax in plots
axis off; axis image; clc;

guidata(hObject, handles);


function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function faultcond_Callback(hObject, eventdata, handles)


function faultcond_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Simulate.
function Simulate_Callback(hObject, eventdata, handles)
% Clear and reset plots and initialisations
clc;
Log = [];
subplot( 1,1,1, 'Parent', handles.fault_plot ); cla reset;
subplot( 1,1,1, 'Parent', handles.tq_plot ); cla reset;
subplot( 1,1,1, 'Parent', handles.res_plot ); cla reset;
evalin( 'base','clear all' );
tic;

sim_mode = get( handles.simmode, 'Value' );
% Simulate Engine only
if sim_mode == 1
    RunEngine;
    
% Simulate Engine + Generate Residuals + Run FI
elseif sim_mode == 2
    RunEngine;
    GenerateResiduals;
    RunFI;
end

SaveData; % Save data and results to local folder


function Simulate_CreateFcn(hObject, eventdata, handles)


function drivingcycle_Callback(hObject, eventdata, handles)


function drivingcycle_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function outputLog_Callback(hObject, eventdata, handles)


function outputLog_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function simmode_Callback(hObject, eventdata, handles)


function simmode_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function RefButton_ButtonDownFcn(hObject, eventdata, handles)
open( 'RefGen.mdl' );


function ControllerButton_ButtonDownFcn(hObject, eventdata, handles)
open( 'Engine.mdl' );


function EngineButton_ButtonDownFcn(hObject, eventdata, handles)
open( 'Engine.mdl' );


function ResGenButton_ButtonDownFcn(hObject, eventdata, handles)
open( 'ResidualsGen.mdl' );


function editResGenM_Callback(hObject, eventdata, handles)
edit GenerateResiduals.m;


function FISchemeDesign_ButtonDownFcn(hObject, eventdata, handles)
edit RunFI.m;


function Exit_Callback(hObject, eventdata, handles)
clear all; close all; 
