# Cura PostProcessingPlugin
# Author:   Dryw Filtiarn
# Date:     March 01, 2019

# Description:  This plugin will allow you to create calibration GCode for
#               testing various values for Junction Deviation on marlin-2.0.x
#               this plugin should be used alongside the attached test model
#               as can be found on Thingiverse https://www.thingiverse.com/thing:3463159

from ..Script import Script
from UM.Application import Application

class JunctionDeviationCalibration(Script):
    def __init__(self):
        super().__init__()

    def getSettingDataString(self):
        return """{
            "name": "Junction Deviation Calibration",
            "key": "JunctionDeviationCalibration",
            "metadata": {},
            "version": 2,
            "settings":
            {
                "start":
                {
                    "label": "Starting value",
                    "description": "The value for junction deviation the print will start at. A value of 0.02 is the Marlin default value (range 0.01 - 0.10, default 0.02)",
                    "type": "float",
                    "default_value": 0.02,
                    "minimum_value": 0.01,
                    "maximum_value": 0.10,
                    "minimum_value_warning": 0.01,
                    "maximum_value_warning": 0.10
                },
                "stepsize":
                {
                    "label": "Stepping size",
                    "description": "The increment with which junction deviation will be increased every 20 layers (range 0.005 - 0.100, default 0.010)",
                    "type": "float",
                    "default_value": 0.010,
                    "minimum_value": 0.005,
                    "maximum_value": 0.100,
                    "minimum_value_warning": 0.005,
                    "maximum_value_warning": 0.100
                },
                "lcdfeedback":
                {
                    "label": "Display details on LCD?",
                    "description": "This setting will insert M117 gcode instructions, to display current junction deviation value is being used.",
                    "type": "bool",
                    "default_value": true
                }
            }
        }"""
    
    def execute(self, data):
        uselcd = self.getSettingValueByKey("lcdfeedback")
        start = self.getSettingValueByKey("start")
        incr = self.getSettingValueByKey("stepsize")
        lps = 20

        lcd_gcode = "M117 Junction Dev - "
        jd_gcode = "M205 J"

        jd = start
        i = 0

        for layer in data:
            lay_idx = data.index(layer)
            
            lcd_out = lcd_gcode + ('%.3f' % jd)
            jd_out = jd_gcode + ('%.3f' % jd)

            lines = layer.split("\n")
            for line in lines:
                if line.startswith(";LAYER:"):
                    lin_idx = lines.index(line)

                    if i % lps == 0:
                        lines.insert(lin_idx + 1, jd_out)
                        if uselcd:
                            lines.insert(lin_idx + 2, lcd_out)
                        jd += incr
                            
                    i += 1
            
            result = "\n".join(lines)
            data[lay_idx] = result

        return data

        # for layer in data:
        #     display_text = lcd_text + str(i)
        #     layer_index = data.index(layer)
        #     lines = layer.split("\n")
        #     for line in lines:
        #         if line.startswith(";LAYER:"):
        #             line_index = lines.index(line)
        #             lines.insert(line_index + 1, display_text)
        #             i += 1
        #     final_lines = "\n".join(lines)
        #     data[layer_index] = final_lines
            
        # return data
