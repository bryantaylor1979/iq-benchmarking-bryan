import tests_colorcheck
import unittest
import xmlrunner
import os

class adaptive_colorcheck_test_limits(object):
    def __init__(self):
         # daylight
         self.Lum0_name = 'daylight'
         self.Lum0_colorcheck_min_sat = 98
         self.Lum0_colorcheck_max_sat = 125
         self.Lum0_colorcheck_wb_deltaC_max = 5
         self.Lum0_colorcheck_color_deltaC_max = 10
		 
         self.Lum1_name = 'cwf'
         self.Lum1_colorcheck_min_sat = 98
         self.Lum1_colorcheck_max_sat = 125
         self.Lum1_colorcheck_wb_deltaC_max = 5
         self.Lum1_colorcheck_color_deltaC_max = 10
		 
         self.Lum2_name = 'horizon'
         self.Lum2_colorcheck_min_sat = 98
         self.Lum2_colorcheck_max_sat = 125
         self.Lum2_colorcheck_wb_deltaC_max = 5
         self.Lum2_colorcheck_color_deltaC_max = 10
		 
         self.Lum3_name = 'inc'
         self.Lum3_colorcheck_min_sat = 98
         self.Lum3_colorcheck_max_sat = 125
         self.Lum3_colorcheck_wb_deltaC_max = 5
         self.Lum3_colorcheck_color_deltaC_max = 10
		 
         self.Lum4_name = 'u30'
         self.Lum4_colorcheck_min_sat = 98
         self.Lum4_colorcheck_max_sat = 125
         self.Lum4_colorcheck_wb_deltaC_max = 5
         self.Lum4_colorcheck_color_deltaC_max = 10
		 
class colorcheck_test_limits(object):
    def __init__(self):		 
         self.filename = '';
         self.colorcheck_min_sat = 98
         self.colorcheck_max_sat = 125
         self.colorcheck_wb_deltaC_max = 5
         self.colorcheck_color_deltaC_max = 10
        
class TestSuite():
     def __init__(self):
         #self.Root = 'C://Users//bryantay//Dev//images//test_example//'
         self.Root = 'C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/images/test_example/'
         self.loader = unittest.TestLoader();
         self.suite = unittest.TestSuite();
         self.limits = adaptive_colorcheck_test_limits(); 
         
     def loadtests(self,test_limits=None):                       
         tests = (        tests_colorcheck.TESTS_COLORCHECK, 
                        )
         if test_limits==None:      
			self.LoadTestFromSuite(tests)
         else:	
			self.LoadTestFromSuite(tests,test_limits)
         
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
         limits = colorcheck_test_limits()
		 
         limits.filename = self.Root + '/Results/' + 'macbeth_' + self.limits.Lum0_name + '.json'
         limits.colorcheck_min_sat = self.limits.Lum0_limits.colorcheck_min_sat
         limits.colorcheck_max_sat = self.limits.Lum0_colorcheck_max_sat
         limits.colorcheck_wb_deltaC_max = self.limits.Lum0_colorcheck_wb_deltaC_max
         limits.colorcheck_color_deltaC_max = self.limits.Lum0_colorcheck_color_deltaC_max
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_' + self.limits.Lum1_name + '.json'
         limits.colorcheck_min_sat = self.Lum1_limits.colorcheck_min_sat
         limits.colorcheck_max_sat = self.limits.Lum1_colorcheck_max_sat
         limits.colorcheck_wb_deltaC_max = self.limits.Lum1_colorcheck_wb_deltaC_max
         limits.colorcheck_color_deltaC_max = self.limits.Lum1_colorcheck_color_deltaC_max
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_' + self.limits.Lum2_name + '.json'
         limits.colorcheck_min_sat = self.Lum2_limits.colorcheck_min_sat
         limits.colorcheck_max_sat = self.limits.Lum2_colorcheck_max_sat
         limits.colorcheck_wb_deltaC_max = self.limits.Lum2_colorcheck_wb_deltaC_max
         limits.colorcheck_color_deltaC_max = self.limits.Lum2_colorcheck_color_deltaC_max
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_' + self.limits.Lum3_name + '.json'
         limits.colorcheck_min_sat = self.Lum3_limits.colorcheck_min_sat
         limits.colorcheck_max_sat = self.limits.Lum3_colorcheck_max_sat
         limits.colorcheck_wb_deltaC_max = self.limits.Lum3_colorcheck_wb_deltaC_max
         limits.colorcheck_color_deltaC_max = self.limits.Lum3_colorcheck_color_deltaC_max
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_' + self.limits.Lum4_name + '.json'
         limits.colorcheck_min_sat = self.Lum4_limits.colorcheck_min_sat
         limits.colorcheck_max_sat = self.limits.Lum4_colorcheck_max_sat
         limits.colorcheck_wb_deltaC_max = self.limits.Lum4_colorcheck_wb_deltaC_max
         limits.colorcheck_color_deltaC_max = self.limits.Lum4_colorcheck_color_deltaC_max
         self.loadtests(limits);
         
         #result=unittest.TestResult();
         test_path = os.path.join(self.Root,'test-reports');
         print "Test results path: " + test_path
         testRunner=xmlrunner.XMLTestRunner(output=test_path);
         testRunner.run(self.suite)
         os.chmod(test_path, 0o777) #stat.S_IREAD
       
# The following is one way of running the tests
if __name__ == '__main__':
    obj = TestSuite();
    #obj.Root = 'C://Users//bryantay//Dev//images//test_example//'
    obj.RUN();