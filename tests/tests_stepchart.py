"""
Test cases for checking the basic messaging functionality of a baseband board.

"""
import unittest
import lib.read_stepchart_keyresults as read_stepchart_keyresults

class TESTS_STEPCHART(unittest.TestCase):
    """
    Test Case Name:

    Description:

    Requirements:

    Summary of test cases:

    Implementation Notes:
        Uses pure Python test framework

    """


    def __init__(self, methodName, test_limits=None):
        super(TESTS_STEPCHART, self).__init__(methodName)
        
        #self.targets = "D65"
        if test_limits==None:
             self.path = 'C:/Users/bryantay/Dev/images/Results/'
             self.imageName = 'stepchart_daylight'
             self.minSNR = 20;
             self.maxNoise = 180; # 179.34
             self.minZones = 19;
        else:
             self.path = test_limits.path;
             self.imageName = test_limits.imageName;
             self.minSNR = test_limits.minSNR;    
             self.maxNoise = test_limits.maxNoise;
             self.minZones = test_limits.minZones;
             
        self.ext = '.json';
        self.filename = self.path + self.imageName + self.ext
        self.read_OBJ = read_stepchart_keyresults.read_stepchart_keyresults(self.filename);
        self.read_OBJ.run();
        
    def setUp(self):
        """
        Description:
            Establishes contact with BB, makes us the master and opens a tcp socket.
            This uses parameters set in adaptation.py.
            Also gets and prints the software version.
        """
    def test_minSNR(self):
        string = self.buildString('min Signal/Noise Ratio',self.minSNR,100000,self.read_OBJ.minSNR);     
        self.assertTrue(self.minSNR < self.read_OBJ.minSNR < 100000,
                        string) 
                        
    def test_maxNoise(self):
        string = self.buildString('max Noise',0,self.maxNoise,self.read_OBJ.maxNoise);     
        self.assertTrue(0 < self.read_OBJ.maxNoise < self.maxNoise,
                        string)
                        
    def test_minZones(self):
        string = self.buildString('min number of visible steps (zones)',self.minZones,10000000,self.read_OBJ.zones);     
        self.assertTrue(self.minZones < self.read_OBJ.zones < 10000000,
                        string) 
                        
        
    def buildString(self,param_name,min_val,max_val,val):
        string = "\n\n" + param_name.upper() + " TEST\n"
        string = string + "======================\n"
        string = string + "image name: " + self.filename + "\n"
        string = string + param_name.lower() + " range: [" + str(min_val) + " " + str(max_val) + "]\n"
        string = string + param_name.lower() + " measured: " + str(val) + "\n"
        if (min_val < val < max_val):
             string = string +  "result:  PASS\n"
        else:
             string = string +  "result:  FAIL\n"
             string = string +  "comment: " + param_name.lower() + " target has not been met\n" 
        return string
                       

# The following is one way of running the tests
if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TESTS_STEPCHART)
    unittest.TextTestRunner(verbosity=2).run(suite)