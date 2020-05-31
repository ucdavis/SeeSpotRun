%James McGehee
%Burgess Lab

function dist3D_gui
%DIST3D_GUI Allows the user to crop cells and measure distance between foci
%   This function loads the image files and uses generates a z and t
%   projection. The user is then prompted to adjust the brightness to
%   visualize the cells and crop both a background selection and each cell.
%   This GUI provides the user with undo and reset options. Once cropping
%   is finished the user clicks done, is prompted to save and can then quit
%   or calculate the distances. If the user quits the load cells option
%   allows the user to restart at this point. Once finished the user can
%   save the data. Closing the GUI at any time loses all progress and does
%   not prompt the user to save. Saved files include the distance as a .csv
%   file and the .mat file containing the cropped images and position data.
%   Also saves the numbered field of view of the crops.
    
    img = []; bgimg = []; ncell = []; ncell_est = 5000; crops = [];
    pos = []; n = []; distCell = []; h = []; mmax = []; mmin = [];
    scale = 1; proj = []; ht = []; t_start = []; t_end = [];
    f = figure('Visible','off','Units','normalized','Position',...
        [0,0,1,1]);
    hts = uicontrol('Style','text','String','Starting t',...
        'Units','normalized','Position',[.75,.96,.04,.02],'Fontsize',15,...
        'BackgroundColor',[.8,.8,.8]);
    hte = uicontrol('Style','text','String','Ending t',...
        'Units','normalized','Position',[.75,.91,.04,.02],'Fontsize',15,...
        'BackgroundColor',[.8,.8,.8]);
    htsin = uicontrol('Style','edit','Fontsize',15,...
        'Units','normalized','Position',[.79,.95,.04,.04],...
        'Callback',@tsinedit_Callback,'Backgroundcolor',[1,1,1]);
    htein = uicontrol('Style','edit','Fontsize',15,'enable','off',...
        'Units','normalized','Position',[.79,.9,.04,.04],...
        'Callback',@teinedit_Callback,'Backgroundcolor',[1,1,1]);
    hload = uicontrol('Style','pushbutton','String','Load',...
        'Units','normalized','Position',[.77,.85,.04,.04],...
        'Callback',@loadbutton_Callback,'enable','off');
    hplus = uicontrol('Style','pushbutton','String','+',...
        'Units','normalized','Position',[.89,.77,.02,.02],...
        'Callback',@plusbutton_Callback,'enable','off');
    hminus = uicontrol('Style','pushbutton','String','-',...
        'Units','normalized','Position',[.89,.75,.02,.02],...
        'Callback',@minusbutton_Callback,'enable','off');
    hbright = uicontrol('Style','pushbutton','String','Done Adjusting',...
        'Units','normalized','Position',[.77,.75,.04,.04],...
        'Callback',@brightbutton_Callback,'enable','off');
    hcrop = uicontrol('Style','pushbutton','String','Crop Background',...
        'Units','normalized','Position',[.77,.7,.04,.04],...
        'Callback',@cropbutton_Callback,'enable','off');
    htool = uicontrol('Style','pushbutton','String','Crop Cell',...
        'Units','normalized','Position',[.77,.65,.04,.04],...
        'enable','off','Callback',@toolbutton_Callback);
    hundo = uicontrol('Style','pushbutton','String','Undo Crop',...
        'Units','normalized','Position',[.77,.6,.04,.04],...
        'enable','off','Callback',@undobutton_Callback);
    hdone = uicontrol('Style','pushbutton','String','Done Cropping',...
        'Units','normalized','Position',[.77,.55,.04,.04],...
        'enable','off','Callback',@donebutton_Callback);
    hreset = uicontrol('Style','pushbutton','String','Reset Cropping',...
        'Units','normalized','Position',[.77,.5,.04,.04],...
        'enable','off','Callback',@resetbutton_Callback);
    hsavef = uicontrol('Style','pushbutton','String','Save Figure',...
        'Units','normalized','Position',[.77,.45,.04,.04],...
        'Callback',@savefigbutton_Callback,'enable','off');
    hloadc = uicontrol('Style','pushbutton','String','Load Cells',...
        'Units','normalized','Position',[.77,.25,.04,.04],...
        'Callback',@loadcellbutton_Callback);
    hdist = uicontrol('Style','pushbutton','String','Calculate Dist',...
        'Units','normalized','Position',[.77,.2,.04,.04],...
        'Callback',@calcdistbutton_Callback,'enable','off');
    hsave = uicontrol('Style','pushbutton','String','Save',...
        'Units','normalized','Position',[.77,.15,.04,.04],...
        'Callback',@savebutton_Callback,'enable','off');
    hprog = uicontrol('Style','text','String','Load microscope images',...
        'Units','normalized','Position',[.815,.84,.06,.04],'Fontsize',...
        15,'BackgroundColor',[.8,.8,.8],'HorizontalAlignment','left',...
        'visible','off');
    hdirect = uicontrol('Style','text','Fontsize',15,...
        'Units','normalized','Position',[.915,.74,.08,.06],...
        'BackgroundColor',[.8,.8,.8],'HorizontalAlignment','left');
    hcurrent = uicontrol('Style','text','Fontsize',15,...
        'Units','normalized','Position',[.815,.21,.06,.02],...
        'BackgroundColor',[.8,.8,.8],'HorizontalAlignment','left');
    align([hload,hbright,hcrop,htool,hdone,hundo,hreset,hsavef,...
        hloadc,hdist,hsave],'Center','none');
    align([hts,hte],'Center','none');
    align([htsin,htein],'Center','none');
    uip = uipanel(f,'Position',[0,0.05,0.75,.95]);
    
    function tsinedit_Callback(~,~)
        t_start = str2double(get(htsin,'string'));
        
        if t_start > 0
            set(htein,'enable','on');
            set([hload,hbright,hcrop,htool,hdone,hundo,hreset,...
                hsavef,hloadc,hdist,hsave,hplus,hminus],'enable',...
                'off');
            set(hdirect,'Position',[.915,.74,.08,.06],'String',[]);
            set(hprog,'Position',[.815,.84,.06,.04],'String',[]);
            set(hcurrent,'Position',[.815,.21,.06,.02],'String',[]);
        else
            set(htsin,'string',[]);
            set(htein,'enable','off');
        end
    end
    
    function teinedit_Callback(~,~)
        t_end = str2double(get(htein,'string'));
        
        if t_end > t_start
            set(hload,'enable','on');
            set(hprog,'visible','on');
        else
            set(htein,'string',[]);
            set(hload,'enable','off');
        end
    end
    
    function loadbutton_Callback(~,~)
        set([htsin,htein],'enable','off');
        drawnow;
        
        [name,folder] = uigetfile({'*.tiff','TIFF files (*.tiff)';...
            '*.tif','TIF files (*.tif)'},'Select the microscope images',...
            'MultiSelect','on');
        
        if iscell(name)
            set(hprog,'Position',[.815,.84,.06,.04],'String','Loading...');
            drawnow;
            imginf = imfinfo([folder,name{1}]);
            [sT,eT] = regexp(name{end},'_T\d*\.');
            [sZ,eZ] = regexp(name{end},'_Z\d*\_');
            t = str2double(name{end}(sT+2:eT-1))+1;
            z = str2double(name{end}(sZ+2:eZ-1))+1;
            img = zeros(imginf.Height,imginf.Width,z,t_end-t_start+1,...
                'uint16');
            
            for i = 1:z
                ind = 1;
                for j = t_start:t_end
                    img(:,:,i,ind) = imread([folder,name{t*(i-1)+j}]);
                    ind = ind + 1;
                end
                
                set(hprog,'Position',[.815,.84,.1,.04],'String',...
                    sprintf('Percent Complete: %3.0f%%',i/z*100));
                drawnow;
            end
            
            set(htsin,'enable','on');
            set([hreset,hloadc],'enable','off');
            scale = 1;
            
            proj = max(max(img,[],4),[],3);
            h = axes('Parent',uip,'Visible','off');
            imagesc(proj);
            colormap('gray');
            axis('image');
            set([hplus,hminus,hbright],'enable','on');
            set(hload,'enable','off');
            set(hdirect,'Position',[.915,.74,.08,.06],'String',...
                ['Increase or Decrease Brightness. Click Done Adjustin',...
                'g when finished.']);
            mmax = max(proj(:));
            mmin = min(proj(:));
        end
    end
    
    function minusbutton_Callback(~,~)
        if scale < 1
            scale = scale + 0.1;
            
            if mmin < (mmax*scale)
                imagesc(proj,[mmin,mmax*scale]);
                axis('image');
            else
                set(hminus,'enable','off');
            end
        else
            set(hminus,'enable','off');
        end
        
        if scale > 0
            set(hplus,'enable','on');
        end
    end
    
    function plusbutton_Callback(~,~)
        if scale > 0
            scale = scale - 0.1;
            
            if mmin < (mmax*scale)
                imagesc(proj,[mmin,mmax*scale]);
                axis('image');
            else
                set(hplus,'enable','off');
            end
        else
            set(hplus,'enable','off');
        end
        
        if scale < 1
            set(hminus,'enable','on');
        end
    end
    
    function brightbutton_Callback(~,~)
        set([hbright,hplus,hminus],'enable','off');
        set(hcrop,'enable','on');
        set(hdirect,'Position',[.815,.69,.18,.055],'String',...
            ['Click Crop background and draw an elipse on the image.',...
            ' Double Click inside the ellipse to procced.',...
            ' Background should not include any signal.']);
        set(hprog,'String',[]);
    end
    
    function cropbutton_Callback(~,~)
        set(hcrop,'enable','off');
        ncell = 0;
        n = strtrim(cellstr(num2str((0:ncell_est)')));
        bgimg = crop4Dvolgui(img,n(1,1));
        crops = cell(ncell_est,1);
        ht = zeros(ncell_est,1);
        set([htool,hreset],'enable','on');
        set(hdirect,'Position',[.815,.63,.18,.065],'String',...
            ['Click Crop Cell or hit space and draw an elipse around ',...
            'a cell. Double Click inside the ellipse to procced.',...
            ' Repeat for all desired cells. Click Undo to undo last',...
            'crop. Click Done when finished or Reset to start over.']);
        set(f,'KeyPressFcn',@keycrop);
    end
    
    function toolbutton_Callback(~,~)
        set([hcrop,htool,hdone,hreset,hundo],'enable','off');
        drawnow;
        ncell = ncell + 1;
        [crops{ncell},ht(ncell)] = crop4Dvolgui(img,n(ncell+1));
        set([htool,hdone,hreset,hundo],'enable','on');
        set(f,'KeyPressFcn',@keycrop);
    end
    
    function keycrop(~,e)
        set(f,'KeyPressFcn',[]);
        
        switch e.Key
            case 'space'
                toolbutton_Callback;
        end
    end
    
    function undobutton_Callback(~,~)
        if ncell > 0
            delete(ht(ncell));
            crops{ncell} = [];
            ncell = ncell - 1;
            
            if ncell == 0
                set(hundo,'enable','off');
            else
                set(hundo,'enable','on');
            end
        end
    end
    
    function donebutton_Callback(~,~)
        set([hcrop,htool,hundo,hdone],'enable','off');
        set([hsavef,hsave],'enable','on');
        crops(cellfun('isempty',crops)) = [];
        set(hdirect,'Position',[.815,.455,.1,.035],'String',...
            'Save figure with numbered cells to proceed');
        set(f,'KeyPressFcn',[]);
    end
    
    function resetbutton_Callback(~,~)
        set(hdirect,'String',[]);
        set([hcrop,htool,hundo,hdone,hreset,hsavef,hdist,hsave,...
            htsin],'enable','off');
        set(hcurrent,'String',[]);
        delete(findobj(gcf,'type','axes'));
        scale = 1;
        proj = max(max(img,[],4),[],3);
        h = axes('Parent',uip,'Visible','off');
        imagesc(proj);
        colormap('gray');
        axis('image');
        set([hplus,hminus,hbright],'enable','on');
        set(hload,'enable','off');
        set(hdirect,'Position',[.915,.74,.08,.06],'String',...
            ['Increase or Decrease Brightness. Click Done Adjusting',...
            ' when finished.']);
        mmax = max(proj(:));
        mmin = min(proj(:));
        set(f,'KeyPressFcn',[]);
    end
    
    function savefigbutton_Callback(~,~)
        set(hdirect,'String',[]);
        f2 = figure('Visible','off','Units','normalized',...
            'Position',[0,0,.6,.85]);
        colormap('gray');
        copyobj(h,f2);
        [ffile,fpath] = uiputfile('*.png',...
            'Save numbered field of view');
        
        if ~isequal(ffile,0)
            hgexport(f2,[fpath,ffile],hgexport('factorystyle'),...
                'Format','png');
        end
        
        close(f2);
        set(hdist,'enable','on');
        set(hcurrent,'Position',[.815,.17,.08,.07],'String',...
            'Click Calculate Dist to measure the distance between foci');
    end
    
    function loadcellbutton_Callback(~,~)
        [ifile,ipath] = uigetfile('*.mat',...
            'Select the saved MATLAB variable file for the image data');
        
        if ~isequal(ifile,0)
            pic = load([ipath,ifile]);
            crops = pic.crops;
            bgimg = pic.bgimg;
            ncell = size(crops,1);
            set(hload,'enable','off');
            set(hdist,'enable','on');
            set(hcurrent,'Position',[.815,.17,.08,.07],'String',...
            'Click Calculate Dist to measure the distance between foci');
        end
    end
    
    function calcdistbutton_Callback(~,~)
        set([hreset,hsavef,hdist,hload,htsin],'enable','off');
        set(hcurrent,'Position',[.815,.21,.12,.02],'String',[]);
        set(hdirect,'String',[]);
        distCell = cell(ncell,1);
        pos = cell(ncell,1);
        drawnow;
        
        for i = 1:ncell
            set(hcurrent,'String',...
                sprintf('Current Cell %i %3.0f%% Complete',i,...
                (i-1)/ncell*100));
            drawnow;
            [temp_pos,~,distCell{i}] = ...
                runSpotAnalysistest(crops{i},bgimg,'auto');
            pos{i,1} = coord2mat(temp_pos);
        end
        
        set(hcurrent,'Position',[.815,.21,.06,.02],'String',[]);
        set(hcurrent,'String','100% Complete');
        delete(findobj(gcf,'type','axes'));
        set([hsave,hreset,htsin],'enable','on');
        set(hdirect,'Position',[.815,.15,.1,.04],...
            'String','Save cropped cells, distance, and postion data');
    end
    
    function savebutton_Callback(~,~)
        set(hcurrent,'String',[]);
        
        if isempty(distCell)
            set(hdirect,'Position',[.815,.16,.1,.02],...
                'String','Saving... Do not quit');
            [vfile,vpath] = uiputfile('*.mat',...
                'Save MATLAB variables for data');
            
            if ~isequal(vfile,0) && ~isempty(crops) && ~isempty(bgimg)
                save([vpath,vfile],'crops','bgimg');
            end
            
            set(hdirect,'Position',[.815,.16,.1,.02],...
                'String','Done');
        else
            set(hdirect,'Position',[.815,.16,.1,.02],...
                'String','Saving... Do not quit');
            dist = cat(2,distCell{:});
            [vfile,vpath] = uiputfile('*.mat',['Save MATLAB variables ',...
                'for data']);
            
            if ~isequal(vfile,0) && ~isempty(crops) && ~isempty(pos)
                save([vpath,vfile],'crops','pos','bgimg','dist');
                [~,vname] = fileparts(vfile);
                dlmwrite([vpath,vname,'_dist.csv'],dist);
            end
            
            set(hdirect,'Position',[.815,.16,.02,.02],...
                'String','Done');
        end
    end
    
    set(f,'Visible','on');
end

function [extracted,ht] = crop4Dvolgui(img,n)
%CROP4DVOLGUI Handles the actual cropping, including generating the tool
%and extracting the data. Inputs are the image data, and the numbering to
%graphically display how many cells are cropped. Outputs are the handles to
%the number texts in ht, and the cropped image in extracted.
    h = imellipse;
    wait(h);
    binaryimage = h.createMask();
    pos = getPosition(h);
    drawnow;
    ht = text(pos(1,1)+pos(1,3)/2-5,pos(1,2)+pos(1,4)/2,n,'color','r',...
        'fontsize',30);
    delete(h);
    col1 = find(sum(binaryimage,1),1,'first');
    col2 = find(sum(binaryimage,1),1,'last');
    row1 = find(sum(binaryimage,2),1,'first');
    row2 = find(sum(binaryimage,2),1,'last');
    extracted = img(row1:row2,col1:col2,:,:);
    mask = repmat(binaryimage(row1:row2,col1:col2),...
        [1,1,size(img,3),size(img,4)]);
    extracted(~mask) = min(extracted(:));
end