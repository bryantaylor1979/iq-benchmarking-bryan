import json
class read_results:
    def __init__(self,filename):
        # parameters
        self.filename = filename;
        self.structname = 'jstruct' # uniformityResults
        
    def readFile(self):        
        # Read file into json format
        file = open(self.filename, 'r');
        self.string = file.read();
        struct = json.loads(self.string);
        return struct
        
    def getParam(self,struct,ParamName):
        Val = struct[self.structname][ParamName]
        if Val.__len__() == 1:
            Val = Val[0]
        return Val
        
if __name__ == "__main__":
    obj = read_results('C:/Users/bryantay/Dev/images/Results/flatfield_cwf_LF_Y.json');
    obj.structname = 'uniformityResults'
    struct = obj.readFile();
    Val = obj.getParam(struct,'cpiq_color_variability');
    print Val