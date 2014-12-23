# -*- coding: utf-8 -*-
"""
Created on Tue Dec 23 10:59:51 2014

@author: bryantay
"""
import imatest.adaptive_colorcheck as adaptive_colorcheck
import tests.test_sequence as test_sequence
import os
CC_OBJ = adaptive_colorcheck.adaptive_colorcheck();
TEST_OBJ = test_sequence.TestSuite();

class test_limits(object):
    def __init__(self):
         # for test
         self.colorcheck_min_sat = 98
         self.colorcheck_max_sat = 125
         self.colorcheck_wb_deltaC_max = 5
         self.colorcheck_color_deltaC_max = 10

class benchmark():
    def __init__(self):
        # Do nothing
        self.root="C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\\"
        #self.root="C:\\Users\\bryantay\\Dev\\"
        
    def run(self):    
        # Params
        CC_OBJ.root=self.root;
        CC_OBJ.run();
        
        TEST_OBJ.Root =os.path.join(self.root,"images")
		TEST_OBJ.limits = test_limits();
        TEST_OBJ.RUN();
        
if __name__ == "__main__":
    obj = benchmark();
    #obj.root="C:\\Users\\bryantay\\Dev\\"
    obj.run();