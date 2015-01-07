# -*- coding: utf-8 -*-
"""
Created on Tue Dec 23 10:59:51 2014

@author: bryantay
"""

import dotpattern
import os
CC_OBJ = dotpattern.dotpattern()

class adaptive_dotpattern():
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
        self.process_image('dotpattern_daylight.png')
        self.process_image('dotpattern_cwf.png')
        self.process_image('dotpattern_inc.png')
        self.process_image('dotpattern_horizon.png')
        self.process_image('dotpattern_u30.png')
        
if __name__ == "__main__":
    obj = adaptive_dotpattern()
    obj.root="C:\\Users\\bryantay\\Dev\\"
    obj.run();