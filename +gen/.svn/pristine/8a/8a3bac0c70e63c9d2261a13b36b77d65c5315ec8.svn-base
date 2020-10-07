function C = str2doubleCell(C)
       validateattributes(C,{'cell'},{});
       for j=1:numel(C)
          if isempty(C{j})
              C{j} = nan;
          elseif ischar(C{j})
              C{j} = str2double(C{j});
          end
       end
end