function print_image_tags(data)
  FieldNames = fieldnames(data{1})
  x = max(size(FieldNames));
  disp('Display decode json file')
  disp('========================')
  for i = 1:x
     disp([FieldNames{i},':']) 
     disp(data{1}.(FieldNames{i}))
  end
end