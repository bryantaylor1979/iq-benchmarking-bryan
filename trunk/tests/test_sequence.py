import tests_colorcheck
import tests_uniformity
import unittest
import xmlrunner
import os

#Root = 'C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/images/'
Root = 'C://Users//bryantay//Dev//images//'

class uniformity_test_limits(object):
    def __init__(self):		
         self.path = '';
         self.imageName = '';
         self.max_color_variance = 5
         self.max_corner_Y = 0.85
         self.min_corner_Y = 0.75
         
class adaptive_uniformity_test_limits(object):
	def __init__(self):
         self.Lum0 = uniformity_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum0.imageName = 'flatfield_daylight'
         self.Lum0.max_color_variance = 5
         self.Lum0.max_corner_Y = 0.85
         self.Lum0.min_corner_Y = 0.75
         
         self.Lum1 = uniformity_test_limits;
         self.Lum1.path = Root+'/Results/';
         self.Lum1.imageName = 'flatfield_cwf'
         self.Lum1.max_color_variance = 5
         self.Lum1.max_corner_Y = 0.85
         self.Lum1.min_corner_Y = 0.75
         
         self.Lum2 = uniformity_test_limits;
         self.Lum2.path = Root+'/Results/';
         self.Lum2.imageName = 'flatfield_horizon'
         self.Lum2.max_color_variance = 5
         self.Lum2.max_corner_Y = 0.85
         self.Lum2.min_corner_Y = 0.75
         
         self.Lum3 = uniformity_test_limits;
         self.Lum3.path = Root+'/Results/';
         self.Lum3.imageName = 'flatfield_inc'
         self.Lum3.max_color_variance = 5
         self.Lum3.max_corner_Y = 0.85
         self.Lum3.min_corner_Y = 0.75
         
         self.Lum4 = uniformity_test_limits;
         self.Lum4.path = Root+'/Results/';
         self.Lum4.imageName = 'flatfield_u30'
         self.Lum4.max_color_variance = 5
         self.Lum4.max_corner_Y = 0.85
         self.Lum4.min_corner_Y = 0.75
         
class colorcheck_test_limits(object):
    def __init__(self):		 
         self.path = '';
         self.imageName = '';
         self.colorcheck_min_sat = 98
         self.colorcheck_max_sat = 125
         self.colorcheck_wb_deltaC_max = 5
         self.colorcheck_color_deltaC_max = 10
         
class adaptive_colorcheck_test_limits(object):
    def __init__(self):
         # daylight
         self.Lum0 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum0.imageName = 'macbeth_daylight'
         self.Lum0.colorcheck_min_sat = 98
         self.Lum0.colorcheck_max_sat = 125
         self.Lum0.colorcheck_wb_deltaC_max = 5
         self.Lum0.colorcheck_color_deltaC_max = 10
		 
         self.Lum1 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum1.imageName = 'macbeth_cwf'
         self.Lum1.colorcheck_min_sat = 98
         self.Lum1.colorcheck_max_sat = 125
         self.Lum1.colorcheck_wb_deltaC_max = 5
         self.Lum1.colorcheck_color_deltaC_max = 10
		 
         self.Lum2 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum2.imageName = 'macbeth_horizon'
         self.Lum2.colorcheck_min_sat = 98
         self.Lum2.colorcheck_max_sat = 125
         self.Lum2.colorcheck_wb_deltaC_max = 5
         self.Lum2.colorcheck_color_deltaC_max = 10
		 
         self.Lum3 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum3.imageName = 'macbeth_inc'
         self.Lum3.colorcheck_min_sat = 98
         self.Lum3.colorcheck_max_sat = 125
         self.Lum3.colorcheck_wb_deltaC_max = 5
         self.Lum3.colorcheck_color_deltaC_max = 10
		 
         self.Lum4 = colorcheck_test_limits;
         self.Lum0.path = Root+'/Results/';
         self.Lum4.imageName = 'macbeth_u30'
         self.Lum4.colorcheck_min_sat = 98
         self.Lum4.colorcheck_max_sat = 125
         self.Lum4.colorcheck_wb_deltaC_max = 5
         self.Lum4.colorcheck_color_deltaC_max = 10
		 

		 
        
class TestSuite():
     def __init__(self):
         #self.Root = 'C://Users//bryantay//Dev//images//test_example//'
         #self.Root = 'C:/Program Files (x86)/Jenkins/jobs/ColorCheck/workspace/images/test_example/'
         self.loader = unittest.TestLoader();
         self.suite = unittest.TestSuite();
         self.color_limits = adaptive_colorcheck_test_limits();
         self.uniformity_limits = adaptive_uniformity_test_limits(); 
         
     def loadtests(self,testName='colorcheck',test_limits=None):   
         if testName == 'colorcheck':
             tests = (        tests_colorcheck.TESTS_COLORCHECK, 
                        )
         elif testName == 'uniformity':
             tests = (        tests_uniformity.TESTS_UNIFORMITY, 
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
                
     def loadAdaptiveTests(self,limits,testName):
         limits_single =          limits.Lum0
         self.loadtests(testName,limits_single);

         limits_single =          limits.Lum1
         self.loadtests(testName,limits_single);

         limits_single =          limits.Lum2
         self.loadtests(testName,limits_single);

         limits_single =          limits.Lum3
         self.loadtests(testName,limits_single);

         limits_single =          limits.Lum4
         self.loadtests(testName,limits_single);
                          
     def RUN(self):  
         limits = adaptive_colorcheck_test_limits()
         self.loadAdaptiveTests(limits,'colorcheck')
         
         limits = adaptive_uniformity_test_limits()
         self.loadAdaptiveTests(limits,'uniformity')
         
         #result=unittest.TestResult();
         test_path = os.path.join(Root,'test-reports');
         print "Test results path: " + test_path
         testRunner=xmlrunner.XMLTestRunner(output=test_path);
         testRunner.run(self.suite)
         os.chmod(test_path, 0o777) #stat.S_IREAD
       
# The following is one way of running the tests
if __name__ == '__main__':
    obj = TestSuite();
    obj.RUN();