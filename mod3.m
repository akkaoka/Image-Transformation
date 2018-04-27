function varargout = mod3(varargin)
% MOD3 MATLAB code for mod3.fig
%      MOD3, by itself, creates a new MOD3 or raises the existing
%      singleton*.
%
%      H = MOD3 returns the handle to a new MOD3 or the handle to
%      the existing singleton*.
%
%      MOD3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOD3.M with the given input arguments.
%
%      MOD3('Property','Value',...) creates a new MOD3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mod3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mod3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mod3

% Last Modified by GUIDE v2.5 11-Apr-2018 18:03:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mod3_OpeningFcn, ...
                   'gui_OutputFcn',  @mod3_OutputFcn, ...
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


% --- Executes just before mod3 is made visible.
function mod3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mod3 (see VARARGIN)

% Choose default command line output for mod3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mod3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mod3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_btn.
function open_btn_Callback(hObject, eventdata, handles)
% hObject    handle to open_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
[name_file1,name_path1] = uigetfile( ...
{'*.bmp;*.jpg;','Files of type (*.bmp,*.jpg)';},...
'Open Image');
    if ~isequal(name_file1,0)
        data = imread(fullfile(name_path1,name_file1));
        guidata(hObject,handles);
        axes(handles.ib1);
        imshow(data);
    else
        return;
    end

% --- Executes on button press in exit_btn.
function exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
close()

% --- Executes on button press in inwavelet_btn.

% --- Executes on button press in dft_btn.
function dft_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dft_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global data
global dft
bw = rgb2gray(data);
level = fft2(bw);
dft = fftshift(level);
guidata(hObject,handles);
axes(handles.ib2);
imshow(log(abs(dft)),[]);
toc
disp(toc)

% --- Executes on button press in dct_btn.
function dct_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dct_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global data
global dct
bw = rgb2gray(data);
dct = dct2(bw);
guidata(hObject,handles);
axes(handles.ib2);
imshow(log(abs(dct)),[]);
toc
disp(toc)

% --- Executes on button press in fft_btn.
function fft_btn_Callback(hObject, eventdata, handles)
% hObject    handle to fft_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global data
global fft
bw = rgb2gray(data);
level = fft2(bw);
fft = fftshift(level);
guidata(hObject,handles);
axes(handles.ib2);
imshow(log(1+abs(fft)),[]);
toc
disp(toc)

% --- Executes on button press in wavelet_btn.
function wavelet_btn_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
tic
global data
[cA,cH,cV,cD] = dwt2(im2double(data),'haar');
gray = rgb2gray(data);
guidata(hObject,handles);
axes(handles.ib2);
% rectangle('Position',[0,0,1,2],'LineWidth',2,'EdgeColor','y');
% rectangle('Position',[1,0,1,2],'LineWidth',2,'EdgeColor','y');
% rectangle('Position',[0,2,1,2],'LineWidth',2,'EdgeColor','y');
% rectangle('Position',[1,2,1,2],'LineWidth',2,'EdgeColor','y');
imshow([cA,cH; cV,cD],'Colormap',gray);
toc
disp(toc)

% --- Executes on button press in indft_btn.
function indft_btn_Callback(hObject, eventdata, handles)
% hObject    handle to indft_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global dft
F = ifftshift(dft); 
indft = ifft2(F);
guidata(hObject,handles);
axes(handles.ib3);
imshow(indft,[]);
toc
disp(toc)

% --- Executes on button press in indct_btn.
function indct_btn_Callback(hObject, eventdata, handles)
% hObject    handle to indct_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global dct
indct = idct2(dct);
guidata(hObject,handles);
axes(handles.ib3);
imshow(indct,[]);
toc
disp(toc)

% --- Executes on button press in infft_btn.
function infft_btn_Callback(hObject, eventdata, handles)
% hObject    handle to infft_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global fft
F = ifftshift(fft); 
infft = ifft2(F);
guidata(hObject,handles);
axes(handles.ib3);
imshow(infft,[]);
toc
disp(toc)

function inwavelet_btn_Callback(hObject, eventdata, handles)
% hObject    handle to inwavelet_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global data
sX=size(data);
[cA,cH,cV,cD]=dwt2(data,'haar');
inwavel=idwt2(cA,cH,cV,cD,'haar',sX);
inwavel = uint8(inwavel);
guidata(hObject,handles);
axes(handles.ib3);
imshow(inwavel);
toc
disp(toc)
