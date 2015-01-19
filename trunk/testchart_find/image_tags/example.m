imagename = 'C:\Users\bryantay\Dev\testchart_find\image_tags\generate_xml.jpg';
IMAGE = imread(imagename);
[PASS,macbeth] = findmacbeth_combined(IMAGE);
writeImageTags(imagename,macbeth)