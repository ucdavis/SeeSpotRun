%James McGehee
%Burgess Lab

function conf_guimod
%CONF_GUI Allows the user to check automatic spot detection
%   This function loads the output files of dist3D_gui and generates a
%   projection for each plane XY, XZ, YZ. The user can then check that the
%   number of spots matches the distance data. If there is 1 spot the
%   distance should be zero and if there are two spots the distance should
%   be nonzero. The process can be repeated for every cell in a dataset.
%   When the user detects an error they should enter NaN at that point. If
%   the entire cell is bad the user can click NaN cell, or if a timepoint
%   is bad the user can enter the number of the time point. Both of these
%   options fill their respective parameter with NaN. There are undo and
%   reset buttons if the user makes a mistake. Undo undoes the users last
%   entered value, and there are reset cells and reset tp which return the
%   values to their respective parameters to the values before editing
%   began. Once finished the user should save. If the GUI is quit at any
%   time, progress will be lost if data is not first saved. The user will
%   not be prompted to save when quitting. Saved files include the updated
%   crop and position data .mat file as well as the updated distance data
%   in a .csv file. Older versions of this scipt did not correctly save the
%   distance data in the .mat file. In order to include that data, use this
%   code in the matlab command window after opening the .mat file:
%       [dfile,dpath] = uigetfile('*.csv','Select the distance data file');
%       dist = dlmread([dpath,dfile]);
%       clear('dfile','dpath');
%   After executing the three lines above save the variables using save
%   workspace. Otherwise, if the outputs are from the current dist3D_gui
%   then these steps do not need to be done.
    
    fdata = []; ndata = []; pic = []; maxtp = []; nc = 1; nf = 1; pos = [];
    dispn = 50; r = []; rc = 0; tdata = []; hs = []; odata = [];
    f = figure('Visible','off','Units','normalized','Position',[0,0,1,1]);
    hload = uicontrol('Style','pushbutton','String','Load',...
        'Units','normalized','Position',[.834,.95,.04,.04],...
        'Callback',@loadbutton_Callback);
    hsave = uicontrol('Style','pushbutton','String','Save',...
        'Units','normalized','Position',[.834,.88,.04,.04],...
        'Callback',@savebutton_Callback,'enable','off');
    hfin = uicontrol('Style','text','Fontsize',12,'String',[],...
        'Units','normalized','Position',[.834,.93,.04,.02],...
        'BackgroundColor',[.8,.8,.8]);
    hdirect = uicontrol('Style','text','Fontsize',12,'String',...
        [sprintf('Load Distance data and cropped cell images.\n\nCorr'),...
        sprintf('ect the distance data by editing the column: Fix Dat'),...
        sprintf('a.\nClick NaN cell to NaN a cell or to NaN a time po'),...
        sprintf('int enter the number into NaN tp. Save when done.')],...
        'Units','normalized','Position',[.829,.65,.05,.19],...
        'BackgroundColor',[.8,.8,.8]);
    hundo = uicontrol('Style','pushbutton','String','Undo',...
        'Units','normalized','Position',[.834,.6,.04,.04],...
        'Callback',@undobutton_Callback,'enable','off');
    hnan = uicontrol('Style','pushbutton','String','NaN Cell',...
        'Units','normalized','Position',[.834,.55,.04,.04],...
        'Callback',@nanbutton_Callback,'enable','off');
    hreset = uicontrol('Style','pushbutton','String','Reset Cell',...
        'Units','normalized','Position',[.834,.5,.04,.04],...
        'Callback',@resetbutton_Callback,'enable','off');
    hnantpl = uicontrol('Style','text','Fontsize',15,'String','NaN TP',...
        'Units','normalized','Position',[.834,.47,.04,.02],...
        'BackgroundColor',[.8,.8,.8],'enable','off');
    hnantp = uicontrol('Style','edit','Fontsize',15,...
        'Units','normalized','Position',[.834,.43,.04,.04],...
        'Callback',@nantpedit_Callback,'enable','off');
    hresettpl = uicontrol('Style','text','Fontsize',15,'String',...
        'Reset TP','Units','normalized','Position',[.834,.4,.04,.02],...
        'BackgroundColor',[.8,.8,.8],'enable','off');
    hresettp = uicontrol('Style','edit','Fontsize',15,...
        'Units','normalized','Position',[.834,.36,.04,.04],...
        'Callback',@resettpedit_Callback,'enable','off');
    hposon = uicontrol('Style','togglebutton','String','Pos On',...
        'Units','normalized','Position',[.834,.23,.04,.04],...
        'Callback',@posonbutton_Callback,'enable','off');
    hzoom = uicontrol('Style','togglebutton','String','Zoom On',...
        'Units','normalized','Position',[.834,.18,.04,.04],...
        'Callback',@zoombutton_Callback,'enable','off');
    hnext = uicontrol('Style','pushbutton','String','Next Cell',...
        'Units','normalized','Position',[.9505,.005,.04,.04],...
        'Callback',@nextbutton_Callback,'enable','off');
    hlast = uicontrol('Style','pushbutton','String','Last Cell',...
        'Units','normalized','Position',[.8925,.005,.04,.04],...
        'Callback',@lastbutton_Callback,'enable','off');
    htotcell = uicontrol('Style','text','Fontsize',15,...
        'Units','normalized','Position',[.829,.11,.05,.05],...
        'BackgroundColor',[.8,.8,.8]);
    hcelln = uicontrol('Style','text','Fontsize',15,...
        'Units','normalized','Position',[.834,.055,.04,.05],...
        'BackgroundColor',[.8,.8,.8]);
    hgoto = uicontrol('Style','edit','Fontsize',15,...
        'Units','normalized','Position',[.834,.005,.04,.04],...
        'Callback',@gotoedit_Callback,'enable','off');
    hlabel = uicontrol('Style','text','Fontsize',15,'String',...
        'Go to Cell:','Units','normalized','Position',...
        [.834,.05,.04,.02],'BackgroundColor',[.8,.8,.8]);
    hfwd = uicontrol('Style','pushbutton','String','Forward',...
        'Units','normalized','Position',[.5093333,0.005,.04,.04],...
        'Callback',@fwdbutton_Callback,'enable','off','visible','off');
    hbck = uicontrol('Style','pushbutton','String','Back',...
        'Units','normalized','Position',[.2746666,0.005,.04,.04],...
        'Callback',@bckbutton_Callback,'enable','off','visible','off');
    htable1 = uicontrol('Style','text','String','Distance Data',...
        'Units','normalized','Position',[.8925,.95,.04,.04],...
        'Fontsize',15,'BackgroundColor',[.8,.8,.8]);
    htable2 = uicontrol('Style','text','String','Fix Data',...
        'Units','normalized','Position',[.9505,.95,.04,.04],...
        'Fontsize',15,'BackgroundColor',[.8,.8,.8]);
    uip = uipanel(f,'Position',[0,0.05,0.824,.95]);
    align([hload,hsave,hfin,hnan,hundo,hreset,hnantp,hresettp,...
        hposon,hzoom,hgoto,hdirect,hnantp,hlabel,htotcell,hcelln,...
        hnantpl,hresettpl],'Center','None');
    align([hnext,hlast,hfwd,hbck],'None','Middle');
    align([htable1,htable2],'None','Middle');
    t1 = uitable(f,'Units','normalized','Position',[.884,.05,.057,.9]);
    t2 = uitable(f,'Units','normalized','Position',[.942,.05,.057,.9],...
        'ColumnEditable',true,'CellEditCallback',@disttable_Callback);
    [h,hd] = make_axes(uip,dispn);
    
    function loadbutton_Callback(~,~)
        [ifile,ipath] = uigetfile('*.mat',['Select the saved MATLAB ',...
            'variable file with the distance and image data']);
        
        if ~isequal(ifile,0)
            pic = load([ipath,ifile]);
            
            if isfield(pic, 'dist') && ~isfield(pic, 'ori_data')
                fdata = pic.dist;
                odata = fdata;
            elseif isfield(pic, 'dist') && isfield(pic, 'ori_data')
                fdata = pic.dist;
                odata = pic.ori_data;
            else
                [name,folder] = uigetfile('*.csv',['Select the',...
                    'saved distance file with the distance and',...
                    'image data']);
                fdata = dlmread([folder,name]);
            end
            
            maxtp = size(fdata,1);
            nc = 1;
            nf = 1;
            set(t1,'columnname',sprintf('Cell %i',nc));
            set(t1,'data',odata(:,nc));
            make_plots(pic,h,nf,nc,maxtp,dispn);
            
            for i = 1:maxtp
                if fdata(i,nc) == 0
                    set(hd(i),'String',sprintf('%.0f',fdata(i,nc)),...
                        'foregroundcolor',[0 0 0]);
                else
                    if fdata(i,nc) >= 2
                        colors = [1 0 0];
                    else
                        colors = [0 0 0];
                    end
                    
                    set(hd(i),'String',sprintf('%.4f',fdata(i,nc)),...
                        'foreground',colors);
                end
            end
            
            ndata = fdata;
            set(htotcell,'String',...
                sprintf('Total Number of Cells: %i',size(fdata,2)));
            set(t2,'columnname',sprintf('Cell %i',nc));
            set(t2,'data',ndata(:,nc));
            set(hcelln,'String',sprintf('Current Cell: %i',nc));
            set([hnan,hreset,hnantp,hnantpl,hresettp,hresettpl,...
                hposon,hzoom,hnext,hgoto],'enable','on');
            set(hsave,'enable','on');
            r = zeros(2*maxtp,1);
            tdata = zeros(2*maxtp,1);
            
            if dispn < maxtp
                set([hfwd,hbck],'enable','on');
            end
            
            set(hfin,'Position',[.834,.93,.04,.02],'String','Done');
        end
    end
    
    function savebutton_Callback(~,~)
        [dist,npos] = compare(ndata,pic.pos);
        crops = pic.crops;
        pos = pic.pos;
        ori_data = odata;
        
        if ~isempty(dist) && ~isempty(pos) && ~isempty(npos)...
                && ~isempty(crops) && ~isempty(ori_data)
            [vfile,vpath] = uiputfile('*.mat',...
                'Save MATLAB variables for data');
            
            if ~isequal(vfile,0)
                save([vpath,vfile],'dist','pos','npos','crops','ori_data');
                [~,vname] = fileparts(vfile);
                dlmwrite([vpath,vname,'_dist.csv'],dist);
            end
            
            set(hfin,'Position',[.834,.86,.04,.02],'String','Done');
        end
    end
    
    function undobutton_Callback(~,~)
        if rc > 0
            ndata(r(rc,1),nc) = tdata(rc,1);
            set(t2,'data',ndata(:,nc));
            set(hundo,'enable','on');
            rc = rc - 1;
            
            if rc == 0
                set(hundo,'enable','off');
            end
        end
    end
    
    function nanbutton_Callback(~,~)
        ndata(:,nc) = NaN;
        set(t2,'data',ndata(:,nc));
        r = zeros(2*maxtp,1);
        tdata = zeros(2*maxtp,1);
        rc = 0;
        set(hundo,'enable','off');
    end
    
    function resetbutton_Callback(~,~)
        ndata(:,nc) = fdata(:,nc);
        set(t2,'data',ndata(:,nc));
        r = zeros(2*maxtp,1);
        tdata = zeros(2*maxtp,1);
        rc = 0;
        set(hundo,'enable','off');
    end
    
    function nantpedit_Callback(~,~)
        in = str2double(get(hnantp,'string'));
        ndata(in,:) = NaN;
        set(t2,'data',ndata(:,nc));
        r = zeros(2*maxtp,1);
        tdata = zeros(2*maxtp,1);
        rc = 0;
        set(hundo,'enable','off');
    end
    
    function resettpedit_Callback(~,~)
        in = str2double(get(hresettp,'string'));
        ndata(in,:) = fdata(in,:);
        set(t2,'data',ndata(:,nc));
        r = zeros(2*maxtp,1);
        tdata = zeros(2*maxtp,1);
        rc = 0;
        set(hundo,'enable','off');
    end
    
    function posonbutton_Callback(~,~)
        toggle = (get(hposon,'Value'));
        
        switch toggle
            case get(hposon,'Max')
                p = pic.pos{nc};
                hs = zeros(dispn*nf,3);
                
                for t = ((dispn*nf)-(dispn-1)):(dispn*nf)
                    
                    if t <= maxtp
                        if odata(t,nc) == 0
                            c = [0 0 0];
                        elseif odata(t,nc) > 0
                            c = [.5 .5 .5];
                        else
                            c = [1 1 1];
                        end
                        
                        set(gcf,'CurrentAxes',h(t-dispn*(nf-1),1));
                        hold on;
                        hs(t,1) = plot(p(t == p(:,1),2)-5,...
                            p(t == p(:,1),3)-5,'o','color',c,...
                            'linestyle','none','markersize',10,...
                            'linewidth',2);
                        hold off
                        set(gcf,'CurrentAxes',h(t-dispn*(nf-1),2));
                        hold on;
                        hs(t,2) = plot(p(t == p(:,1),2)-5,...
                            p(t == p(:,1),4)-5,'o','color',c,...
                            'linestyle','none','markersize',10,...
                            'linewidth',2);
                        hold off
                        set(gcf,'CurrentAxes',h(t-dispn*(nf-1),3));
                        hold on;
                        hs(t,3) = plot(p(t == p(:,1),3)-5,...
                            p(t == p(:,1),4)-5,'o','color',c,...
                            'linestyle','none','markersize',10,...
                            'linewidth',2);
                        hold off
                    end
                end
                
                set(hposon,'String','Pos Off');
            case get(hposon,'Min')
                delete(hs);
                set(hposon,'String','Pos On');
        end
    end
    
    function zoombutton_Callback(~,~)
        toggle = (get(hzoom,'Value'));
        
        switch toggle
            case get(hzoom,'Max')
                zoom on
                set(hzoom,'String','Zoom Off');
            case get(hzoom,'Min')
                zoom off
                set(hzoom,'String','Zoom On');
        end
    end
    
    function nextbutton_Callback(~,~)
        if nc < size(fdata,2)
            nc = nc + 1;
            nf = 1;
            set(t1,'columnname',sprintf('Cell %i',nc));
            set(t1,'data',odata(:,nc));
            set(t2,'columnname',sprintf('Cell %i',nc));
            set(t2,'data',ndata(:,nc));
            make_plots(pic,h,nf,nc,maxtp,dispn);
            set(hcelln,'String',sprintf('Current Cell: %i',nc));
            r = zeros(2*maxtp,1);
            tdata = zeros(2*maxtp,1);
            rc = 0;
            set(hundo,'enable','off');
            set(hposon,'value',get(hposon,'Min'));
            set(hposon,'String','Pos On');
            set(hzoom,'value',get(hzoom,'Min'));
            set(hzoom,'String','Zoom On');
            zoom off
            
            for i = 1:maxtp
                if fdata(i,nc) == 0
                    set(hd(i),'String',sprintf('%.0f',fdata(i,nc)),...
                        'foregroundcolor',[0 0 0]);
                else
                    if fdata(i,nc) >= 2
                        colors = [1 0 0];
                    else
                        colors = [0 0 0];
                    end
                    
                    set(hd(i),'String',sprintf('%.4f',fdata(i,nc)),...
                        'foregroundcolor',colors);
                end
            end
            
            if nc >= size(fdata,2)
                set(hnext,'enable','off');
            end
            
            if nc > 1
                set(hlast,'enable','on');
            end
        end
    end
    
    function lastbutton_Callback(~,~)
        if nc > 1
            nc = nc - 1;
            nf = 1;
            set(t1,'columnname',sprintf('Cell %i',nc));
            set(t1,'data',odata(:,nc));
            set(t2,'columnname',sprintf('Cell %i',nc));
            set(t2,'data',ndata(:,nc));
            make_plots(pic,h,nf,nc,maxtp,dispn);
            set(hcelln,'String',sprintf('Current Cell: %i',nc));
            r = zeros(2*maxtp,1);
            tdata = zeros(2*maxtp,1);
            rc = 0;
            set(hundo,'enable','off');
            set(hposon,'value',get(hposon,'Min'));
            set(hposon,'String','Pos On');
            set(hzoom,'value',get(hzoom,'Min'));
            set(hzoom,'String','Zoom On');
            zoom off
            
            for i = 1:maxtp
                if fdata(i,nc) == 0
                    set(hd(i),'String',sprintf('%.0f',fdata(i,nc)),...
                        'foregroundcolor',[0 0 0]);
                else
                    if fdata(i,nc) >= 2
                        colors = [1 0 0];
                    else
                        colors = [0 0 0];
                    end
                    
                    set(hd(i),'String',sprintf('%.4f',fdata(i,nc)),...
                        'foregroundcolor',colors);
                end
            end
            
            if nc <= 1
                set(hlast,'enable','off');
            end
            
            if nc < size(fdata,2)
                set(hnext,'enable','on');
            end
        end
    end
    
    function gotoedit_Callback(~,~)
        in = str2double(get(hgoto,'string'));
        
        if in >= 1 && in <= size(fdata,2)
            nc = in;
            nf = 1;
            set(t1,'columnname',sprintf('Cell %i',nc));
            set(t1,'data',odata(:,nc));
            set(t2,'columnname',sprintf('Cell %i',nc));
            set(t2,'data',ndata(:,nc));
            make_plots(pic,h,nf,nc,maxtp,dispn)
            set(hcelln,'String',sprintf('Current Cell: %i',nc));
            set(hposon,'value',get(hposon,'Min'));
            set(hposon,'String','Pos On');
            set(hzoom,'value',get(hzoom,'Min'));
            set(hzoom,'String','Zoom On');
            zoom off
            
            for i = 1:maxtp
                if fdata(i,nc) == 0
                    set(hd(i),'String',sprintf('%.0f',fdata(i,nc)),...
                        'foregroundcolor',[0 0 0]);
                else
                    if fdata(i,nc) >= 2
                        colors = [1 0 0];
                    else
                        colors = [0 0 0];
                    end
                    
                    set(hd(i),'String',sprintf('%.4f',fdata(i,nc)),...
                        'foregroundcolor',colors);
                end
            end
        end
        
        if nc < size(fdata,2)
            set(hnext,'enable','on');
        else
            set(hnext,'enable','off');
        end
        
        if nc > 1
            set(hlast,'enable','on');
        else
            set(hlast,'enable','off');
        end
    end
    
    function fwdbutton_Callback(~,~)
        if nf < ceil(size(fdata,1)/dispn)
            nf = nf + 1;
            make_plots(pic,h,nf,nc,maxtp,dispn)
        end
    end
    
    function bckbutton_Callback(~,~)
        if nf > 1
            nf = nf - 1;
            make_plots(pic,h,nf,nc,maxtp,dispn)
        end
    end
    
    function disttable_Callback(htd,callbackdata)
        rc = rc + 1;
        
        if rc > maxtp
            rc = 1;
        end
        
        r(rc,1) = callbackdata.Indices(1);
        set(hundo,'enable','on');
        tdata(rc,1) = ndata(r(rc,1),nc);
        ndata(:,nc) = get(htd,'data');
    end
    
    set(f,'Visible','on');
end

function make_plots(pic,h,i,j,maxtp,max_t)
%MAKE_PLOTS Generates the images that are displayed
%   This funtion generates all of the plots displayed, taking the cropped
%   data and convolving, projectiong and then displaying for each time
%   point and all three projection planes. Inputs include the cropped
%   cells in pic, the handle to the axes in h, the number of which figure
%   is displayed in i which is not necessary if all images can be shown in
%   one window, the number of the cell in j, the total number of time
%   points in maxtp, and the total number of time points that can be
%   displayed in max_t.
    
    im = pic.crops{j};
    
    for m = 1:size(h,2)
        for n = 1:size(h,1)
            cla(h(n,m),'reset');
            set(h(n,m),'Visible','off');
            disableDefaultInteractivity(h(n,m)); % R2019a fix
            h(n,m).Toolbar = []; % R2019a fix
        end
    end
    
    for t = ((max_t*i)-(max_t-1)):(max_t*i)
        if t <= maxtp
            img = convolve3d(im(:,:,:,t),gauss3Dpsf(1.46,.528,.133,0.250));
            xymax = max(img,[],3);
            xzmax = squeeze(max(img,[],1))';
            yzmax = squeeze(max(img,[],2))';
            set(gcf,'CurrentAxes',h(t-max_t*(i-1),1));
            imagesc(xymax);
            disableDefaultInteractivity(h(t-max_t*(i-1),1)); % R2019a fix2
            h(t-max_t*(i-1),1).Toolbar = []; % R2019a fix2
            colormap('jet');
            axis('image','xy','off');
            title(['XY Time ' num2str(t)]);
            disableDefaultInteractivity(h(t-max_t*(i-1),1)); % R2019a fix1
            h(t-max_t*(i-1),1).Toolbar = []; % R2019a fix1
            set(gcf,'CurrentAxes',h(t-max_t*(i-1),2));
            imagesc(xzmax);
            disableDefaultInteractivity(h(t-max_t*(i-1),2)); % R2019a fix2
            h(t-max_t*(i-1),2).Toolbar = []; % R2019a fix2
            colormap('jet');
            axis('image','xy','off');
            title(['XZ Time ' num2str(t)]);
            disableDefaultInteractivity(h(t-max_t*(i-1),2)); % R2019a fix1
            h(t-max_t*(i-1),2).Toolbar = []; % R2019a fix1
            set(gcf,'CurrentAxes',h(t-max_t*(i-1),3));
            imagesc(yzmax);
            disableDefaultInteractivity(h(t-max_t*(i-1),3)); % R2019a fix2
            h(t-max_t*(i-1),3).Toolbar = []; % R2019a fix2
            colormap('jet');
            axis('image','xy','off');
            title(['YZ Time ' num2str(t)]);
            disableDefaultInteractivity(h(t-max_t*(i-1),3)); % R2019a fix1
            h(t-max_t*(i-1),3).Toolbar = []; % R2019a fix1
        end
    end
end

function [h,hd] = make_axes(uip,dispn)
%MAKE_AXES Generates blank axes
%   This function Generates blank axes so that the image data may be
%   displayed all at once maximizing space on the GUI. Inputs are the
%   handle to the graphics plane, UIP, and the max number of time points
%   that can be displayed, dispn. Outputs are the handle to the axes, h.
    
    ind = 1;
    h = gobjects(50,3); % R2019a fix
    hd = gobjects(50,1); % R2019a fix
    
    for k = 1:(dispn/5)
        for j = 1:5
            for i = 1:3
                h(ind,i) = axes('Units','normalized','Position',...
                    [.045+(.055*(i-1))+(.19*(j-1)),...
                    .915-(.1*(k-1)),.04,.06],'Parent',uip,...
                    'Visible','off');
                disableDefaultInteractivity(h(ind,i)); % R2019a fix
                h(ind,1).Toolbar = []; % R2019a fix
            end
            
            hd(ind) = uicontrol('Style','text','Fontsize',12,'String',...
                [],'Units','normalized','Position',[.195+(.19*(j-1)),...
                .94-(.1*(k-1)),.03,.02],'BackgroundColor',...
                [.9294,.9294,.9294],'Parent',uip);
            ind = ind + 1;
        end
    end
end

function [ndata,pos] = compare(ndata,pos)
%COMPARE Corrects position data using distance data
%   Uses the distance data to correct the number of spots detected. This is
%   done by changing values to NaN if the position data records a different
%   number of detected spots than the user sees. A distance of zero should
%   have a single spot, and a distance greater than zero should have two
%   spots. Inputs are the position data in pos and distance data in ndata.
%   Outputs are the corrected distance in ndata and the corrected position
%   in pos.
    
    nspots = (ndata > 0) + 1;
    nspots(isnan(ndata)) = NaN;
    
    for j = 1:size(pos,1)
        for i = 1:size(nspots,1)
            if (sum(pos{j,1}(:,1) == i) > 2) || isnan(ndata(i,j)) ...
                    || ~isequal(sum(pos{j,1}(:,1) == i),nspots(i,j))
                pos{j,1}(pos{j,1}(:,1) == i,2:4) = NaN;
            end
        end
    end
end