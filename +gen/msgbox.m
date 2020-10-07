function h = msgbox(varargin)
    if isdeployed
        h = msgbox(varargin{:});
    else
        h = fprintf(2,sprintf('%s\n',varargin{1}));
    end    
end