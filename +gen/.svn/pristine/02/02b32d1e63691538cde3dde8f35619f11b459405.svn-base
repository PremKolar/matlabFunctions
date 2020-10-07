% barObj(years,D_real,{'costs','overhead','yield'},combos,contracts)
classdef barObj < fmtOOP.interfaces.UItools
    
    properties
        M % M(i,t,j,k) all data
        legend_t % 'time'
        legend_i % the different blocks
        legend_j % the drop down menu
        legend_k % the different bars
        fontsize = 8
        Mb = []
        M_tags
        bartags
        typesText
    end
    
    % Caps for dimensions
    properties (Dependent)
        T
        I
        J
        K
        M_j % selected values via pull down
        M_tags_j
        Mb_j
        barwidth
    end
    
    properties (Hidden)
        value_j
        bars
    end
    
    events
        
    end
    
    methods
        function obj = barObj(M, leg_t, leg_i, leg_j, leg_k, parent, Mtags)
            
            if nargin>5 && ~isempty(parent)
                obj.Parent = parent;
            else % run in new figure
                obj.Parent = figure('Name','bar tool','NumberTitle','off');
                set(obj.Parent,'WindowStyle','docked');
            end
            
            if ~isempty(M)
                obj.M = M;
                obj.legend_t = leg_t;
                obj.legend_i = leg_i;
                obj.legend_j = leg_j;
                obj.legend_k = leg_k;
                obj.value_j = leg_j{1}; % init
                obj.buildUp;
            end
            
            if nargin>6
                validateattributes(Mtags,{'cell'},{'size',size(M)})
                obj.M_tags = Mtags;
            end
            
        end
        % -----------------------------------------------------------------
        function buildUp(obj)
            
            try %#ok<TRYNC>
                delete(obj.Parent.Children{1});
            end
            obj.h.hf1  = obj.hFrame(obj.Parent);
            obj.h.vf1  = obj.vFrame(obj.h.hf1);
            obj.h.hf1.ForeGroundColor = [1 1 1];
            obj.h.hf2  = obj.hFrame(obj.h.vf1); % for drop downs
            obj.h.popup =uicontrol('Parent',obj.h.hf2.double,'Style','popupmenu','String',obj.legend_j,'Callback',{@(h,e) obj.Callback(h,e,'valueNameSelect')});
            obj.h.axis = axes('Parent',uipanel('Parent',obj.h.vf1.double,'BorderType','none'),'FontSize',obj.fontsize);
            obj.h.vf1.Sizes = [30 -1];
        end
        % -----------------------------------------------------------------
        function out = get.barwidth(obj)
            out = .8 / obj.K;
        end
        % -----------------------------------------------------------------
        function T = get.T(obj)
            T = size(obj.M,2);
        end
        % -----------------------------------------------------------------
        function I = get.I(obj)
            I = size(obj.M,1);
        end
        % -----------------------------------------------------------------
        function J = get.J(obj)
            J = size(obj.M,3);
        end
        % -----------------------------------------------------------------
        function K = get.K(obj)
            K = size(obj.M,4);
        end
        % -----------------------------------------------------------------
        function out = get.M_j(obj)
            j = strcmp(obj.value_j,obj.legend_j);
            out = squeeze(obj.M(:,:,j,:));
        end
        % -----------------------------------------------------------------
        function out = get.M_tags_j(obj)
            j = strcmp(obj.value_j,obj.legend_j);
            out = squeeze(obj.M_tags(:,:,j,:));
        end
        % -----------------------------------------------------------------
        function out = get.Mb_j(obj)
            j = strcmp(obj.value_j,obj.legend_j);
            out = squeeze(obj.Mb(:,:,j,:));
        end
        % -----------------------------------------------------------------
        function ok = checkForSelections(obj)
            ok = true;
            if isempty(obj.M_j)
                fprintf('choose what to show!\n')
                ok = false;
            end
        end
        % -----------------------------------------------------------------
        function plot(obj)
            
            %%
            obj.h.popup.String = obj.legend_j;
            
            %%
            if ~obj.checkForSelections || obj.T==1
                cla(obj.h.axis);
                return
            end
            
            %%
            cla(obj.h.axis); hold(obj.h.axis,'on');
            try %#ok<TRYNC>
                delete(obj.h.axis2)
            end
            
            obj.bars = [];
            obj.bartags = cell(obj.T,obj.K*obj.I);
            for k = 1:obj.K % types
                x = (1:obj.T)+(k)*obj.barwidth; % years..
                y =  obj.M_j(:,:,k)'; % all years x all chunks
                obj.bars = [obj.bars bar(obj.h.axis,x,y,obj.barwidth,'stacked')];
                if ~isempty(obj.M_tags)
                    obj.bartags(:,obj.I*(k-1)+1:obj.I*k) = obj.M_tags_j(:,:,k)';
                end
            end
            
            caxis(obj.h.axis,[1 numel(obj.legend_i)]);
            
            set(obj.h.axis,'XTick',1:obj.T);
            set(obj.h.axis,'XTickLabel',obj.legend_t);
           
            
            % TODO mouse over
            warning('off')
            if numel(obj.legend_i)<=50
                fprintf('building legend...\n')
                legend(obj.h.axis,obj.legend_i,'Location','northeastoutside','AutoUpdate','off');
            else
                fprintf(2,'more than 50 values. legend would be too large!\n')
            end
            warning('on')
            
            
            grid on
            if ~isempty(obj.Mb)
                obj.plotB;
            end
            
            
            maxy = obj.h.axis.YLim(2);
            txt = strip(sprintf('%s   |   ',obj.legend_k{:}));
            x = obj.h.axis.XLim(1) + 0.1 * diff(obj.h.axis.XLim);
            obj.typesText = text(obj.h.axis,x,1.03*maxy,txt(1:end-2),'FontSize',obj.fontsize,'interpreter','none');
            grid(obj.h.axis,'on')
            axis(obj.h.axis,'tight')
           obj.h.axis2 = gen.ticklabelbetweenticks(obj.h.axis);
           obj.h.axis2.FontSize = obj.fontsize;
            
        end
        % -----------------------------------------------------------------
        function plotB(obj)
            for k = 1:obj.K
                for t = 1:obj.T
                    data = [0; cumsum(obj.Mb_j(:,t,k))];
                    plot(obj.h.axis,t+(k)*obj.barwidth, data(2:end),'+','color','red')
                    plot(obj.h.axis,repmat(t+(k)*obj.barwidth,3,1), data,'-','color','red')
                end
            end
        end
        % -----------------------------------------------------------------
        function setValue_j(obj,value)
            obj.value_j = value;
            obj.plot;
            gen.setpopuptovalue(obj.h.popup,value);
        end
    end
    
    
    methods (Access = private)
        function ok = checkinputs(obj)
            ok =true;
            if numel(obj.legend_t)~=obj.T
                ok = false;
            end
            if numel(obj.legend_i)~=obj.I
                ok = false;
            end
            if numel(obj.legend_j)~=obj.J
                ok = false;
            end
            if numel(obj.legend_k)~=obj.K
                ok = false;
            end
        end
        
        % -----------------------------------------------------------------
        function Callback(obj,hObj,~,action)
            switch action
                case 'valueNameSelect'
                    selection = hObj.String{hObj.Value};
                    obj.value_j = selection;
            end
            %             try
            obj.plot;
            
            %             catch me
            %                 fprintf(2,'\n%s\n\n...plotting problems\n',me.message);
            %             end
        end
        % -----------------------------------------------------------------
    end
end


