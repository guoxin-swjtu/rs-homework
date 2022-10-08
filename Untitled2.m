function varargout = MainForm(varargin)
% 
MAINFORM MATLAB 
code for MainForm.fig 
% 
MAINFORM, by itself, 
creates a new MAINFORM or raises the existing 
% singleton.
% 
% 
H = MAINFORM 
returns the handle to a new MAINFORM or the handle to 
% 
the existing singleton. 
% 
% 
MAINFORM('CALLBACK',hObject,eventData,handles) 
    calls the local 
% 
function named 
CALLBACK in MAINFORM.
M with the given input arguments. 
% 
% 
MAINFORM('Property','Value') 
    creates a new MAINFORM or raises the 
% 
existing singleton*.
Starting from the left, 
property value pairs are 
% 
applied to the GUI before MainFormOpeningFcn gets called. 
An 
% 
unrecognized property name or invalid value makes property application 
% 
stop. All 
inputs are passed to MainFormOpeningFcn via varargin. 
% 
% *
See GUI 
Options on 
GUIDE Tools menu.
Choose "
GUI allows only one 
% 
instance to run (singleton)". 
% 
% 
See also: GUIDE, GUIDATA, GUIHANDLES

% 
Edit the above text to modify the response to help MainForm

% 
Last Modified by GUIDE v2.5 01-May-2021 22:52:25

% 
Begin initialization code - DO NOT EDIT 
guiSingleton = 1; 
guiState = struct('guiName', mfilename, ... 'guiSingleton', guiSingleton, ... 'guiOpeningFcn', @MainFormOpeningFcn, ... 'guiOutputFcn', @MainFormOutputFcn, ... 'guiLayoutFcn', [] , ... 'guiCallback', []); 
    if nargin && ischar(varargin{1}) 
    guiState.gui_Callback = str2func(varargin{1}); 
    end

if nargout [varargout{1:nargout}] = guimainfcn(guiState, varargin{:}); else guimainfcn(guiState, varargin{:}); end % End initialization code - DO NOT EDIT

% --- 
Executes just before MainForm is made visible. 
function MainForm_OpeningFcn(hObject, eventdata, handles, varargin) % 
This function has no output args, see OutputFcn. % 
hObject handle to figure % 
eventdata reserved - to be defined in a future version of MATLAB % 
handles structure with handles and user data (see GUIDATA) % 
varargin command line arguments to MainForm (see VARARGIN)

% 
Choose default command line output for MainForm handles.output = hObject; clc; axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', ''); axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', ''); axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', '');

% Update handles structure guidata(hObject, handles);

% UIWAIT makes MainForm wait for user response (see UIRESUME) % uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line. function varargout = MainForm_OutputFcn(hObject, eventdata, handles) % varargout cell array for returning output args (see VARARGOUT); % hObject handle to figure % eventdata reserved - to be defined in a future version of MATLAB % handles structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure varargout{1} = handles.output;

% --- Executes on button press in pushbutton1. function pushbutton1Callback(hObject, eventdata, handles) % hObject handle to pushbutton1 (see GCBO) % eventdata reserved - to be defined in a future version of MATLAB % handles structure with handles and user data (see GUIDATA) clc; axes(handles.axes1); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', ''); axes(handles.axes2); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', ''); axes(handles.axes3); cla reset; box on; set(gca, 'XTickLabel', '', 'YTickLabel', ''); handles.file1 = []; handles.file2 = []; handles.result = []; [filename, pathname] = uigetfile({'*.jpg;*.bmp;*.tif;*.png;*.gif', 'All Image Files';... '*.*', 'All Files' }, '选择图像1', ... fullfile(pwd, 'images\实验图像1\a.tif')); if isequal(filename, 0) return; end handles.file1 = fullfile(pathname, filename); Img1=imread(fullfile(pathname, filename)); % I=rgb2gray(Img); % Img1 = imresize(I,[240,320]); axes(handles.axes1); imshow(Img1, []); handles.Img1 =Img1 ; guidata(hObject, handles); % --- Executes on button press in pushbutton2. function pushbutton2Callback(hObject, eventdata, handles) % hObject handle to pushbutton2 (see GCBO) % eventdata reserved - to be defined in a future version of MATLAB % handles structure with handles and user data (see GUIDATA) [filename, pathname] = uigetfile({'.jpg;.bmp;.tif;.png;.gif', 'All Image Files';... '.*', 'All Files' }, '选择图像2', ... fullfile(pwd, 'images\实验图像1\b.tif')); if isequal(filename, 0) return; end handles.file2 = fullfile(pathname, filename);

Img2 =imread(fullfile(pathname, filename)); axes(handles.axes2); imshow(Img2, []); handles.Img2 =Img2 ; guidata(hObject, handles); 
% --- Executes on button press in pushbutton3. 
function pushbutton3Callback(hObject, eventdata, handles) 
% hObject handle to pushbutton3 (see GCBO) 
% eventdata reserved - to be defined in a future version of MATLAB 
% handles structure with handles and user data (see GUIDATA) 
%% 小波变换算法 
imA = handles.
Img1; imB = handles.
Img2; M1 = double(imA) / 256; 
M2 = double(imB) / 256; 
zt = 2; 
wtype = 'haar'; 
[c0, s0] = WaveDecompose(M1, zt, wtype); 
[c1, s1] = WaveDecompose(M2, zt, wtype); 
CoefFusion = FuseProcess(c0, c1, s0, s1); 
Y = WaveReconstruct(CoefFusion, s0, wtype);
handles.result = im2uint8(mat2gray(Y)); 
guidata(hObject, handles); 
msgbox('小波融合处理完毕！', '提示信息', 'modal'); 
% 
if isempty(handles.result) 
    % 
    msgbox('请进行填充处理！', '提示信息', 'modal'); 
    % 
    return; 
    % 
end
axes(handles.axes3); 
imshow(handles.result, []); t
itle('小波变换融合处理结果') 
% --- Executes on button press in pushbutton4. 
function pushbutton4Callback(hObject, eventdata, handles) 
% hObject handle to pushbutton4 (see GCBO) % 
eventdata reserved - to be defined in a future version of MATLAB %
handles structure with handles and user data (see GUIDATA) 
%% 拉普拉斯金字塔算法 
addpath('./拉普拉斯金字塔算法图像融合') 
imA = handles.
Img1; imB = handles.
Img2; % 
im1 = double(imA) / 256; % 
im2= double(imB) / 256; 
im1 = double(imA); 
im2 = double(imB); %% %拉普拉斯滤波器 
w = [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1]/256; 
G = cell(1,5); H = cell(1,5); I = cell(1,5); G{1} = im1;
%第一层为原图像 
H{1} = im2; 
function Y = WaveReconstruct(CoefFusion, s, wtype)

if nargin < 3

end

Y = waverec2(CoefFusion, s, wtype); 
KK = size(c1); 
CoefFusion = zeros(1, KK(2)); 
Coef_Fusion(1:s1(1,1)s1(1,2)) = (c0(1:s1(1,1)s1(1,2))+c1(1:s1(1,1)s1(1,2)))/2; 
MM1 = c0(s1(1,1)s1(1,2)+1:KK(2)); 
MM2 = c1(s1(1,1)s1(1,2)+1:KK(2)); 
mm = (abs(MM1)) > (abs(MM2)); 
Y = (mm.MM1) + ((~mm).*MM2);
