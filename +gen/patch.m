function  [p,l] = patch(ax, from, till, typeY, typeC, d, typeCalt,nolegend,customColors,allTypeY,textInPatch,fontsize)
    
    validateattributes(from,{'double'},{'column'}) % datenums
    validateattributes(till,{'double'},{'column'}) % datenums
    
    if ~(exist('fontsize','var') && ~isempty(fontsize))
        fontsize=8;
    end
    
    if nargin>=9
        if ~(iscell(customColors) && size(customColors,2)==2 && ischar(customColors{1,1}) && isnumeric(customColors{1,2}) && all(size(customColors{1,2})==[1 3]))
            error('customColors must be a x by 2 cell array with the first column char arrays and the 2nd column 1x3 double arrays');
        end
    end
    
    if numel(from)<1
        return
    end
    if nargin<6 || isempty(d)
        d = 0.8;
    end
    
    if nargin<7
        typeCalt = repmat({''},size(typeC));
    end
    
    
    %%
    [uniquetypesY,~,idxY] = unique(typeY);
    
    [uniquetypesC,idxCb,idxC] = unique(typeC);
    if exist('customColors','var') && ~isempty(customColors)
        colors = makeCustomCM(customColors,uniquetypesC);
    else
        CM = jet;
        colors = CM(round(linspace(1,size(CM,1),numel(uniquetypesC))),:);
    end
    
    
    axes(ax);
    hold(ax,'on');
    M = numel(from);
    
    tag = cellfun(@(a,b,c,d) sprintf('%s - %s - %s - %s',a,b,c,d),typeC,typeCalt,gen.datestr(num2cell(from),'yyyy-mm-dd'),gen.datestr(num2cell(till),'yyyy-mm-dd'),'UniformOutput',0);
    
    for j=1:M
        [y,x] = makeblock(from(j),till(j),d,idxY(j));
        p(j) = patch(ax,x,y,colors(idxC(j),:));
        p(j).Tag = tag{j}; %#ok<*AGROW>
        if exist('textInPatch','var') && ~isempty(textInPatch)
            writeIntoBlock(ax,x,y,textInPatch{j},fontsize);
        end
    end
    
    l=[];
    if ~exist('nolegend','var') || (exist('nolegend','var') && ~nolegend)
       l = legend(p(idxCb), uniquetypesC{:},'AutoUpdate','off');        
    end
    if exist('allTypeY','var') && ~isempty(allTypeY)
        set(ax,'YTick',1:numel(allTypeY),'YTickLabel',allTypeY);
        ax.YLim(2) = numel(allTypeY) + d/1.9;
    else
        set(ax,'YTick',1:numel(uniquetypesY),'YTickLabel',uniquetypesY);
        ax.YLim(2) = numel(uniquetypesY) + d/1.9;
    end
end

function writeIntoBlock(ax,x,y,textInPatch,fontsize)
    xa = min(x);
    xb = max(x);
    ya = min(y);
    yb = max(y);
    text(xa+(xb-xa)/20,ya+(yb-ya)/2,textInPatch,'Interpreter','none','fontsize',fontsize);
end

function [y,x] = makeblock(f,t,d,offset)
    y = [-d/2 d/2 d/2 -d/2] + offset;
    x = [f f t t];
end


function colors = makeCustomCM(customColors,types)
    colors = rand(numel(types),3);
    [is,where] = ismember(types,customColors(:,1));
    colors(is,:) = cell2mat(customColors(where(is),2));
end
