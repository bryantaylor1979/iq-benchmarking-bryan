"""
Test cases for checking the basic messaging functionality of a baseband board.

"""
import unittest
import lib.read_uniformity_keyresults as read_uniformity_keyresults

class TESTS_UNIFORMITY(unittest.TestCase):
    """
    Test Case Name:

    Description:

    Requirements:

    Summary of test cases:

    Implementation Notes:
        Uses pure Python test framework

    """


    def __init__(self, methodName, test_limits=None):
        super(TESTS_UNIFORMITY, self).__init__(methodName)
        
        #self.targets = "D65"
        if test_limits==None:
             self.path = 'C:/Users/bryantay/Dev/images/Results/'
             self.imageName = 'flatfield_daylight'
             self.max_color_variance = 5
             self.max_corner_Y = 0.85
             self.min_corner_Y = 0.75
             self.max_corner_balance_Y = 5
        else:
             self.path = test_limits.path;
             self.imageName = test_limits.imageName;
             print test_limits
             self.max_color_variance = test_limits.max_color_variance;    
             self.max_corner_Y = test_limits.max_corner_Y;
             self.min_corner_Y = test_limits.min_corner_Y;
             self.max_corner_balance_Y = test_limits.max_corner_balance_Y;
             
        self.ext = '_LF_Y.json';
        self.filename = self.path + self.imageName + self.ext
        self.read_OBJ = read_uniformity_keyresults.read_uniformity_keyresults(self.filename);
        self.read_OBJ.run();
        
    def setUp(self):
        """
        Description:
            Establishes contact with BB, makes us the master and opens a tcp socket.
            This uses parameters set in adaptation.py.
            Also gets and prints the software version.
        """
    def test_lensShading_bowl_UL(self):
        string = self.buildString('lensShading bowl - UL',self.min_corner_Y,self.max_corner_Y,self.read_OBJ.Y_corner_UL);     
        self.assertTrue(self.min_corner_Y < self.read_OBJ.Y_corner_UL < self.max_corner_Y,
                        string) 
                        
    def test_lensShading_bowl_UR(self):
        string = self.buildString('lensShading bowl - UR',self.min_corner_Y,self.max_corner_Y,self.read_OBJ.Y_corner_UR);     
        self.assertTrue(self.min_corner_Y < self.read_OBJ.Y_corner_UR < self.max_corner_Y,
                        string)
                        
    def test_lensShading_bowl_LL(self):
        string = self.buildString('lensShading bowl - LL',self.min_corner_Y,self.max_corner_Y,self.read_OBJ.Y_corner_LL);     
        self.assertTrue(self.min_corner_Y < self.read_OBJ.Y_corner_LL < self.max_corner_Y,
                        string) 
                        
    def test_lensShading_bowl_LR(self):
        string = self.buildString('lensShading bowl - LR',self.min_corner_Y,self.max_corner_Y,self.read_OBJ.Y_corner_LR);     
        self.assertTrue(self.min_corner_Y < self.read_OBJ.Y_corner_LR < self.max_corner_Y,
                        string) 

    def test_lensShading_corner_balance(self):
        array = [self.read_OBJ.Y_corner_LR,self.read_OBJ.Y_corner_LL,self.read_OBJ.Y_corner_UR,self.read_OBJ.Y_corner_UL]
        val = (max(array) - min(array))*100
        print "max val: " + str(val)
        string = self.buildString('lensShading corner balance',0,self.max_corner_balance_Y,val);     
        self.assertTrue(0 < val < self.max_corner_balance_Y,
                        string)        

    def test_color_variance(self):
        string = self.buildString('color variance',0,self.max_color_variance,self.read_OBJ.cpiq_color_variability);     
        self.assertTrue(0 < self.read_OBJ.cpiq_color_variability < self.max_color_variance,
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
    suite = unittest.TestLoader().loadTestsFromTestCase(TESTS_UNIFORMITY)
    unittest.TextTestRunner(verbosity=2).run(suite)