# Initial Copyright (c)2021 5@xes
# The SimpleShapes plugin is released under the terms of the AGPLv3 or higher.

from . import CalibrationShapes

def getMetaData():
    return {}

def register(app):
    return {"extension": CalibrationShapes.CalibrationShapes()}
