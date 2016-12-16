function varargout = student_test_times(varargin)
% STUDENT_TEST_TIMES MATLAB code for student_test_times.fig
%      STUDENT_TEST_TIMES, by itself, creates a new STUDENT_TEST_TIMES or raises the existing
%      singleton*.
%
%      H = STUDENT_TEST_TIMES returns the handle to a new STUDENT_TEST_TIMES or the handle to
%      the existing singleton*.
%
%      STUDENT_TEST_TIMES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STUDENT_TEST_TIMES.M with the given input arguments.
%
%      STUDENT_TEST_TIMES('Property','Value',...) creates a new STUDENT_TEST_TIMES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before student_test_times_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to student_test_times_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help student_test_times

% Last Modified by GUIDE v2.5 16-Dec-2016 08:51:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @student_test_times_OpeningFcn, ...
                   'gui_OutputFcn',  @student_test_times_OutputFcn, ...
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


% --- Executes just before student_test_times is made visible.
function student_test_times_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to student_test_times (see VARARGIN)

% Choose default command line output for student_test_times
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes student_test_times wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global examStart;
global firstDone;
global numDone;
global examEnd;
global meanTime;
global medianTime;
global isStarted;
global allTimes;
examStart = 0;
firstDone = 0;
examEnd = 0;
meanTime = 0;
medianTime = 0;
allTimes = [];
isStarted = false;
numDone = 0;
% need to update the labels... maybe create a function?



% --- Outputs from this function are returned to the command line.
function varargout = student_test_times_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isStarted;
global examStart;
if isStarted == false
    set(handles.turnInButton,'Visible','On');
    set(handles.finishButton,'Visible','On');
    set(handles.exportLabel,'Visible','Off');
    set(handles.exportButton,'Visible','Off');
    set(handles.fileNameBox,'Visible','Off');
    set(handles.startButton,'Visible','Off');
    isStarted = true;
    examStart = 0;
    firstDone = 0;
    examEnd = 0;
    meanTime = 0;
    medianTime = 0;
    allTimes = [];
    isStarted = false;
    numDone = 0;
    histogram(allTimes);
end
c=clock;
if c(5) > 9
    startLabel = strcat(num2str(c(4)),':',num2str(c(5)));
else
    startLabel = strcat(num2str(c(4)),':0',num2str(c(5)));
end
set(handles.examStartLabel,'String',startLabel);
examStart=c(4)*60+c(5);


% --- Executes on button press in turnInButton.
function turnInButton_Callback(hObject, eventdata, handles)
% hObject    handle to turnInButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global numDone;
global examStart;
global firstDone;
global allTimes;
global meanTime;
global medianTime;

c = clock;
finishTime = c(4)*60+c(5);
testingTime = finishTime-examStart; % how many minutes since exam started
if numDone == 0
    firstDone = testingTime;
    set(handles.firstDoneLabel,'String',num2str(testingTime));
end

% calculate statistics
numDone = numDone + 1;
allTimes = [allTimes testingTime]
meanTime = mean(allTimes)
medianTime = median(allTimes)

%update labels
set(handles.numDoneLabel,'String',numDone);
set(handles.meanTimeLabel,'String',meanTime);
set(handles.medianTimeLabel,'String',medianTime);

histogram(allTimes);





% --- Executes on button press in finishButton.
function finishButton_Callback(hObject, eventdata, handles)
% hObject    handle to finishButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isStarted;
global examEnd;


% get the time
c = clock;

isStarted = false;

% change visibilities accordingle
set(handles.turnInButton,'Visible','Off');
set(handles.finishButton,'Visible','Off');
set(handles.exportLabel,'Visible','On');
set(handles.fileNameBox,'Visible','On');
set(handles.exportButton,'Visible','On');
set(handles.startButton,'Visible','On');





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fileNameBox_Callback(hObject, eventdata, handles)
% hObject    handle to fileNameBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileNameBox as text
%        str2double(get(hObject,'String')) returns contents of fileNameBox as a double


% --- Executes during object creation, after setting all properties.
function fileNameBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileNameBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exportButton.
function exportButton_Callback(hObject, eventdata, handles)
% hObject    handle to exportButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global allTimes;
save(get(handles.fileNameBox,'String'),'allTimes');

