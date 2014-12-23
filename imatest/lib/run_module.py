import os
class run_module():
    def __init__(self):
        # Do nothing
        self.module_name="colorcheck.exe"
        self.imatest_root='C:/Program Files (x86)/Imatest/v4.0/IT/bin/'    
        # -1 Closes the DOS window and all figures when the program terminates. For normal operation of IT/EXE programs. 
        # -2, -3, and -4 are for debugging.
        # -2 Keeps the DOS window open after the program terminates.
        # -3 Closes the DOS window and all figures when the program terminates and opens the error log file if an error is detected.
        # -4 Keeps the DOS window open after the program terminates and opens the error log file if an error is detected.
        # -11 Combine files (Param-2, Param-6, ff.), i.e., average them before analysis. This can be useful for viewing fixed pattern noise.
        # -12 Use two files (Param-2 and Param-6) to analyze temporal noise (Stepchart and Colorcheck-only). 
        self.output = -1 # -2 -  the command window will stay open. all the figure will remain on the screen.
        self.image_name = 'C:\Program Files (x86)\Jenkins\jobs\ColorCheck\workspace\example.jpg'
        self.ini_filename = 'C:\Program Files (x86)\Jenkins\jobs\ColorCheck\workspace\colour_check.ini'
        
    def run(self):
        os.chdir(self.imatest_root)
        command_str = self.module_name + ''
        command_str = command_str + ' ' + str(self.output)
        command_str = command_str + ' "' + self.image_name + '"'
        command_str = command_str + ' "' + self.imatest_root + '"'
        command_str = command_str + ' "' + self.ini_filename + '"'
        print "run_module - command str: " + command_str
        os.system(command_str)
        
if __name__ == "__main__":
    obj = run_module()
    obj.run();