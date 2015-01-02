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

Root = 'C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/'

test_sequence.Root = Root+'/images/';
TEST_OBJ = test_sequence.TestSuite();
#Root = 'C://Users//bryantay//Dev//images//'

class uniformity_test_limits(object):
    def __init__(self):		
         self.path = '';
         self.imageName = '';
         self.max_color_variance = 5
         self.max_corner_Y = 0.85
         self.min_corner_Y = 0.75

class adaptive_uniformity_test_limits(object):
	def __init__(self):
         self.Lum0 = uniformity_test_limits;
         self.Lum0.path = Root+'/images/Results/';
         self.Lum0.imageName = 'flatfield_daylight'
         self.Lum0.max_color_variance = 5
         self.Lum0.max_corner_Y = 0.85
         self.Lum0.min_corner_Y = 0.75
		 
         self.Lum1 = uniformity_test_limits;
         self.Lum1.path = Root+'/images/Results/';
         self.Lum1.imageName = 'flatfield_cwf'
         self.Lum1.max_color_variance = 5
         self.Lum1.max_corner_Y = 0.85
         self.Lum1.min_corner_Y = 0.75
         
         self.Lum2 = uniformity_test_limits;
         self.Lum2.path = Root+'/images/Results/';
         self.Lum2.imageName = 'flatfield_horizon'
         self.Lum2.max_color_variance = 5
         self.Lum2.max_corner_Y = 0.85
         self.Lum2.min_corner_Y = 0.75
         
         self.Lum3 = uniformity_test_limits;
         self.Lum3.path = Root+'/images/Results/';
         self.Lum3.imageName = 'flatfield_inc'
         self.Lum3.max_color_variance = 5
         self.Lum3.max_corner_Y = 0.85
         self.Lum3.min_corner_Y = 0.75
         
         self.Lum4 = uniformity_test_limits;
         self.Lum4.path = Root+'/images/Results/';
         self.Lum4.imageName = 'flatfield_u30'
         self.Lum4.max_color_variance = 5
         self.Lum4.max_corner_Y = 0.85
         self.Lum4.min_corner_Y = 0.75
         
class colorcheck_test_limits(object):
    def __init__(self):		 
         self.path = '';
         self.imageName = '';
         self.colorcheck_min_sat = 98
         self.colorcheck_max_sat = 125
         self.colorcheck_wb_deltaC_max = 5
         self.colorcheck_color_deltaC_max = 10
         
class adaptive_colorcheck_test_limits(object):
    def __init__(self):
         # daylight
         self.Lum0 = colorcheck_test_limits;
         self.Lum0.path = Root+'/images/Results/';
         self.Lum0.imageName = 'macbeth_daylight'
         self.Lum0.colorcheck_min_sat = 98
         self.Lum0.colorcheck_max_sat = 125
         self.Lum0.colorcheck_wb_deltaC_max = 5
         self.Lum0.colorcheck_color_deltaC_max = 10
		 
         self.Lum1 = colorcheck_test_limits;
         self.Lum0.path = Root+'/images/Results/';
         self.Lum1.imageName = 'macbeth_cwf'
         self.Lum1.colorcheck_min_sat = 98
         self.Lum1.colorcheck_max_sat = 125
         self.Lum1.colorcheck_wb_deltaC_max = 5
         self.Lum1.colorcheck_color_deltaC_max = 10
		 
         self.Lum2 = colorcheck_test_limits;
         self.Lum0.path = Root+'/images/Results/';
         self.Lum2.imageName = 'macbeth_horizon'
         self.Lum2.colorcheck_min_sat = 98
         self.Lum2.colorcheck_max_sat = 125
         self.Lum2.colorcheck_wb_deltaC_max = 5
         self.Lum2.colorcheck_color_deltaC_max = 10
		 
         self.Lum3 = colorcheck_test_limits;
         self.Lum0.path = Root+'/images/Results/';
         self.Lum3.imageName = 'macbeth_inc'
         self.Lum3.colorcheck_min_sat = 98
         self.Lum3.colorcheck_max_sat = 125
         self.Lum3.colorcheck_wb_deltaC_max = 5
         self.Lum3.colorcheck_color_deltaC_max = 10
		 
         self.Lum4 = colorcheck_test_limits;
         self.Lum0.path = Root+'/images/Results/';
         self.Lum4.imageName = 'macbeth_u30'
         self.Lum4.colorcheck_min_sat = 98
         self.Lum4.colorcheck_max_sat = 125
         self.Lum4.colorcheck_wb_deltaC_max = 5
         self.Lum4.colorcheck_color_deltaC_max = 10
         
class benchmark():
    def __init__(self):
        # Do nothing
        self.root=Root;
        
    def run(self):    
        # Params
        CC_OBJ.root=Root;
        CC_OBJ.run();
        
        UF_OBJ.root=Root;
        UF_OBJ.run();
        
        TEST_OBJ.Root = os.path.join(self.root,"images")
        TEST_OBJ.color_limits = adaptive_colorcheck_test_limits();
        TEST_OBJ.uniformity_limits = adaptive_uniformity_test_limits(); 
        
        TEST_OBJ.RUN();
        
if __name__ == "__main__":
    obj = benchmark();
    obj.run();