classdef cellArrayComparitor < handle
    
    properties
        C1
        C2
        resultTable
        colorMatrix4visualization
        columnNames
        idColumn
        columnsToShow
        otherTag = 'other'
        white = [1 1 1]
        grayA   = [0.95 0.95 0.95]
        grayB   = [0.9  0.9  0.9 ]
        yellowA = [0.95 0.95 0.6 ]
        yellowB = [0.95 0.95 0.8 ]
        red     = [0.95 0.8  0.8 ]
        green   = [0.8  0.95 0.8 ]
    end
    
    properties (Dependent)
        columnsToCompare
    end
    
    properties (Hidden)
        idColumnIdx
        ofC1isInC2
        ofC1isWhereInC2
        sortOrder
        idxDeltaCheck
        oldDataSameEvent
        newDataSameEvent
        newEvents
        oldEvents
        apNotMatchingRows
        truecolor = @(clr) round((clr.*255))*[65536;256;1];
        columnIdcsToCompare
    end
    
        
    methods
        function obj = cellArrayComparitor(C1,C2,columnNames)
            if isempty(C1) || isempty(C2)
                error('empty input(s)')
            end
            if istable(C1)
                obj.C1 = table2cell(C1);
            else
                obj.C1 = C1;
            end
             if istable(C2)
                obj.C2 = table2cell(C2);
            else
                obj.C2 = C2;
            end
            obj.columnNames         = columnNames;
            % presets
            obj.columnIdcsToCompare = true(size(columnNames));
            obj.columnsToCompare    = obj.columnNames;
            obj.idColumn = columnNames{1};
            obj.idColumnIdx = 1;
        end
        
        function setIDcolumn(obj,id)
            obj.idColumn    = id;
            obj.idColumnIdx = strcmp(id,obj.columnNames);
        end
        
               
        
        function set.columnsToCompare(obj,cols)
            [~,obj.columnIdcsToCompare] = ismember(cols,obj.columnNames);
        end
        
        function out = get.columnsToCompare(obj)
            out = obj.columnNames(obj.columnIdcsToCompare);
        end
        
        function calcResultsTable(obj)
            % cross associate
            [obj.ofC1isInC2,obj.ofC1isWhereInC2] = ismember(obj.C1(:,obj.idColumnIdx),obj.C2(:,obj.idColumnIdx));
            
            % existing entries within C1 and C2
            obj.newDataSameEvent = obj.C1(obj.ofC1isInC2,:);
            obj.oldDataSameEvent = obj.C2(obj.ofC1isWhereInC2(obj.ofC1isInC2),:);
            
            % check existing entries for equality
            obj.idxDeltaCheck = cellfun(@isequal , obj.newDataSameEvent , obj.oldDataSameEvent);
            
            % set not-to-be-compares to true
            obj.idxDeltaCheck(:,setdiff(1:size(obj.idxDeltaCheck,2), obj.columnIdcsToCompare)) = true;
            
            % find which rows are not identical
            obj.apNotMatchingRows = any(~obj.idxDeltaCheck,2);
            
            % mark ID column so that it can be seen which is which
            obj.oldDataSameEvent = obj.markOtherRows(obj.oldDataSameEvent);
            
            % entries, that are new
            obj.newEvents = obj.C1(~obj.ofC1isInC2,:);
            
            % entries, that do not exist within new data
            oldRows   = setdiff(1:size(obj.C2,1),obj.ofC1isWhereInC2(obj.ofC1isInC2));
            obj.oldEvents = obj.C2(oldRows,:) ;
            
            % mark Event ID so that it can be seen which is which
            obj.oldEvents = obj.markOtherRows(obj.oldEvents);
            
            % collect all the needed rows
            resultTable = [...
                obj.newDataSameEvent;...
                obj.oldDataSameEvent(obj.apNotMatchingRows,:);... % also show the old events that were changed
                obj.newEvents;...
                obj.oldEvents  ]; %#ok<*PROP>
            
            % sort by ID
            [ obj.resultTable , obj.sortOrder ] = sortrows(resultTable,1);
        end
        
        function calcColorMatrix4visualization(obj)
            % existing entries, new state
            clr_NewDataSameEvent_idx = ~obj.idxDeltaCheck; % matrix that is true for changed cells
            clr_NewDataSameEvent = repmat(obj.truecolor(obj.white),size(obj.newDataSameEvent)); % initialize in white
            clr_NewDataSameEvent(obj.apNotMatchingRows,:) = obj.truecolor(obj.grayA); % make rows grey
            clr_NewDataSameEvent(clr_NewDataSameEvent_idx) = obj.truecolor(obj.yellowA); % yellow for changes
            
            % existing entries, old state
            clr_oldDataSameEvent = repmat(obj.truecolor(obj.grayB),size(obj.oldDataSameEvent(obj.apNotMatchingRows,:))); % grey
            clr_oldDataSameEvent(clr_NewDataSameEvent_idx(obj.apNotMatchingRows,:)) = obj.truecolor(obj.yellowB); % grey/yellow for changes;
            
            % new entries
            clr_newEvents = repmat(obj.truecolor(obj.green),size(obj.newEvents)); % green
            % deleted/old/outdated entries
            clr_oldEvents = repmat(obj.truecolor(obj.red),size(obj.oldEvents)); % red
            
            % collect all the needed rows
            colorMatrix4visualization = [...
                clr_NewDataSameEvent;...
                clr_oldDataSameEvent;...
                clr_newEvents;...
                clr_oldEvents];
            
            % sort like the result table
            obj.colorMatrix4visualization = colorMatrix4visualization(obj.sortOrder,:);
        end
        
        function selectColumnsToCompare(obj,parentFig)
            % Build-Up figure
            pos = parentFig.Position;
            hFig = figure('menubar','none','units','pixel','position',[pos(1)+(pos(3)-600)/2 pos(2)+(pos(4)-400)/2 600 400],'NumberTitle','off','Name','Select Columns for comparison (right side)');
            hPan0 = ui.VFrame('Parent',hFig,'Padding',5);
            hPan1 = ui.HFrame('Parent',hPan0,'Padding',3,'BorderType','line');
            curNonList = setdiff(obj.columnNames,obj.columnNames,'stable');
            hLft = uicontrol('Parent',hPan1.double,'style','listbox','min',0,'max',2,'value',[],'String',curNonList);
            hBar1 = ui.VFrame('Parent',hPan1,'padding',0,'spacing',3);
            uicontrol('Parent',hBar1.double,'String','>>','Callback',@UserAction_Callback);
            uicontrol('Parent',hBar1.double,'String','<<','Callback',@UserAction_Callback);
            
            hRgt = uicontrol('Parent',hPan1.double,'style','listbox','min',0,'max',2,'value',[],'String',obj.columnNames);
            hBar1.Sizes = [23 23];
            hBar1.Spacing = 1;
            
            hPan1.Sizes = [-1 50 -1];
            hBar2 = ui.HFrame('Parent',hPan0,'padding',0,'spacing',3);
            uicontrol('Parent',hBar2.double,'String','cancel','Callback',@UserAction_Callback);
            uicontrol('Parent',hBar2.double,'String','ok','Callback',@UserAction_Callback);
            hBar2.Sizes = [70 70];
            hBar2.Padding = {[0 0],[-1 0]};
            hPan0.Sizes = [-1 25];
            
            uiwait(hFig);
            delete(hFig);
            
            function UserAction_Callback(hObj,~)
                switch get(hObj,'String')
                    case '>>'
                        lst = get(hLft,'String');
                        val = get(hLft,'Value');
                        set(hLft,'String',setdiff(lst,lst(val),'stable'),'Value',[])
                        set(hRgt,'String',[get(hRgt,'String');lst(val)])
                    case '<<'
                        lst = get(hRgt,'String');
                        val = get(hRgt,'Value');
                        set(hRgt,'String',setdiff(lst,lst(val),'stable'),'Value',[])
                        set(hLft,'String',setdiff(obj.columnNames,setdiff(lst,lst(val),'stable'),'stable'),'value',[])
                    case 'cancel'
                        uiresume;
                    case 'ok'
                        obj.columnsToCompare = get(hRgt,'String');
                        uiresume;
                end
            end
        end
        
    end
    methods (Access = private)
        function C = markOtherRows(obj,C)
            C(:,obj.idColumnIdx) = strcat( C(:,obj.idColumnIdx) , obj.otherTag);
        end
    end
end




