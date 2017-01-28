function varargout = test_entry_wb_app(varargin)
% TEST_ENTRY_WB_APP M-file for test_entry_wb_app.fig
%      TEST_ENTRY_WB_APP, by itself, creates a new TEST_ENTRY_WB_APP or raises the existing
%      singleton*.
%
%      H = TEST_ENTRY_WB_APP returns the handle to a new TEST_ENTRY_WB_APP or the handle to
%      the existing singleton*.
%
%      TEST_ENTRY_WB_APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_ENTRY_WB_APP.M with the given input arguments.
%
%      TEST_ENTRY_WB_APP('Property','Value',...) creates a new TEST_ENTRY_WB_APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_entry_wb_app_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_entry_wb_app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_entry_wb_app

% Last Modified by GUIDE v2.5 05-Aug-2012 15:13:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_entry_wb_app_OpeningFcn, ...
                   'gui_OutputFcn',  @test_entry_wb_app_OutputFcn, ...
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


% --- Executes just before test_entry_wb_app is made visible.
function test_entry_wb_app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_entry_wb_app (see VARARGIN)

% Choose default command line output for test_entry_wb_app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_entry_wb_app wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_entry_wb_app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in FuncPlotSpectrum.
function FuncPlotSpectrum_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_ana_prbs_response();

% --- Executes on button press in FuncPlotGroupVelTest.
function FuncPlotGroupVelTest_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotGroupVelTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_plot_group_vel_step_test();

% --- Executes on button press in FuncPlotOneVelTestCase.
function FuncPlotOneVelTestCase_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotOneVelTestCase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_plot_one_vel_step_test();

% --- Executes on button press in FuncPlotWbWaveform.
function FuncPlotWbWaveform_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotWbWaveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_ana_wb_waveform();

% --- Executes on button press in FuncPlotACS_FRF.
function FuncPlotACS_FRF_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotACS_FRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_plot_acs_frf_output();

% --- Executes on button press in FuncPlotTuneMotion.
function FuncPlotTuneMotion_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotTuneMotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_ana_plot_motion_prof();

% --- Executes on button press in FuncPlotTuneZ_B1W.
function FuncPlotTuneZ_B1W_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotTuneZ_B1W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_plot_b1w_stop_srch();


% --- Executes on button press in FuncExit.
function FuncExit_Callback(hObject, eventdata, handles)
% hObject    handle to FuncExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes on button press in FuncPlotSineSweep.
function FuncPlotSineSweep_Callback(hObject, eventdata, handles)
% hObject    handle to FuncPlotSineSweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test_ana_SineSweep_response();

