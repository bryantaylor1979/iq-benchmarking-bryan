%%
imagename = '/var/lib/jenkins/jobs/findmacbeth_udayton/workspace/image_tags/test.jpg';
IMAGE = imread(imagename);
[PASS,macbeth] = findmacbeth_combined(IMAGE);
writeImageTags(imagename,macbeth);

%% Just decode the tags. 
json = fileread('test.json')
data = json2struct2(json);
print_image_tags(data);

%% Write the data back out again
json2 = struct2json2(data)

%%
data2 = json2struct2(json2);
print_image_tags(data2)

%%
data = json2struct2(json);
print_image_tags(data2)