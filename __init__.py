# Copyright (c) 2018 fieldOfView
# The SimpleShapes plugin is released under the terms of the AGPLv3 or higher.

from . import SimpleShapes

def getMetaData():
    return {}

def register(app):
    return {"extension": SimpleShapes.SimpleShapes()}
