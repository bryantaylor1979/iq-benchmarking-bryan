import json
class read_results:
    def __init__(self,filename):
        # parameters
        self.filename = filename;
        
    def readFile(self):        
        # Read file into json format
        file = open(self.filename, 'r');
        self.string = file.read();
        struct = json.loads(self.string);
        return struct
        
    def getParam(self,struct,ParamName):
        Val = struct['jstruct'][ParamName]
        if Val.__len__() == 1:
            Val = Val[0]
        return Val
        
if __name__ == "__main__":
    obj = read_results('C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/Results/example.json');
    struct = obj.readFile();
    Val = obj.getParam(struct,'Mean_White_Balance_delta_C94');
    print Val