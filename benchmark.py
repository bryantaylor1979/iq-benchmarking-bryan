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

class adaptive_colorcheck_test_limits(object):
    def __init__(self):
         # daylight
         self.Lum0_name = 'daylight'
         self.Lum0_colorcheck_min_sat = 98
         self.Lum0_colorcheck_max_sat = 125
         self.Lum0_colorcheck_wb_deltaC_max = 5
         self.Lum0_colorcheck_color_deltaC_max = 10
		 
         self.Lum1_name = 'cwf'
         self.Lum1_colorcheck_min_sat = 98
         self.Lum1_colorcheck_max_sat = 125
         self.Lum1_colorcheck_wb_deltaC_max = 5
         self.Lum1_colorcheck_color_deltaC_max = 10
		 
         self.Lum2_name = 'horizon'
         self.Lum2_colorcheck_min_sat = 98
         self.Lum2_colorcheck_max_sat = 125
         self.Lum2_colorcheck_wb_deltaC_max = 5
         self.Lum2_colorcheck_color_deltaC_max = 10
		 
         self.Lum3_name = 'inc'
         self.Lum3_colorcheck_min_sat = 98
         self.Lum3_colorcheck_max_sat = 125
         self.Lum3_colorcheck_wb_deltaC_max = 5
         self.Lum3_colorcheck_color_deltaC_max = 10
		 
         slef.Lum4_name = 'u30'
         self.Lum4_colorcheck_min_sat = 98
         self.Lum4_colorcheck_max_sat = 125
         self.Lum4_colorcheck_wb_deltaC_max = 5
         self.Lum4_colorcheck_color_deltaC_max = 10
		 
class benchmark():
    def __init__(self):
        # Do nothing
        self.root="C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\\"
        #self.root="C:\\Users\\bryantay\\Dev\\"
        
    def run(self):    
        # Params
        CC_OBJ.root=self.root;
        CC_OBJ.run();
        
        TEST_OBJ.Root = os.path.join(self.root,"images")
        TEST_OBJ.limits = adaptive_colorcheck_test_limits();
        TEST_OBJ.RUN();
        
if __name__ == "__main__":
    obj = benchmark();
    #obj.root="C:\\Users\\bryantay\\Dev\\"
    obj.run();