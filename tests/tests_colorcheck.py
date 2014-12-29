"""
Test cases for checking the basic messaging functionality of a baseband board.

"""
import unittest
import lib.read_colourcheck_keyresults as read_colourcheck_keyresults

class TESTS_COLORCHECK(unittest.TestCase):
    """
    Test Case Name:

    Description:

    Requirements:

    Summary of test cases:

    Implementation Notes:
        Uses pure Python test framework

    """


    def __init__(self, methodName, test_limits=None):
        super(TESTS_COLORCHECK, self).__init__(methodName)
        
        #self.targets = "D65"
        if test_limits==None:
             self.path = 'C:/Users/bryantay/Dev/images/Results/'
             self.imageName = 'macbeth_daylight'
             self.min_sat = 98
             self.max_sat = 125
             self.wb_deltaC_max = 5
             self.color_deltaC_max = 10
        else:
             self.path = test_limits.path
             self.imageName = test_limits.imageName;
             self.min_sat = test_limits.colorcheck_min_sat;
             self.max_sat = test_limits.colorcheck_max_sat;
             self.wb_deltaC_max = test_limits.colorcheck_wb_deltaC_max;
             self.color_deltaC_max = test_limits.colorcheck_color_deltaC_max;                

        self.ext = '.json';
        self.filename = self.path + self.imageName + self.ext
        self.read_OBJ = read_colourcheck_keyresults.read_colourcheck_keyresults(self.filename);
        self.read_OBJ.run();
        
    def setUp(self):
        """
        Description:
            Establishes contact with BB, makes us the master and opens a tcp socket.
            This uses parameters set in adaptation.py.
            Also gets and prints the software version.
        """

    def test_color_saturation(self):
        string = self.buildString('color saturation',self.min_sat,self.max_sat,self.read_OBJ.mean_cameraSat_Pct);     
        self.assertTrue(self.min_sat < self.read_OBJ.mean_cameraSat_Pct < self.max_sat,
                        string)
        print " "
                        
    def test_wb_DeltaC_error(self):
        string = self.buildString('white balance DeltaC',0,self.wb_deltaC_max,self.read_OBJ.Mean_White_Balance_delta_C);     
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= self.wb_deltaC_max,
                        string)
        print " "
                        
    def test_color_DeltaC_error(self):
        string = self.buildString('color DeltaC',0,self.color_deltaC_max,self.read_OBJ.Mean_Delta_C);     
        self.assertTrue(0 <= self.read_OBJ.Mean_Delta_C <= self.color_deltaC_max,
                        string)
        print " "
        
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
                       
    @unittest.skip("Skin check not yet implemented")
    def test_skinTone_error(self):
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= 5,
                        "wb_detlaC is too large")

    @unittest.skip("Noise check not yet implemented")
    def test_Noise(self):
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= 5,
                        "wb_detlaC is too large")
						
    @unittest.skip("black level check not yet implemented")
    def test_BlackLevel(self):
	    # Looks at how tight the cluster is on the grey patches. 
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= 5,
                        "wb_detlaC is too large")

# The following is one way of running the tests
if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TESTS_COLORCHECK)
    unittest.TextTestRunner(verbosity=2).run(suite)