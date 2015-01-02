# -*- coding: utf-8 -*-
"""
Created on Tue Dec 23 10:59:51 2014

@author: bryantay
"""
import imatest.adaptive_colorcheck as adaptive_colorcheck
import imatest.adaptive_uniformity as adaptive_uniformity
import tests.test_sequence as test_sequence
import os
CC_OBJ = adaptive_colorcheck.adaptive_colorcheck();
UF_OBJ = adaptive_uniformity.adaptive_uniformity();
TEST_OBJ = test_sequence.TestSuite();

class adaptive_uniformity_test_limits(object):
	def __init__(self):
         self.Lum0 = uniformity_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum0.imageName = 'flatfield_daylight'
         self.Lum0.max_color_variance = 5
		 
         self.Lum1 = uniformity_test_limits;
         self.Lum1.path = Root+'/Results/';
         self.Lum1.imageName = 'flatfield_cwf'
         self.Lum1.max_color_variance = 5
		
         self.Lum2 = uniformity_test_limits;
         self.Lum2.path = Root+'/Results/';
         self.Lum2.imageName = 'flatfield_horizon'
         self.Lum2.max_color_variance = 5
		
         self.Lum3 = uniformity_test_limits;
         self.Lum3.path = Root+'/Results/';
         self.Lum3.imageName = 'flatfield_inc'
         self.Lum3.max_color_variance = 5
		
         self.Lum4 = uniformity_test_limits;
         self.Lum4.path = Root+'/Results/';
         self.Lum4.imageName = 'flatfield_u30'
         self.Lum4.max_color_variance = 5
         
class adaptive_colorcheck_test_limits(object):
    def __init__(self):
         # daylight
         self.Lum0 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum0.imageName = 'macbeth_daylight'
         self.Lum0.colorcheck_min_sat = 98
         self.Lum0.colorcheck_max_sat = 125
         self.Lum0.colorcheck_wb_deltaC_max = 5
         self.Lum0.colorcheck_color_deltaC_max = 10
		 
         self.Lum1 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum1.imageName = 'macbeth_cwf'
         self.Lum1.colorcheck_min_sat = 98
         self.Lum1.colorcheck_max_sat = 125
         self.Lum1.colorcheck_wb_deltaC_max = 5
         self.Lum1.colorcheck_color_deltaC_max = 10
		 
         self.Lum2 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum2.imageName = 'macbeth_horizon'
         self.Lum2.colorcheck_min_sat = 98
         self.Lum2.colorcheck_max_sat = 125
         self.Lum2.colorcheck_wb_deltaC_max = 5
         self.Lum2.colorcheck_color_deltaC_max = 10
		 
         self.Lum3 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum3.imageName = 'macbeth_inc'
         self.Lum3.colorcheck_min_sat = 98
         self.Lum3.colorcheck_max_sat = 125
         self.Lum3.colorcheck_wb_deltaC_max = 5
         self.Lum3.colorcheck_color_deltaC_max = 10
		 
         self.Lum4 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum4.imageName = 'macbeth_u30'
         self.Lum4.colorcheck_min_sat = 98
         self.Lum4.colorcheck_max_sat = 125
         self.Lum4.colorcheck_wb_deltaC_max = 5
         self.Lum4.colorcheck_color_deltaC_max = 10
         
class benchmark():
    def __init__(self):
        # Do nothing
        self.root="C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\\"
        #self.root="C:\\Users\\bryantay\\Dev\\"
        
    def run(self):    
        # Params
        CC_OBJ.root=self.root;
        CC_OBJ.run();
        
        UF_OBJ.root=self.root;
        UF_OBJ.run();
        
        TEST_OBJ.Root = os.path.join(self.root,"images")
        TEST_OBJ.color_limits = adaptive_colorcheck_test_limits();
        TEST_OBJ.uniformity_limits = adaptive_uniformity_test_limits(); 
        
        TEST_OBJ.RUN();
        
if __name__ == "__main__":
    obj = benchmark();
    #obj.root="C:\\Users\\bryantay\\Dev\\"
    obj.run();