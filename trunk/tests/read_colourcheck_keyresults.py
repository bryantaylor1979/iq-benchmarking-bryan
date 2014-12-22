import read_results

class read_colourcheck_keyresults :
    def __init__(self,filename='C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json'):
        # parameters
        self.Mean_White_Balance_delta_C = 0;
        self.Mean_Delta_C = 0;
        self.mean_cameraSat_Pct = 0;
        
        # Read file into json format
        self.results_obj = read_results.read_results(filename);
        self.struct = self.results_obj.readFile();
        
    def run(self):
        self.Mean_White_Balance_delta_C = self.results_obj.getParam(self.struct,'Mean_White_Balance_delta_C'); 
        self.Mean_Delta_C = self.results_obj.getParam(self.struct,'Mean_Delta_C'); 
        self.mean_cameraSat_Pct = self.results_obj.getParam(self.struct,'mean_cameraSat_Pct'); 
        print "Mean_White_Balance_delta_C: " + str(self.Mean_White_Balance_delta_C)
        print "Mean_Delta_C: " + str(self.Mean_Delta_C)
        print "mean_cameraSat_Pct: " + str(self.mean_cameraSat_Pct)
        
if __name__ == "__main__":
    obj = read_colourcheck_keyresults('C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json');
    obj.run()
    #print obj.results_obj.string