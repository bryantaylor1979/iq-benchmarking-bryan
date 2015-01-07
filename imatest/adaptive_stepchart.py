# -*- coding: utf-8 -*-
"""
Created on Tue Dec 23 10:59:51 2014

@author: bryantay
"""

import stepchart
import os
CC_OBJ = stepchart.stepchart()

class adaptive_stepchart():
    def __init__(self):
        # Do nothing
        self.root="C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\\"
        #self.root="C:\\Users\\bryantay\\Dev\\"
        
    def process_image(self,imagename):
        CC_OBJ.root = os.path.join(self.root,'imatest')
        CC_OBJ.imagename=os.path.join(self.root,'images',imagename)
        CC_OBJ.run();  
        
    def run(self):    
        # Params
        self.process_image('stepchart_daylight.jpg')
        self.process_image('stepchart_cwf.jpg')
        self.process_image('stepchart_inc.jpg')
        self.process_image('stepchart_horizon.jpg')
        self.process_image('stepchart_u30.jpg')
        
if __name__ == "__main__":
    obj = adaptive_stepchart()
    obj.root="C:\\Users\\bryantay\\Dev\\"
    obj.run();