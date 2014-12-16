import ConfigParser
Config = ConfigParser.ConfigParser();

class write_module_settings:
    def __init__(self):
        self.out_file_name = "colour_check.ini"
        self.default_file_name  = "default_colour_check.ini"
        self.root_directory = "C:/Users/bryantay/Desktop/sample images/"
        
        # Variables
        #self.api__disable_figs = 1
        self.colorcheck__figsave = 1;
        self.colorcheck__closefigs = 1;
        self.colorcheck__resultsave = 1;
        self.colorcheck__save_answer = 'Yes'
        
        self.colorcheck__savecsv = 1
        self.colorcheck__savejson = 1
        self.colorcheck__savexml = 1

    def run(self):
        self.cfgfile = open(self.root_directory + self.out_file_name, 'wb')
        Config.read(self.root_directory + self.default_file_name)
        
        #Config.set('api','disable_figs',self.api__disable_figs)
        Config.set('colorcheck','figsave',self.colorcheck__figsave)
        Config.set('colorcheck','closefigs', self.colorcheck__closefigs);
        Config.set('colorcheck','resultsave', self.colorcheck__resultsave);
        Config.set('colorcheck','save_answer',self.colorcheck__save_answer);        
        Config.set('colorcheck','savecsv', self.colorcheck__savecsv);
        Config.set('colorcheck','savejson', self.colorcheck__savejson);
        Config.set('colorcheck','savexml',self.colorcheck__savexml);  
        
        Config.write(self.cfgfile)
        self.cfgfile.close()
        
if __name__ == "__main__":
    obj = write_module_settings()
    obj.run();