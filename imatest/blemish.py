import lib.run_module as run_module
import os
import lib.write_module_settings as write_module_settings
RUN_OBJ = run_module.run_module();
SETTINGS_OBJ = write_module_settings.write_module_settings();


class blemish():
    def __init__(self):
        # Do nothing
        self.root="C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\imatest\\"
        #self.root="C:\\Users\\bryantay\\Dev\\imatest\\"
        self.imagename='C:\\Program Files (x86)\\Jenkins\\jobs\\ColorCheck\\workspace\\images\\blemish.jpg'
        
    def run(self):    
        # params
        ini_filename = "blemish.ini"
		
        # write ini file
        SETTINGS_OBJ.root_directory = os.path.join(self.root,"lib")
        SETTINGS_OBJ.out_file_name=ini_filename
        SETTINGS_OBJ.default_file_name="default_blemish.ini"
        SETTINGS_OBJ.run();
         
        RUN_OBJ.image_name = self.imagename   
        RUN_OBJ.module_name = "blemish.exe"
        RUN_OBJ.ini_filename = os.path.join(os.path.join(self.root,"lib"),ini_filename)
        RUN_OBJ.run();
        
if __name__ == "__main__":
    obj = blemish()
    obj.root="C:\\Users\\bryantay\\Dev\\imatest\\"
    obj.imagename='C:\\Users\\bryantay\\Dev\\images\\blemish.jpg'
    obj.run();