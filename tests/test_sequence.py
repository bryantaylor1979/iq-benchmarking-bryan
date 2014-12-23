import tests_colorcheck
import unittest
import xmlrunner
import os

class test_limits(object):
    def __init__(self):
         # for test
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
         limits = test_limits();
         
         limits.filename = self.Root + '/Results/' + 'macbeth_daylight.json'
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_cwf.json'
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_horizon.json'
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_inc.json'
         self.loadtests(limits);

         limits.filename = self.Root + '/Results/' + 'macbeth_u30.json'
         self.loadtests(limits);
         
         result = unittest.TestResult();
         testRunner=xmlrunner.XMLTestRunner(output='test-reports')
         testRunner.run(self.suite)
         print 'my os.getcwd =>', os.getcwd( ) 
         os.chmod('test-reports', 0o777) #stat.S_IREAD
       
# The following is one way of running the tests
if __name__ == '__main__':
    obj = TestSuite();
    obj.Root = 'C://Users//bryantay//Dev//images//test_example//'
    obj.RUN();