import read_results

class read_sfrplus_keyresults :
    def __init__(self,filename='C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json'):
        # parameters
        self.MTF50_center = 0;
        
        # Read file into json format
        self.results_obj = read_results.read_results(filename);
        self.results_obj.structname = 'sfrplusResults'
        self.struct = self.results_obj.readFile();
        
    def run(self):
        summary = self.results_obj.getParam(self.struct,'mtf50p_LWPH_summary'); 
        self.MTF50_center = summary[0]
        
        # print "summary: " + str(summary)
        print "MTF50_center: " + str(self.MTF50_center)
        
if __name__ == "__main__":
    obj = read_sfrplus_keyresults('C:/Users/bryantay/Dev/images/Results/sfrplus_cwf_Y.json');
    obj.run()
    # print obj.results_obj.string