    function varargout = gui_v1(varargin)

% GUI_V1 MATLAB code for gui_v1.fig
%      GUI_V1, by itself, creates a new GUI_V1 or raises the existing
%      singleton*.
%
%      H = GUI_V1 returns the handle to a new GUI_V1 or the handle to
%      the existing singleton*.
%
%      GUI_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_V1.M with the given input arguments.
%
%      GUI_V1('Property','Value',...) creates a new GUI_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_v1

% Last Modified by GUIDE v2.5 19-Jul-2021 13:27:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_v1_OutputFcn, ...
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


% --- Executes just before gui_v1 is made visible.
function gui_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_v1 (see VARARGIN)

% Create the data to plot.
% handles.peaks=peaks(35);
% handles.membrane=membrane;
% [x,y] = meshgrid(-8:.5:8);
% r = sqrt(x.^2+y.^2) + eps;
% sinc = sin(r)./r;
% handles.sinc = sinc;
% % Set the current data value.
% handles.current_data = handles.peaks;
% surf(handles.current_data)

handles.sens = 'Pm';
handles.acti = 'Pm';
handles.datasource = 0;
handles.sliderValue = 0.5;

handles.graphDat = EnergyLevelModel(handles.sens, handles.acti, handles.datasource, handles.sliderValue);
handles.current_data = handles.graphDat;
plot(handles.current_data)
axis([0 800 0 1.2])
xlabel('Wavelength in nm')
ylabel('Relative radiance')
title('Predicted emission wavelengths')

% Choose default command line output for gui_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
case 'Neodymium' 
   handles.sens = 'Nd';
case 'Cerium' 
   handles.sens = 'Ce';
case 'Promethium'
    handles.sens = 'Pm';
case 'Holmium'
    handles.sens = 'Ho';
case 'Samarium'
    handles.sens = 'Sm';
case 'Dysprosium'    
    handles.sens = 'Dy';
case 'Erbium'
    handles.sens = 'Er';
case 'Praseodynium'
    handles.sens = 'Pr';
case 'Thulium'
    handles.sens = 'Tm';
case 'Gadolinium'
    handles.sens = 'Gd';
case 'Europium'
    handles.sens = 'Eu';
case 'Terbium'
    handles.sens = 'Tb';
case 'Ytterbium'
    handles.sens = 'Yb';
end

handles.graphDat = EnergyLevelModel(handles.sens, handles.acti, handles.datasource, handles.sliderValue);
handles.current_data = handles.graphDat;
plot(handles.current_data)
axis([0 800 0 1.2])
xlabel('Wavelength in nm')
ylabel('Relative radiance')
title('Predicted emission wavelengths')

% Praseodynium
% Thulium
% Gadolinium
% Europium
% Terbium
% Ytterbium

% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
case 'Neodymium' 
   handles.acti = 'Nd';
case 'Cerium' 
   handles.acti = 'Ce';
case 'Promethium'
    handles.acti = 'Pm';
case 'Holmium'
    handles.acti = 'Ho';
case 'Samarium'
    handles.acti = 'Sm';
case 'Dysprosium'    
    handles.acti = 'Dy';
case 'Erbium'
    handles.acti = 'Er';
case 'Praseodynium'
    handles.acti = 'Pr';
case 'Thulium'
    handles.acti = 'Tm';
case 'Gadolinium'
    handles.acti = 'Gd';
    handles.graphDat = EnergyLevelModel(handles.sens, handles.acti, handles.datasource, handles.sliderValue)
case 'Europium'
    handles.acti = 'Eu';
case 'Terbium'
    handles.acti = 'Tb';
case 'Ytterbium'
    handles.acti = 'Yb';
end

guidata(hObject,handles)

handles.graphDat = EnergyLevelModel(handles.sens, handles.acti, handles.datasource, handles.sliderValue);
handles.current_data = handles.graphDat;
plot(handles.current_data)
axis([0 800 0 1.2])
xlabel('Wavelength in nm')
ylabel('Relative radiance')
title(append('Predicted emission wavelengths'))

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function altdatasrc_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to altdatasrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.datasource = handles.datasource + 1

handles.graphDat = EnergyLevelModel(handles.sens, handles.acti, handles.datasource, handles.sliderValue);
handles.current_data = handles.graphDat;
plot(handles.current_data)
axis([0 800 0 1.2])
xlabel('Wavelength in nm')
ylabel('Relative radiance')
title(append('Predicted emission wavelengths'))
% handles


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.slider1,'Value');
handles.sliderValue = sliderValue;
handles.graphDat = EnergyLevelModel(handles.sens, handles.acti, handles.datasource, handles.sliderValue);
handles.current_data = handles.graphDat;
plot(handles.current_data)
axis([0 800 0 1.2])
xlabel('Wavelength in nm')
ylabel('Relative radiance')
title('Predicted emission wavelengths')

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
