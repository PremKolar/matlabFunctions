% TODO move this to +interfaces
classdef FMT_mod_ui_superClass < handle
    properties
        Parent
        uiDir
        folder
        figureName char = ''
        isBuilt = false;
        h % handles
    end
    
    properties
        colorsetFile = '../LHColor.mat'
        colorset
        colorPrimary = 'LH Deep Blue'
        colorFont = 'LH white'
        colorEditable = 'light blue'
        colorRowName = 'gray 15'
        colorTotal = 'gray 40'
        colorFatTabs = 'gray 40'
        colorGrayHighlight = 'gray 50'
        colorHighLight = 'highlight red'
        padding = 2
        spacing = 2
    end
    
    
    properties (Hidden = true)
        listener   = {}
    end
    
    methods
        
        function obj = FMT_mod_ui_superClass(whereuipIs)
            if nargin<1
                obj.uiDir = '../ui';
            else
                obj.uiDir = whereuipIs;
            end
            
            obj.folder = fileparts(mfilename('fullpath'));
            obj.colorset = load(fullfile(obj.folder, obj.colorsetFile));
            
        end
        
        function buildParent(obj)
            if ~isempty(obj.Parent) && ~isvalid(obj.Parent)
                obj.Parent = [];
            end
            if isempty(obj.Parent)
                obj.Parent = figure('Name',obj.figureName,'NumberTitle','off');
                set(obj.Parent,'WindowStyle','docked')
            end
        end
        
        
        function sizeRefresh(obj)
            FN = fieldnames(obj.h);
            for j=1:numel(FN)
                fn = FN{j};
                try
                    S = obj.h.(fn).Sizes;
                    obj.h.(fn).Sizes = 0;
                    obj.h.(fn).Sizes = S;
                end
            end
        end
        
        
        function rgb = color(obj,name)
            ind = strcmpi(obj.colorset.LHcolor(1,:),name);
            if any(ind)
                rgb = obj.colorset.LHcolor{2,ind};
            else
                rgb = [];
            end
        end
        
        function h = gFrame(obj,parent)
            h = ui.GFrame('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing);
        end
        
        function h = Frame(obj,vframe,parent,title,fatType,notFirstLetterUp)
            if nargin<4 || isempty(title)
                title='';
            end
            if nargin<6 || ~notFirstLetterUp
                title = gen.firstLetterUp(title);
            end
            if nargin<2
                vframe  = false;
            end
            if vframe
                frame = @ui.VFrame;
            else
                frame = @ui.HFrame;
            end
            
            if nargin<5 || isempty(fatType) || fatType==0
                h = frame('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing,'Title',title);
            else
                switch fatType
                    case 1
                        h = frame('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing,'Title',title,'BackgroundColor',obj.color(obj.colorPrimary),'ForegroundColor',obj.color(obj.colorFont),'FontWeight','bold');
                    case 2
                        h = frame('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing,'Title',title,'BackgroundColor',obj.color(obj.colorFatTabs),'ForegroundColor',obj.color(obj.colorPrimary),'FontWeight','bold');
                end
            end
            
            if isprop(parent,'ForegroundColor')
                if ~strcmp(parent.Parent.Type,'TabGroup') && strcmp(parent.Type,'Box')
                    parent.ForegroundColor = obj.color(obj.colorFont);                
                end
            end
            
            if strcmp(parent.Type,'TabGroup')
                h.ForegroundColor = [0 0 0];
            end
            
        end
        
        function h = hFrame(obj,varargin)
            h = obj.Frame(0, varargin{:});
        end
        
        function h = vFrame(obj,varargin)
            h = obj.Frame(1, varargin{:});
        end
        
        function h = checkbox(obj,parent,text)
            h  = uicontrol('Parent',parent.double,'Style','checkbox','String',{text});
        end
        
        function F = BPframe(obj,VH,parent,title)
            switch VH
                case 'V'
                    F = ui.VFrame('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing,'Title',title,'BackgroundColor',obj.color(obj.colorPrimary),'ForegroundColor',obj.color(obj.colorFont),'FontWeight','bold');
                case 'H'
                    F = ui.HFrame('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing,'Title',title,'BackgroundColor',obj.color(obj.colorPrimary),'ForegroundColor',obj.color(obj.colorFont),'FontWeight','bold');
            end
        end
        
        function b = box(obj,parent,title,border)
            if nargin<3 || isempty(title)
                title='';
            end
            if nargin<4 || isempty(border)
                border='none';
            end
            
            title = gen.firstLetterUp(title);
            %             b = ui.Box('Parent',parent,'Padding',obj.padding,'BorderType','none','Title',title,'BackgroundColor',obj.color(obj.colorPrimary),'ForegroundColor',obj.color(obj.colorFont),'FontWeight','bold');
            b = ui.Box('Parent',parent,'Padding',obj.padding,'Spacing',obj.spacing,'Title',title,'BackgroundColor',obj.color(obj.colorPrimary),'ForegroundColor',obj.color(obj.colorFont),'FontWeight','bold','BorderType',border);
        end
        
        function B = boxVHframe(obj,title,parent,border)
            title = gen.firstLetterUp(title);
            if nargin<4
                border = 'none';
            end
            B.box   = obj.box(parent,title,border);
            B.hframe = obj.hFrame(B.box,title);
        end
        
        function tg = tabgroup(obj,parent,location)
            tg = ui.TabGroup('Parent',parent,'Location',sprintf('<%s',location),'HighLightColor',obj.color(obj.colorGrayHighlight),'Color',obj.color(obj.colorRowName));
        end
        
        function pb = popupmenu(obj,parent,string)
            if nargin <3
                string = {' - '};
            end
            pb =  uicontrol('Parent',parent.double,'Style','popupmenu','String',string);
        end
        
        function pb = pushbutton(obj,parent,string)
            pb =  uicontrol('Parent',parent.double,'Style','pushbutton','String',string);
        end
        
        function [uic,frame] = uiControlInFrame(obj,parent,title,style,String,callback,fixlength)
            frame = ui.GFrame('Parent',parent,'padding',5,'spacing',1);
            uicontrol('Parent',frame.double,'Style','checkbox','cdata',nan(1,1,3),'String',title,'backgroundcolor',[.8 .8 .8]);
            uic = uicontrol('Parent',frame.double,'Style',style,'String',String);
            if nargin >= 6
                uic.Callback = callback;
            end
            if nargin>=7
                frame.Sizes{2} = [fixlength -1];
            else
                frame.Sizes{2} = [length(title)*10 -1];
            end
        end
        
        function [M,hBox] = MTableInBox(obj,parent,title,a,b,c,d,e)
            hBox =  obj.box(parent,title);
            if exist('e','var')
                M = MTable(hBox,a,b,c,d,e);
            else
                M = MTable(hBox,a,b,c,d);
            end
            hBox.Sizes = -1;
        end
        
        
        % check for info field in drop down like eg "-choose!-"
        function yes = isInfoString(obj,hObj) %#ok<*INUSL>
            s = strip(hObj.String{hObj.Value});
            yes = strcmp(s([1 end]),'--');
        end
        
        function killTab(obj,tab)
            while numel(tab.Children)>0
                try  %#ok<*TRYNC>
                    delete(tab.Children(1));
                catch
                    delete(tab.Children{1});
                end
            end
        end
        
    end
end

