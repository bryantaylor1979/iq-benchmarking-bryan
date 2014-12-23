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
        self.filename = test_limits.filename;
        self.min_sat = test_limits.colorcheck_min_sat;
        self.max_sat = test_limits.colorcheck_max_sat;
        self.wb_deltaC_max = test_limits.colorcheck_wb_deltaC_max;
        self.color_deltaC_max = test_limits.colorcheck_color_deltaC_max;

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
        print "COLOUR SATURATION TEST"
        print "======================"
        print "color saturation range: [" + str(self.min_sat) + " " + str(self.max_sat) + "]"
        print "color saturation measured: " + str(self.read_OBJ.mean_cameraSat_Pct)
        self.assertTrue(self.min_sat < self.read_OBJ.mean_cameraSat_Pct < self.max_sat,
                        "saturation target has not been met")
        print " "
                        
    def test_wb_DeltaC_error(self):
        print "WB Delta"
        print "========"
        print "WB Max Delta C: " + str(self.wb_deltaC_max)
        print "White balance measured: " + str(self.read_OBJ.Mean_White_Balance_delta_C)
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= self.wb_deltaC_max,
                        "wb_detlaC is too large")
        print " "
                        
    def test_color_DeltaC_error(self):
        print "Color Error Delta"
        print "================="
        print "Color Max Delta C: " + str(self.color_deltaC_max)
        print "Color error measured: " + str(self.read_OBJ.Mean_Delta_C)
        self.assertTrue(0 <= self.read_OBJ.Mean_Delta_C <= self.color_deltaC_max,
                        "colour error is too large")
        print " "
                       
    @unittest.skip("Skin check not yet implemented")
    def test_skinTone_error(self):
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= 5,
                        "wb_detlaC is too large")

    @unittest.skip("Noise check not yet implemented")
    def test_Noise(self):
        self.assertTrue(0 <= self.read_OBJ.Mean_White_Balance_delta_C <= 5,
                        "wb_detlaC is too large")

# The following is one way of running the tests
if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TESTS_COLORCHECK)
    unittest.TextTestRunner(verbosity=2).run(suite)