function varargout = Formulario(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Formulario_OpeningFcn, ...
    'gui_OutputFcn',  @Formulario_OutputFcn, ...
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


% --- Executes just before Formulario is made visible.
function Formulario_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for Formulario
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Formulario_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnFechar.
function btnFechar_Callback(hObject, eventdata, handles)

selection = questdlg(['Fechar ' get(handles.figure1,'Name') '?'],...
    get(handles.figure1,'Name'),...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

function txtIteracao_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtIteracao_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtPopulacao_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtPopulacao_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txtPopulacaoAte_Callback(hObject, eventdata, handles)
% hObject    handle to txtPopulacaoAte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPopulacaoAte as text
%        str2double(get(hObject,'String')) returns contents of txtPopulacaoAte as a double


% --- Executes during object creation, after setting all properties.
function txtPopulacaoAte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPopulacaoAte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtAlfa_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtAlfa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btnProcessar.
function btnProcessar_Callback(hObject, eventdata, handles)
% hObject    handle to btnProcessar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); cla;
desenharGraficos();

axes(handles.axes2); cla;

tic;
set(handles.lblTempo,'String','');

populacao = main_exec(str2double(get(handles.txtPopulacao,'String')), str2double(get(handles.txtPopulacaoAte,'String')), str2double(get(handles.txtIteracao,'String')));

set(handles.lblTempo,'String',num2str(toc));

axes(handles.axes1);

desenharPontosValidos(populacao);

axes(handles.axes2);

desenharFrentePareto(populacao);

function desenharPontosValidos(r)
    epi = 0.005;
    hold on;
    for z = 1:40
        color = 'r';
        if (r(z,4) > epi) || (r(z,5) > epi)
            color = 'k';
        end
        plot(r(z,1),r(z,2),'.','color',color);
        plot(r(z,1),r(z,3),'.','color',color);
    end
    hold off;
    
function desenharGraficos()
    hold on;
    gx = [0.7 1.3];
    g1y = g1(gx);
    g2y = g2(gx);
    plot(gx,g1y,'color','g'); %plotando funcao g1
    text(gx(2),g1y(2),'\leftarrow g1','HorizontalAlignment','left')
    plot(gx,g2(gx),'color','g'); %plotando funcao g2
    text(gx(1),g2y(1),'\leftarrow g2','HorizontalAlignment','left')

    plot([-0.5 3],[0 0],'color','r'); zoom on;
    text(3,0,' x','HorizontalAlignment','left');

    plot([0 0],[-5 50],'color','r');
    text(0,50,' y','HorizontalAlignment','left');

    xi = -0.5:3;
    yi = y1(xi);
    plot(xi,yi,'color','b');
    text(xi(1),yi(1),' \leftarrow y1','HorizontalAlignment','left')

    xi = -0.5:3;
    yi = y2(xi);
    plot(xi,yi,'color','b');
    text(xi(1),yi(1),' \leftarrow y2','HorizontalAlignment','left')
    
function desenharFrentePareto(r)
    hold on;
    epi = 0.005;
    for z = 1:40
        color = 'r';
        if (r(z,4) > epi) || (r(z,5) > epi)
            color = 'k';
        end
        plot(r(z,2),r(z,3),'.','color',color);
    end
        
