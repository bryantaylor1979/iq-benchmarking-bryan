import tests_colorcheck
import unittest
import xmlrunner
import os
        
#  bb_config       'continuous_intergation'
#                  'rig_temp_board'
class TestSuite():
     def __init__(self):
         self.test_limits = 1;
         self.loader = unittest.TestLoader();
         self.suite = unittest.TestSuite();
         
     def loadtests(self,test_limits=None):                       
         tests = (        tests_colorcheck.TESTS_COLORCHECK, 
                        )
         if test_limits==None:      
			self.LoadTestFromSuite(tests)
         else:	
			self.LoadTestFromSuite(tests,test_limits)
			
   
         # OTHER WAYS 
         #
         # Example 1 - Add a single test
         #      self.suite.addTest(tc_messages.TC_MESSAGES('test_software_version'))
         #
         # Example 2 - Add a module of tests using unitest framework
         #      self.suite = unittest.TestSuite((
         #      loader.loadTestsFromTestCase(tc_adc_streamer.TC_ADC_STREAMER), 
         #      loader.loadTestsFromTestCase(tc_synthesiser.TC_SYNTHESISER), 
         #      loader.loadTestsFromTestCase(tc_fsw.TC_FSW),    
         #      loader.loadTestsFromTestCase(tc_bit_gen.TC_BIT_GEN),
         #      loader.loadTestsFromTestCase(tc_calib.TC_CALIB),
         #      loader.loadTestsFromTestCase(tc_messages.TC_MESSAGES), 
         #      ))
         #
         # Example 3 - Add a module of tests using custom framework to allow        
         #             adaptation struct to be passed.       
         #      self.LoadTestFromTestCase(tc_messages_test.TC_MESSAGES,board)
         #      self.LoadTestFromTestCase(tc_adc_streamer.TC_ADC_STREAMER) 
         #
         # Example 4 - Add multiple modules with an array list. 
         #      tests = (      tc_messages_test.TC_MESSAGES, 
         #                     tc_adc_streamer.TC_ADC_STREAMER)
         #      self.LoadTestFromSuite(tests)
         #      self.LoadTestFromSuite(tests,board)
         
     def LoadTestFromSuite(self,tests,test_limits=None):
         for test in tests:
             if test_limits==None:
                self.LoadTestFromTestCase(test)
             else:
                self.LoadTestFromTestCase(test,test_limits)             
         
     def LoadTestFromTestCase(self,test_module,test_limits=None):
         testnames = self.loader.getTestCaseNames(test_module)
         for test in testnames:
             if test_limits==None:
                self.suite.addTest(test_module(test))
             else:
                self.suite.addTest(test_module(test,test_limits)) 
                          
     def RUN(self):
         test_limits = 1;
         self.loadtests(test_limits);
         result = unittest.TestResult();
         testRunner=xmlrunner.XMLTestRunner(output='test-reports')
         testRunner.run(self.suite)
         print 'my os.getcwd =>', os.getcwd( ) 
         os.chmod('test-reports', 0o777) #stat.S_IREAD
       
# The following is one way of running the tests
if __name__ == '__main__':
    obj = TestSuite();
    obj.RUN();