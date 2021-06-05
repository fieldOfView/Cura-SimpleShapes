#------------------------------------------------------------------------------------------------------------------------------------
#
# Cura PostProcessing Script
# Author:   5axes
# Date:     Juin 06, 2021
#
# Description:  postprocessing script to slow down speed on first Skirt geometry
#
#------------------------------------------------------------------------------------------------------------------------------------
#
#   Version 1.0 06/06/2021
#
#------------------------------------------------------------------------------------------------------------------------------------

from ..Script import Script
from UM.Application import Application
from UM.Logger import Logger
import re #To perform the search

__version__ = '1.0'

class Section(Enum):
    """Enum for section type."""

    NOTHING = 0
    SKIRT = 1
    INNER_WALL = 2
    OUTER_WALL = 3
    INFILL = 4
    SKIN = 5
    SKIN2 = 6

def is_begin_layer_line(line: str) -> bool:
    """Check if current line is the start of a layer section.

    Args:
        line (str): Gcode line

    Returns:
        bool: True if the line is the start of a layer section
    """
    return line.startswith(";LAYER:")

def is_retract_line(line: str) -> bool:
    """Check if current line is a retract segment.

    Args:
        line (str): Gcode line

    Returns:
        bool: True if the line is a retract segment
    """
    return "G1" in line and "F" in line and "E" in line and not "X" in line and not "Y" in line and not "Z" in line
    
def is_extrusion_line(line: str) -> bool:
    """Check if current line is a standard printing segment.

    Args:
        line (str): Gcode line

    Returns:
        bool: True if the line is a standard printing segment
    """
    return "G1" in line and "X" in line and "Y" in line and "E" in line

def is_not_extrusion_line(line: str) -> bool:
    """Check if current line is a rapid movement segment.

    Args:
        line (str): Gcode line

    Returns:
        bool: True if the line is a standard printing segment
    """
    return "G0" in line and "X" in line and "Y" in line and not "E" in line

def is_relative_instruction_line(line: str) -> bool:
    """Check if current line contain a M83 / G91 instruction

    Args:
        line (str): Gcode line

    Returns:
        bool: True contain a M83 / G91 instruction
    """
    return "G91" in line or "M83" in line

def is_not_relative_instruction_line(line: str) -> bool:
    """Check if current line contain a M82 / G90 instruction

    Args:
        line (str): Gcode line

    Returns:
        bool: True contain a M82 / G90 instruction
    """
    return "G90" in line or "M82" in line

def is_reset_extruder_line(line: str) -> bool:
    """Check if current line contain a G92 E0

    Args:
        line (str): Gcode line

    Returns:
        bool: True contain a G92 E0 instruction
    """
    return "G92" in line and "E0" in line
    
class SlowSkirt(Script):
    def __init__(self):
        super().__init__()

    def getSettingDataString(self):
        return """{
            "name": "SlowSkirt",
            "key": "SlowSkirt",
            "metadata": {},
            "version": 2,
            "settings":
            {
                "slowreduction":
                {
                    "label": "Slow Reduction",
                    "description": "Percentage reduction on Skirt geometry",
                    "type": "int",
                    "default_value": 50
                    "minimum_value": 1,
                    "maximum_value": 200                   
                },
                "lcdfeedback":
                {
                    "label": "Display details on LCD",
                    "description": "This setting will insert M117 gcode instructions, to display current modification in the G-Code is being used.",
                    "type": "bool",
                    "default_value": true
                }                
            }
        }"""

    def execute(self, data):

        UseLcd = self.getSettingValueByKey("lcdfeedback")
        SlowReduction = int(self.getSettingValueByKey("slowreduction"))

        CurrentValue = 0
        Idl = 0
        
        for layer in data:
            layer_index = data.index(layer)
            
            lines = layer.split("\n")
            for line in lines:                  
               
                if line.startswith(";TYPE:SKIRT"):
                    line_index = lines.index(line)
                    lcd_gcode = "M117 Slow Reduction {}".format(int(SlowReduction))
                    if UseLcd == True :               
                        lines.insert(line_index + 1, lcd_gcode) 
                    Idl=1

                if Idl=1 :
                    if is_extrusion_line(line):
                        searchF = re.search(r"F([-+]?\d*\.?\d*)", line)
                        if searchF:
                            save_f=float(searchF.group(1)) 
                            Logger.log('d', 'Save_f : {}'.format(save_f))
                                             
            
            result = "\n".join(lines)
            data[layer_index] = result

        return data
