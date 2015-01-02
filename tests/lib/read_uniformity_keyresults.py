import read_results

class read_uniformity_keyresults :
    def __init__(self,filename='C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json'):
        # parameters
        self.cpiq_color_variability = 0;
        self.Y_corner_UL = 0;
        self.Y_corner_LL = 0;
        self.Y_corner_UR = 0;
        self.Y_corner_LR = 0;
        
        # Read file into json format
        self.results_obj = read_results.read_results(filename);
        self.results_obj.structname = 'uniformityResults'
        self.struct = self.results_obj.readFile();
        
    def run(self):
        self.cpiq_color_variability = self.results_obj.getParam(self.struct,'cpiq_color_variability'); 
        corners = self.results_obj.getParam(self.struct,'corner_lvls_Pct_UL_LL_UR_LR');
        self.Y_corner_UL = corners[0]
        self.Y_corner_LL = corners[1]
        self.Y_corner_UR = corners[2]
        self.Y_corner_LR = corners[3]
        print "cpiq_color_variability: " + str(self.cpiq_color_variability)
        print "Y_corner_UL: " + str(self.Y_corner_UL)
        print "Y_corner_LL: " + str(self.Y_corner_LL)
        print "Y_corner_UR: " + str(self.Y_corner_UR)
        print "Y_corner_LR: " + str(self.Y_corner_LR)
        
if __name__ == "__main__":
    obj = read_uniformity_keyresults('C:/Users/bryantay/Dev/images/Results/flatfield_daylight_LF_Y.json');
    obj.run()
    #print obj.results_obj.string