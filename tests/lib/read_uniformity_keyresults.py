import read_results

class read_uniformity_keyresults :
    def __init__(self,filename='C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json'):
        # parameters
        self.cpiq_color_variability = 0;
        
        # Read file into json format
        self.results_obj = read_results.read_results(filename);
        self.results_obj.structname = 'uniformityResults'
        self.struct = self.results_obj.readFile();
        
    def run(self):
        self.cpiq_color_variability = self.results_obj.getParam(self.struct,'cpiq_color_variability'); 
        #self.Mean_Delta_C = self.results_obj.getParam(self.struct,'Mean_Delta_C'); 
        #self.mean_cameraSat_Pct = self.results_obj.getParam(self.struct,'mean_cameraSat_Pct'); 
        print "cpiq_color_variability: " + str(self.cpiq_color_variability)
        
if __name__ == "__main__":
    obj = read_uniformity_keyresults('C:/Users/bryantay/Dev/images/Results/flatfield_daylight_LF_Y.json');
    obj.run()
    #print obj.results_obj.string