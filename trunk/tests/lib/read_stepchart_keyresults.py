import read_results

class read_stepchart_keyresults :
    def __init__(self,filename='C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json'):
        # parameters
        self.minSNR = 0;
        self.maxNoise = 0;
        self.zones = 0;
        
        # Read file into json format
        self.results_obj = read_results.read_results(filename);
        self.results_obj.structname = 'stepchartResults'
        self.struct = self.results_obj.readFile();
        
    def run(self):
        Y_SNR_dB = self.results_obj.getParam(self.struct,'Y_SNR_dB'); 
        Y_SigNoise = self.results_obj.getParam(self.struct,'Y_SigNoise');
        
        self.zones = self.results_obj.getParam(self.struct,'zones'); 
        self.minSNR  = min(Y_SNR_dB)
        self.maxNoise = max(Y_SigNoise)
        
        print "zones: " + str(self.zones)
        print "minSNR: " + str(self.minSNR)
        print "maxNoise: " + str(self.maxNoise)
        
if __name__ == "__main__":
    obj = read_stepchart_keyresults('C:/Users/bryantay/Dev/images/Results/stepchart_daylight.json');
    obj.run()
    #print obj.results_obj.string