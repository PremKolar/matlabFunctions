% Bastian (Tel) = 70280
% inList = {'AAA' 'BBB' 'CCC' 'DDD' 'EEE'}
% 180606 edit by NK
function [outList, newOrder,outListNot, newOrderNot,reset] = SelectColumns(inList,curList)
    reset = false;
    newOrder = (1:numel(inList))';
    newOrderNot = [];
    outListNot = [];
    %
    % Bild-Up figure
    pos = get(gcf,'position');
    hFig = figure('menubar','none','units','pixel','position',[pos(1)+(pos(3)-600)/2 pos(2)+(pos(4)-400)/2 600 400],'NumberTitle','off','Name','Select Columns');
    hPan0 = ui.VFrame('Parent',hFig,'Padding',5);
    hPan1 = ui.HFrame('Parent',hPan0,'Padding',3,'BorderType','line');
    curNonList = setdiff(inList,curList,'stable');
    hLft = uicontrol('Parent',hPan1.double,'style','listbox','min',0,'max',2,'value',[],'String',curNonList);
    hBar1 = ui.VFrame('Parent',hPan1,'padding',0,'spacing',3);
    hPush(1) = uicontrol('Parent',hBar1.double,'String','>>','Callback',@UserAction_Callback);
    hPush(2) = uicontrol('Parent',hBar1.double,'String','<<','Callback',@UserAction_Callback);
    hPush(2) = uicontrol('Parent',hBar1.double,'String','^','Callback',@UserAction_Callback);
    hPush(2) = uicontrol('Parent',hBar1.double,'String','+','Callback',@UserAction_Callback);
    hPush(2) = uicontrol('Parent',hBar1.double,'String','-','Callback',@UserAction_Callback);
    hPush(2) = uicontrol('Parent',hBar1.double,'String','v','Callback',@UserAction_Callback);
    
    hRgt = uicontrol('Parent',hPan1.double,'style','listbox','min',0,'max',2,'value',[],'String',curList);
    hBar1.Sizes = [23 23 23 23 23 23];
    hBar1.Spacing = [1 -1 1 1 1];
    hBar1.padding = {[0 -1],[3 3]};
    
    hPan1.Sizes = [-1 50 -1];
    hBar2 = ui.HFrame('Parent',hPan0,'padding',0,'spacing',3);
    hPush(3) = uicontrol('Parent',hBar2.double,'String','reset','Callback',@UserAction_Callback);
    hPush(1) = uicontrol('Parent',hBar2.double,'String','cancel','Callback',@UserAction_Callback);
    hPush(2) = uicontrol('Parent',hBar2.double,'String','ok','Callback',@UserAction_Callback);
    hBar2.Sizes = [70 70 70];
    hBar2.Padding = {[0 0],[-1 0]};
    hPan0.Sizes = [-1 25];
    %
    outList = curList;
    
    %
    uiwait(hFig)
    delete(hFig)
    
    function UserAction_Callback(hObj,evdata)
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
                set(hLft,'String',setdiff(inList,setdiff(lst,lst(val),'stable'),'stable'),'value',[])
            case '^'
                lst = get(hRgt,'String');
                val = get(hRgt,'Value');
                if ~isempty(val)
                    set(hRgt,'String',[lst(val);setdiff(lst,lst(val),'stable')],'value',find(ismember([lst(val);setdiff(lst,lst(val),'stable')],lst(val))))
                end
            case '+'
                lst = get(hRgt,'String');
                val = get(hRgt,'Value');
                if ~isempty(val) && isscalar(val)
                    ind = ismember(lst,lst(val));
                    if ~ind(1)
                        tmp = lst([ind(2:end);false]);
                        lst([ind(2:end);false]) = lst(val);
                        lst(val) = tmp;
                        set(hRgt,'String',lst,'value',find([ind(2:end);false]))
                    end
                end
            case '-'
                lst = get(hRgt,'String');
                val = get(hRgt,'Value');
                if ~isempty(val) && isscalar(val)
                    ind = ismember(lst,lst(val));
                    if ~ind(end)
                        tmp = lst([false;ind(1:end-1)]);
                        lst([false;ind(1:end-1)]) = lst(val);
                        lst(val) = tmp;
                        set(hRgt,'String',lst,'value',find([false;ind(1:end-1)]))
                    end
                end
            case 'v'
                lst = get(hRgt,'String');
                val = get(hRgt,'Value');
                if ~isempty(val)
                    set(hRgt,'String',[setdiff(lst,lst(val),'stable');lst(val)],'value',find(ismember([setdiff(lst,lst(val),'stable');lst(val)],lst(val))))
                end
            case 'cancel'
                outList = curList;
                outListNot = curNonList;
                [~,newOrderNot] = ismember(outListNot,inList);
                [~,newOrder] = ismember(outList,inList);
                
                uiresume;
            case 'ok'
                outList = get(hRgt,'String');
                [~,newOrder] = ismember(outList,inList);
                outListNot = get(hLft,'String');
                [~,newOrderNot] = ismember(outListNot,inList);
                
                uiresume;
            case 'reset'
                reset = true;
                
                uiresume;
        end
    end
end


