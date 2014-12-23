# -*- coding: utf-8 -*-
"""
Created on Tue Dec 23 10:59:51 2014

@author: bryantay
"""
import imatest.adaptive_colorcheck as adaptive_colorcheck
import tests.test_sequence as test_sequence
CC_OBJ = adaptive_colorcheck.adaptive_colorcheck();
TEST_OBJ = test_sequence.TestSuite();

class benchmark():
    def __init__(self):
        # Do nothing
        self.root="C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\\"
        #self.root="C:\\Users\\bryantay\\Dev\\"
        self.projectname = 'test_example'
        
    def run(self):    
        # Params
        CC_OBJ.root=self.root
        CC_OBJ.projectname=self.projectname
        CC_OBJ.run()
        
        TEST_OBJ.Root ='C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/images/test_example/'
        TEST_OBJ.RUN();
        
if __name__ == "__main__":
    obj = benchmark();
    #obj.root="C:\\Users\\bryantay\\Dev\\"
    obj.run();