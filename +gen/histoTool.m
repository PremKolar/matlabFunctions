% TODONK comment
% - feed with two (one for timepoints/one for values) cell arrays of tables (number of tables per array == number of sets)
% - timepoints data must be as strings in format obj.datefrmt
classdef histoTool < fmtOOP.interfaces.UItools
    
    properties
        setNames % you can set these
        selectedTimepoints % chosen via gui pulldowns
        selectedValues % chosen via gui pulldowns
        currentSet % number that defines which set is displayed on eg "obj.values"
        binStyle = 'yearly' % 'monthly', 10 (non-date) % TODONK
        datefrmt = 'dd.mm.yyyy'
        alpha = 1
        fontsize = 8
        maxBlocks = 30 % maximum number of unique blocks to plot
    end
    
    properties (Dependent)
        timeNames % taken from input table
        valueNames % taken from input table
        timepoints % when
        values % what
        selectedTimeName % chosen via gui pulldowns
        selectedValueName % chosen via gui pulldowns
    end
    
    properties (Hidden)
        timepoints_
        values_
        Nt % num of time types
        Nv % num of value types
        Nsets % num of data sets
        Npoints % num of data points in one set in one time/value type (can vary between sets)
        bins
    end
    
    events
        timeSelection
        valueSelection
    end
    
    methods
        function obj = histoTool(timepoints, values, parent)
            
            obj.timepoints_ = timepoints;
            obj.values_     = values;
            
            if ~obj.checkinputs
                error('check inputs')
            end
            
            if nargin>2 && ~isempty(parent)
                obj.Parent = parent;
            else % run in new figure
                obj.Parent = figure('Name','histogram tool','NumberTitle','off');
                set(obj.Parent,'WindowStyle','docked');
            end
            obj.currentSet = 1;
            obj.buildUp;
        end
        % -----------------------------------------------------------------
        function buildUp(obj)
            %             obj.h.TB   = obj.tabgroup(obj.Parent,'left');
            obj.h.hf1  = obj.hFrame(obj.Parent);
            obj.h.vf1  = obj.vFrame(obj.h.hf1);
            obj.h.hf2  = obj.hFrame(obj.h.vf1); % for drop downs
            uicontrol('Parent',obj.h.hf2.double,'Style','popupmenu','String',obj.timeNames,'Callback',{@(h,e) obj.Callback(h,e,'timeNameSelect')});
            uicontrol('Parent',obj.h.hf2.double,'Style','popupmenu','String',obj.valueNames,'Callback',{@(h,e) obj.Callback(h,e,'valueNameSelect')});
            obj.h.axis = axes('Parent',uipanel('Parent',obj.h.vf1.double,'BorderType','none'),'FontSize',obj.fontsize);
            obj.h.vf1.Sizes = [30 -1];
        end
        % -----------------------------------------------------------------
        function set.selectedTimeName(obj,value)
            obj.selectedTimepoints = obj.setSelectedNameGeneric(value,'timepoints_');
            for j=1:obj.Nsets % empty cells 2 0-date
                obj.selectedTimepoints{j}(cellfun(@(x) numel(x)==0,obj.selectedTimepoints{j}))={datestr(0,obj.datefrmt)};
            end
            notify(obj,'timeSelection');
        end
        % -----------------------------------------------------------------
        function set.selectedValueName(obj,value)
            obj.selectedValues = obj.setSelectedNameGeneric(value,'values_');
            notify(obj,'valueSelection');
        end
        % -----------------------------------------------------------------
        function out = setSelectedNameGeneric(obj,value,type)
            out = cell(1,obj.Nsets);
            for j = 1:obj.Nsets
                data = obj.(type){j}.(value);
                if ischar(data)
                    data = cellstr(data);
                end
                if ~iscell(data)
                    data = num2cell(data);
                end
                for k=1:numel(data)
                    if isempty(data{k})
                        data(k) = {''};
                    end
                    if isnumeric(data{k})
                        data{k} = num2str(data{k});
                    end
                    if islogical(data{k})
                        yn={'no','yes'};
                        data(k) = yn(data{k}+1);
                    end
                end
                out{j} = data;
            end
        end
        % -----------------------------------------------------------------
        function out = get.timepoints(obj)
            out = obj.timepoints_{obj.currentSet}; % load one set only
            %             obj.setInfo
        end
        % -----------------------------------------------------------------
        function out = get.values(obj)
            out = obj.values_{obj.currentSet}; % load one set only
            %             obj.setInfo
        end
        % -----------------------------------------------------------------
        function out = get.timeNames(obj)
            out = obj.timepoints.Properties.VariableNames;
        end
        % -----------------------------------------------------------------
        function set.timeNames(obj,values)
            obj.timepoints.Properties.VariableNames = values;
        end
        % -----------------------------------------------------------------
        function out = get.valueNames(obj)
            out = obj.values.Properties.VariableNames;
        end
        % -----------------------------------------------------------------
        function set.valueNames(obj,values)
            obj.values.Properties.VariableNames = values;
        end
        % -----------------------------------------------------------------
        function ok = checkForSelections(obj)
            ok = true;
            if isempty(obj.selectedValues)
                fprintf('choose what to show!\n')
                ok = false;
            end
            if isempty(obj.selectedTimepoints)
                fprintf('choose time data!\n')
                ok = false;
            end
        end
        % -----------------------------------------------------------------
        function calcbins(obj)
            switch obj.binStyle
                case 'yearly'
                    dates = cellfun(@(x)datenum(x,obj.datefrmt),obj.selectedTimepoints,'UniformOutput',false);
                    obj.bins = cellfun(@gen.year,dates,'UniformOutput',false);
                    
            end
        end
        % -----------------------------------------------------------------
        function histo(obj)
            if ~obj.checkForSelections
                return
            end
            cla(obj.h.axis); hold(obj.h.axis,'on');
            
            setDims = cellfun(@numel,obj.selectedValues); % sizes of sets
            allData = cat(1,obj.selectedValues{:});       % all sets in one
            
            obj.calcbins; % calc the bins
            [uniquebins,~,~] = unique(cat(1,obj.bins{:}));
            [uniqueblocks,~,whichBlock] = unique(allData); % all blocks eg WS1, WS2 etc.. (the different colors)
            
            if numel(uniqueblocks) > obj.maxBlocks
                fprintf('\nwould have to differentiate\nbetween %d different kinds of events.\naborting...\n',numel(uniqueblocks));
                return
            end
            whichBlock = mat2cell(whichBlock',1,setDims); % resort back to set dims
            
            blockLengths = zeros(numel(uniquebins),numel(uniqueblocks)); % init
            
            alph = 1; % for first
            width = .8 / obj.Nsets;
            for s=1:obj.Nsets
                for j = 1:numel(uniquebins)
                    isthisbin = obj.bins{s}==uniquebins(j); % where this bin in this set
                    blocks = whichBlock{s}(isthisbin);      % which blocks
                    blockLengths(j, :) = histcounts(blocks,.5:numel(uniqueblocks)+.5); % stack blocks
                end
                if s>1
                    alph = obj.alpha;
                end
                bar(obj.h.axis,(1:numel(uniquebins))+(s-1)*width,blockLengths,width,'stacked','FaceAlpha',alph);
            end
            
            set(obj.h.axis,'XTick',1:numel(uniquebins));
            set(obj.h.axis,'XTickLabel',uniquebins);
            try
                legend(obj.h.axis,uniqueblocks,'Location','northeastoutside','AutoUpdate','off')
            catch
                legend(obj.h.axis,num2str(uniqueblocks),'Location','northeastoutside','AutoUpdate','off')
            end
            maxy = max(get(obj.h.axis,'YTick'));
            txt = strip(sprintf('%s   |   ',obj.setNames{:}));
            text(1,1.03*maxy,txt(1:end-2),'FontSize',obj.fontsize,'interpreter','none');
        end
        % -----------------------------------------------------------------
    end
    
    methods (Access = private)
        function ok = checkinputs(obj)
            ok = obj.checktimepoints && obj.checkevents;
            if numel(obj.values_) ~= numel(obj.timepoints_)
                ok = false; % number of sets must be equal
                return
            end
            obj.Nsets = numel(obj.values_);
            
            obj.setNames = cellfun(@(x) sprintf('set_%d',x),num2cell(1:obj.Nsets),'UniformOutput',false);
            
            obj.Npoints = cellfun(@(x) size(x,1),obj.values_);
        end
        % -----------------------------------------------------------------
        function ok = checktimepoints(obj)
            [ok, obj.timepoints_] = obj.checkdata(obj.timepoints_);
            obj.Nt = numel(obj.timepoints_);
        end
        % -----------------------------------------------------------------
        function ok = checkevents(obj)
            [ok, obj.values_] = obj.checkdata(obj.values_);
            obj.Nv = numel(obj.values_);
        end
        % -----------------------------------------------------------------
        function [ok, data] = checkdata(~,data)
            ok = true;
            if istable(data)
                data = {data}; % put in cell for consistency
            elseif iscell(data)
                for j = 1:numel(data)
                    if ~istable(data{j})
                        ok = false;
                        return
                    end
                end
            else
                ok = false;
            end
        end
        % -----------------------------------------------------------------
        function Callback(obj,hObj,~,action)
            switch action
                case 'timeNameSelect'
                    selection = hObj.String{hObj.Value};
                    obj.selectedTimeName = selection;
                case 'valueNameSelect'
                    selection = hObj.String{hObj.Value};
                    obj.selectedValueName = selection;
            end
            %             try
            obj.histo;
            %             catch me
            %                 fprintf(2,'\n%s\n\n...plotting problems\n',me.message);
            %             end
        end
        % -----------------------------------------------------------------
        function setInfo(obj)
            fprintf('\ncurrently on set %s\n',obj.setNames{obj.currentSet});
        end
        % -----------------------------------------------------------------
    end
end


