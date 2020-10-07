function loadAllStructPropsToAnObj(s,obj)
   FN = fieldnames(s);
   for f = 1:numel(FN)
      fn = FN{f};
      obj.(fn) = s.(fn);
   end
end