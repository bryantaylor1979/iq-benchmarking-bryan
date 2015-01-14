function IMAGE = imcontraststretch(IMAGE)
    brightest_pixel = max(max(IMAGE));
    darkest_pixel = min(min(IMAGE));
    darkest_pixel = 0;
    IMAGE=(IMAGE-darkest_pixel)/brightest_pixel;
end