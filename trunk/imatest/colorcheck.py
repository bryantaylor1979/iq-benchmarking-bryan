import lib.run_module as run_module
import os
import lib.write_module_settings as write_module_settings
RUN_OBJ = run_module.run_module();
SETTINGS_OBJ = write_module_settings.write_module_settings();


class colorcheck():
    def __init__(self):
        # Do nothing
        self.root="C:\\Users\\bryantay\\Dev\\imatest\\"
        self.imagename = 'C:\\Users\\bryantay\\Dev\\images\\test_example\\macbeth_daylight.jpg'
        
    def run(self):    
        # write ini file
        SETTINGS_OBJ.root_directory = os.path.join(self.root,"lib")
        SETTINGS_OBJ.out_file_name="colour_check.ini"
        SETTINGS_OBJ.default_file_name="default_colour_check.ini"
        SETTINGS_OBJ.run();
         
        RUN_OBJ.image_name = self.imagename     
        RUN_OBJ.ini_filename = os.path.join(os.path.join(self.root,"lib"),"colour_check.ini")
        RUN_OBJ.run();
        
if __name__ == "__main__":
    obj = colorcheck()
    obj.run();