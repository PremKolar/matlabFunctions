% NK
function out = datetime(varargin)
    if numel(varargin)==1
        if isdatetime(varargin{1})
            out = varargin{1};
            return
        end
        if varargin{1} == 0
            out = NaT;
        else
            out = datetime(varargin{1},'convertfrom','datenum');
        end
    else
        out = datetime(varargin{:});
    end
end