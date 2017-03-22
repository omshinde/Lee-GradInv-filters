
% SIP Project: Smooth an image using Gradient-Inverse and Lee filter. Compare both.
% Submitted by- Rajat Shinde*, Brijesh Kr. Maravi, Paras Jhajharia
% *M.Tech 1st year, CSRE, IIT Bombay.


function varargout = SIP_Project(varargin)
% SIP_PROJECT MATLAB code for SIP_Project.fig
%      SIP_PROJECT, by itself, creates a new SIP_PROJECT or raises the existing
%      singleton*.
%
%      H = SIP_PROJECT returns the handle to a new SIP_PROJECT or the handle to
%      the existing singleton*.
%
%      SIP_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIP_PROJECT.M with the given input arguments.
%
%      SIP_PROJECT('Property','Value',...) creates a new SIP_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SIP_Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SIP_Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SIP_Project

% Last Modified by GUIDE v2.5 25-Oct-2016 13:58:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SIP_Project_OpeningFcn, ...
                   'gui_OutputFcn',  @SIP_Project_OutputFcn, ...
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


% --- Executes just before SIP_Project is made visible.
function SIP_Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SIP_Project (see VARARGIN)

% Choose default command line output for SIP_Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SIP_Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SIP_Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Function for comparing outputs obtained by 
%Lee filter and Gradient-Inverse fliter.

global outputImageLee
global outputImageGrad
figure,subplot(221),imshow(outputImageLee);
outputImageLee_BW=rgb2gray(outputImageLee);
subplot(222),imhist(outputImageLee_BW);
subplot(223),imshow(outputImageGrad);
outputImageGrad_BW=rgb2gray(outputImageGrad);
subplot(224),imhist(outputImageGrad_BW);




function edit_grad_Callback(hObject, eventdata, handles)
% hObject    handle to edit_grad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_grad as text
%        str2double(get(hObject,'String')) returns contents of edit_grad as a double


% --- Executes during object creation, after setting all properties.
function edit_grad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_grad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_grad.
function pushbutton_grad_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_grad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Function to compute output after applying Gradient-Inverse filter.
% It takes value of centre pixel weight from user.
% Used for smoothening.

global inputImage;
global outputImageGrad;
inputImage=im2double(inputImage);
inputImage=inputImage(:,:,1);
u=zeros(3);
h=zeros(3);
r=str2double(get(handles.edit_grad,'String'));  
outputImageGrad=zeros(size(inputImage));
[row ,col]=size(inputImage);
rad_value1=get(handles.radiobutton_33,'Value');
rad_value2=get(handles.radiobutton_55,'Value');
rad_value3=get(handles.radiobutton_77,'Value');
if rad_value1==1                                             %selecting the window size.          
    window_dim= 3;
elseif rad_value2==1
    window_dim=5;
else
    window_dim=7;
end
s=floor(window_dim/2);
inputImage=padarray(inputImage,[s,s],'replicate');
for i=(1+s):(row-s-2)
    for j=(1+s):(col-s-2)
        for k=-s:1:s
            for l=-s:1:s
                if inputImage(i+k,j+l)~=inputImage(i+k+s-1,j+l+s-1)
                    u(k+s+1,l+s+1)=abs(1/(inputImage(i+k+s-1,j+l+s-1)-inputImage(i+k,j+l)));
                else
                    u(k+s+1,l+s+1)=0.5;
                end
            end
        end
        
        for k=-1:1:1
            for l=-1:1:1
                h(k+2,l+2)=r*u(k+2,l+2)/sum(u(:));
                outputImageGrad(i,j)=outputImageGrad(i,j)+(h(k+2,l+2)*inputImage(i-k,j-l));
            end
        end
    end
end
figure;
set(gcf,'numbertitle','off','name','Output and Histogram of Gradient-Inverse filter')
imtool(outputImageGrad);
title('Output');
% outputImageGrad_BW=rgb2gray(outputImageGrad);
% subplot(222),imhist(outputImageGrad_BW);
% title('Histogram');




function edit_lee_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lee as text
%        str2double(get(hObject,'String')) returns contents of edit_lee as a double


% --- Executes during object creation, after setting all properties.
function edit_lee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_lee.
function pushbutton_lee_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Function which computes output after applying lee filter.
%The weighing function is taken as input from user.
%Window size is also selected by user.

weighing_function=str2double(get(handles.edit_lee,'String'));
global inputImage
global outputImageLee
inputImage=im2double(inputImage);
outputImageLee= zeros(size(inputImage));
[row, col]=size(inputImage);                    %calculates size of input image.

rad_value1=get(handles.radiobutton_33,'Value');
rad_value2=get(handles.radiobutton_55,'Value');
rad_value3=get(handles.radiobutton_77,'Value');
if rad_value1==1
    window_dim= 3;
elseif rad_value2==1
    window_dim=5;
else
    window_dim=7;
end
s=floor(window_dim/2);
inputImage=padarray(inputImage,[s,s],'replicate');
sum_of_elements=0;
for i=(1+s):(row-s-2)
    for j=(1+s):(col-s-2)
        for k=-s:1:s
            for l=-s:1:s
                x = inputImage(i-k,j-l);
                sum_of_elements = sum_of_elements+x;       % To calculate mean of all elements of a kernel.
                 
            end
        end
        mean_elements= sum_of_elements/(window_dim * window_dim);
        outputImageLee(i,j)= mean_elements+ (weighing_function*(inputImage(i,j)-mean_elements));
        sum_of_elements=0;
    end
end

figure;
set(gcf,'numbertitle','off','name','Output and Histogram of Lee filter')
imtool(outputImageLee);
title('Output');
%outputImageLee_BW=rgb2gray(outputImageLee);
%subplot(222),imhist(outputImageLee_BW);
%title('Histogram');



% --- Executes on button press in image_browse.
function image_browse_Callback(hObject, eventdata, handles)
% hObject    handle to image_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%To load an image from existing directory.
global inputImage
[row col]=size(inputImage);
[path, user_cance] =imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
inputImage=imread(path);
inputImage=im2double(inputImage);
axes(handles.axes_original_image);
imtool(inputImage);
set(handles.edit_path,'String',path);
set(handles.edit_size,'String',(row*col));


function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path as text
%        str2double(get(hObject,'String')) returns contents of edit_path as a double


% --- Executes during object creation, after setting all properties.
function edit_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_size as text
%        str2double(get(hObject,'String')) returns contents of edit_size as a double


% --- Executes during object creation, after setting all properties.
function edit_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
