function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 13-Dec-2023 02:16:36

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function amp_Callback(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp as text
%        str2double(get(hObject,'String')) returns contents of amp as a double


% --- Executes during object creation, after setting all properties.
function amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freq_Callback(hObject, eventdata, handles)
% hObject    handle to freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq as text
%        str2double(get(hObject,'String')) returns contents of freq as a double


% --- Executes during object creation, after setting all properties.
function freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Plot Callback

function plot_Callback(hObject, eventdata, handles)

global selected
global t
global sinSignal
global squareWave
global t_rec

% Retrieve amplitude and frequency values from GUI input
    amplitude = str2double(get(handles.amp, 'String'));
    frequency = str2double(get(handles.freq, 'String'));
t = linspace(0, 10,1000);
% Generate time vector
%t = linspace(0, 1,1000); % Time vector

if strcmp(selected, 'Sin wave')
    % Generate sin wave
    sinSignal = amplitude * sin(2 * pi * frequency * t);
    
    % Plot sin wave
    plot(handles.prime, t, sinSignal,'r','LineWidth', 2);
    xlabel(handles.prime, 'Time');
    ylabel(handles.prime, 'Amplitude');
    title(handles.prime, 'Sine Wave');
    grid(handles.prime, 'on'); 
    ylim(handles.prime, [min(sinSignal)-1 max(sinSignal)+1]); % Set x-axis from 0 to 1 and y-axis from -1 to 1
    
    
elseif strcmp(selected, 'Rectangular wave')
% Retrieve duty cycle value from GUI input
    dutyCycle = str2double(get(handles.duty, 'String')); % Convert percentage to fraction

    t_rec = 0:0.001:50; % Time vector

    % Generate square wave
    squareWave = amplitude * square(2 * pi * (frequency/100) * t_rec, dutyCycle);

% Plot the square wave
    plot(handles.second, t_rec, squareWave, 'm', 'LineWidth', 2);
    xlabel(handles.second, 'Time');
    ylabel(handles.second, 'Amplitude');
    title(handles.second, 'Rectangular Wave');
    grid(handles.second, 'on');

end
    
% Menu Callback
function menu_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject, 'String'));
option = contents{get(hObject, 'Value')};

global selected
selected = option;
%guidata(hObject,handles)

if strcmp(selected, 'Sin wave')
    % Hide duty cycle UI component
    set(handles.dc,'Visible','off');
    set(handles.duty, 'Visible', 'off');
else
    % Show duty cycle UI component
    set(handles.dc, 'Visible', 'on');
    set(handles.duty, 'Visible', 'on');
end

% --- Executes during object creation, after setting all properties.
function menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on menu and none of its controls.
function menu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

function duty_Callback(hObject, eventdata, handles)
% hObject    handle to duty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duty as text
%        str2double(get(hObject,'String')) returns contents of duty as a double


% --- Executes during object creation, after setting all properties.
function duty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to duty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duty as text
%        str2double(get(hObject,'String')) returns contents of duty as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fsc_Callback(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check the state of the radio button
if get(hObject,'Value') == 1 % If the radio button is selected
       set(handles.con, 'Value', 0);
       set(handles.InputPanel, 'Visible', 'off');
    set(handles.clc, 'Value', 0);
    % Define the parameters
    T = 1; % Time period of the square wave
    N = 50; % Number of coefficients

    % Calculate Fourier coefficients
    n = 1:N;
    a_n = zeros(size(n)); % Coefficients for sine terms

    for i = 1:numel(n)
        if mod(n(i), 2) == 1 % Coefficients for odd harmonics
            a_n(i) = (4/T) * (1/n(i) * pi) * sin(n(i) * pi / 2);
        end
    end

    % Plot the coefficients
    plot(handles.third,n, a_n,'k');
    xlabel(handles.third,'Coefficient Index (n)');
    ylabel(handles.third,'Coefficient Value');
    title(handles.third,'Fourier Series Coefficients of a Square Wave');
    grid(handles.third, 'on');
    axis([-1 50 -5  15]); % Set x-axis from 0 to 1 and y-axis from -1 to 1

end

function clc_Callback(hObject, eventdata, handles)
% hObject    handle to clc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Clear plots
% If the radio button is selecteds
cla(handles.third); % Clear the plot (assuming handles.third is your plot's axes)
cla(handles.second);
cla(handles.prime);

set(handles.con, 'Value', 0);
set(handles.fsc, 'Value', 0);

set(handles.left, 'Value', 0);
set(handles.right, 'Value', 0); 
 
grid(handles.second, 'off');
grid(handles.third, 'off');
grid(handles.prime, 'off');

% Clear the values of edit boxes (assuming these are edit boxes)
set(handles.shift, 'String', '');  % Clear the value of the 'shift' edit box
set(handles.amp, 'String', '');    % Clear the value of the 'amp' edit box
set(handles.freq, 'String', '');   % Clear the value of the 'freq' edit box
set(handles.duty, 'String', '');   % Clear the value of the 'duty' edit box

% Clear titles and labels
delete(get(handles.third,'Title')); % Clear title for handles.third
delete(get(handles.second,'Title')); % Clear title for handles.second
delete(get(handles.prime,'Title')); % Clear title for handles.prime

delete(get(handles.third,'XLabel')); % Clear x-axis label for handles.third
delete(get(handles.second,'XLabel')); % Clear x-axis label for handles.second
delete(get(handles.prime,'XLabel')); % Clear x-axis label for handles.prime

delete(get(handles.third,'YLabel')); % Clear y-axis label for handles.third
delete(get(handles.second,'YLabel')); % Clear y-axis label for handles.second
delete(get(handles.prime,'YLabel')); % Clear y-axis label for handles.prime


% --- Executes during object creation, after setting all properties.
function msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%msgbox('Welcome to my GUI');


% --- Executes on button press in left.
function left_Callback(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1 
     set(handles.right, 'Value', 0);
    set(handles.shift, 'Visible', 'on');
else
    set(handles.shift, 'Visible', 'off');
end
% Hint: get(hObject,'Value') returns toggle state of left


% --- Executes on button press in right.
function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1 
     set(handles.left, 'Value', 0);
    set(handles.shift, 'Visible', 'on');
else
    set(handles.shift, 'Visible', 'off');
end
% Hint: get(hObject,'Value') returns toggle state of right


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


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


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1



function shift_Callback(hObject, eventdata, handles)
% hObject    handle to shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Get the value entered in the shift textbox from the GUI
    global t
    global t_rec
    global selected
    global sinSignal
    global squareWave
    
    CT_shift = str2double(get(handles.shift, 'String'));
     
    if strcmp(selected, 'Sin wave') &&  get(handles.left, 'Value') == 1 ;
    shifted_sine_wave=t-CT_shift;
    plot(handles.second, shifted_sine_wave, sinSignal, 'k','LineWidth', 2);
    xlabel(handles.second, 'Time');
    ylabel(handles.second, 'Amplitude');
    title(handles.second, 'Sin Wave with Left Shift');
    grid(handles.second, 'on');
   %axis([min(n1)-1 max(n1)+1 min(x)-1 max(x)+1]);
    
    elseif  strcmp(selected, 'Sin wave') && get(handles.right, 'Value') == 1 ;
    shifted_sine_wave=t+CT_shift;
    plot(handles.second, shifted_sine_wave, sinSignal, 'k','LineWidth', 2);
    xlabel(handles.second, 'Time');
    ylabel(handles.second, 'Amplitude');
    title(handles.second, 'Sin Wave with Right Shift');
    grid(handles.second, 'on');
    
    elseif  strcmp(selected, 'Rectangular wave') && get(handles.left, 'Value') == 1 ;
    shifted_rect_wave=t_rec-CT_shift;
    plot(handles.prime, shifted_rect_wave, squareWave, 'k','LineWidth', 2);
    xlabel(handles.prime, 'Time');
    ylabel(handles.prime, 'Amplitude');
    title(handles.prime, 'Rectangular Wave with Left Shift');
    grid(handles.prime, 'on');
    
    elseif  strcmp(selected, 'Rectangular wave') && get(handles.right, 'Value') == 1 ;
    shifted_rect_wave=t_rec+CT_shift;
    plot(handles.prime, shifted_rect_wave, squareWave, 'k','LineWidth', 2);
    xlabel(handles.prime, 'Time');
    ylabel(handles.prime, 'Amplitude');
    title(handles.prime, 'Rectangular Wave with Right Shift');
    grid(handles.prime, 'on');
    else
     disp('Please select the wave and shift direction.');
    end


% Hints: get(hObject,'String') returns contents of shift as text
%        str2double(get(hObject,'String')) returns contents of shift as a double


% --- Executes during object creation, after setting all properties.
function shift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in con.
function con_Callback(hObject, eventdata, handles)
% hObject    handle to con (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1 % If the radio button is selected
   set(handles.fsc, 'Value', 0);
    set(handles.clc, 'Value', 0);
    set(handles.InputPanel, 'Visible', 'on');
    
end
% Hint: get(hObject,'Value') returns toggle state of con



function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function impulse_Callback(hObject, eventdata, handles)
% hObject    handle to impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of impulse as text
%        str2double(get(hObject,'String')) returns contents of impulse as a double


% --- Executes during object creation, after setting all properties.
function impulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
