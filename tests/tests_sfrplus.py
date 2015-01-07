"""
Test cases for checking the basic messaging functionality of a baseband board.

"""
import unittest
import lib.read_sfrplus_keyresults as read_sfrplus_keyresults

class TESTS_SFRPLUS(unittest.TestCase):
    """
    Test Case Name:

    Description:

    Requirements:

    Summary of test cases:

    Implementation Notes:
        Uses pure Python test framework

    """


    def __init__(self, methodName, test_limits=None):
        super(TESTS_SFRPLUS, self).__init__(methodName)
        
        #self.targets = "D65"
        if test_limits==None:
             self.path = 'C:/Users/bryantay/Dev/images/Results/'
             self.imageName = 'sfrplus_daylight_Y'
             self.min_mtf50_center = 1500
        else:
             self.path = test_limits.path
             self.imageName = test_limits.imageName;
             self.min_mtf50_center = test_limits.min_mtf50_center;               

        self.ext = '.json';
        self.filename = self.path + self.imageName + self.ext
        self.read_OBJ = read_sfrplus_keyresults.read_sfrplus_keyresults(self.filename);
        self.read_OBJ.run();
        
    def setUp(self):
        """
        Description:
            Establishes contact with BB, makes us the master and opens a tcp socket.
            This uses parameters set in adaptation.py.
            Also gets and prints the software version.
        """

    def test_mtf50_center(self):
        string = self.buildString('mtf50 center',self.min_mtf50_center,1000000000,self.read_OBJ.MTF50_center);     
        self.assertTrue(self.min_mtf50_center < self.read_OBJ.MTF50_center < 1000000000,
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
                       

# The following is one way of running the tests
if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TESTS_SFRPLUS)
    unittest.TextTestRunner(verbosity=2).run(suite)