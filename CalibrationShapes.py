#-----------------------------------------------------------------------------------
# Part of the initial source code for primitive Shape (c) 2018 fieldOfView
# The CalibrationShapes plugin is released under the terms of the AGPLv3 or higher.
# Modifications 5@xes 2020-2021
#-----------------------------------------------------------------------------------
# V1.04  : https://github.com/5axes/Calibration-Shapes/issues/4
#     : https://github.com/5axes/Calibration-Shapes/issues/3
# V1.0.8 
#-----------------------------------------------------------------------------------
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, QUrl

# Imports from the python standard library to build the plugin functionality
import os
import re
import math
import numpy
import trimesh
import shutil
import platform
import sys
from shutil import copyfile

from UM.Extension import Extension
from UM.PluginRegistry import PluginRegistry
from UM.Application import Application
from cura.CuraApplication import CuraApplication

from UM.Mesh.MeshData import MeshData, calculateNormalsFromIndexedVertices
from UM.Resources import Resources
from UM.Operations.AddSceneNodeOperation import AddSceneNodeOperation
from cura.Scene.CuraSceneNode import CuraSceneNode
from cura.Scene.SliceableObjectDecorator import SliceableObjectDecorator
from cura.Scene.BuildPlateDecorator import BuildPlateDecorator

from UM.Logger import Logger
from UM.Message import Message

from UM.i18n import i18nCatalog
catalog = i18nCatalog("cura")

#This class is the extension and doubles as QObject to manage the qml    
class CalibrationShapes(QObject, Extension):
    #Create an api
    from cura.CuraApplication import CuraApplication
    api = CuraApplication.getInstance().getCuraAPI()
    
    # The QT signal, which signals an update for user information text
    userInfoTextChanged = pyqtSignal()
    userSizeChanged = pyqtSignal()
    
    def __init__(self, parent = None) -> None:
        QObject.__init__(self, parent)
        Extension.__init__(self)
        
        #Inzialize varables
        self.userText = ""
        self._continueDialog = None
        
        # set the preferences to store the default value
        self._preferences = CuraApplication.getInstance().getPreferences()
        self._preferences.addPreference("calibrationshapes/size", 20)
        
        # convert as float to avoid further issue
        self._size = float(self._preferences.getValue("calibrationshapes/size"))
        
        # Suggested solution from fieldOfView . Unfortunatly it doesn't works 
        # https://github.com/5axes/Calibration-Shapes/issues/1
        # Cura should be able to find the scripts from inside the plugin folder if the scripts are into a folder named resources
        Resources.addSearchPath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "resources"))
        
        self._controller = CuraApplication.getInstance().getController()
        self._message = None
        
        self.setMenuName(catalog.i18nc("@item:inmenu", "Part for calibration"))
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cube"), self.addCube)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cylinder"), self.addCylinder)
        # self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a sphere"), self.addSphere)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a tube"), self.addTube)
        self.addMenuItem("", lambda: None)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Calibration Cube"), self.addCalibrationCube)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a PLA TempTower"), self.addPLATempTower)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add an ABS TempTower"), self.addABSTempTower)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Retract Test"), self.addRetractTest)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Retract Tower"), self.addRetractTower)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Junction Deviation Tower"), self.addJunctionDeviationTower)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Bridge Test"), self.addBridgeTest)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Thin Wall Test"), self.addThinWall)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add an Overhang Test"), self.addOverhangTest)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Flow Test"), self.addFlowTest)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Tolerance Test"), self.addTolerance)
        self.addMenuItem(" ", lambda: None)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Copy Scripts"), self.copyScript)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Define default size"), self.defaultSize)
  
        #Inzialize varables
        self.userText = ""
        self._continueDialog = None
        
    # Define the default value pour the standard element
    def defaultSize(self) -> None:
    
        if self._continueDialog is None:
            self._continueDialog = self._createDialogue()
        self._continueDialog.show()
        #self.userSizeChanged.emit()
        
 
    #====User Input=====================================================================================================
    @pyqtProperty(str, notify= userSizeChanged)
    def sizeInput(self):
        return str(self._size)
        
    #The QT property, which is computed on demand from our userInfoText when the appropriate signal is emitted
    @pyqtProperty(str, notify= userInfoTextChanged)
    def userInfoText(self):
        return self.userText

    #This method builds the dialog from the qml file and registers this class
    #as the manager variable
    def _createDialogue(self):
        qml_file_path = os.path.join(PluginRegistry.getInstance().getPluginPath(self.getPluginId()), "CalibrationShapes.qml")
        component_with_context = Application.getInstance().createQmlComponent(qml_file_path, {"manager": self})
        return component_with_context

    def getSize(self) -> float:
    
        return self._size
        
    # is called when a key gets released in the size inputField (twice for some reason)
    @pyqtSlot(str)
    def sizeEntered(self, text):
        # Is the textfield empty ? Don't show a message then
        if text =="":
            #self.writeToLog("size-Textfield: Empty")
            self.userMessage("", "ok")
            return

        #Convert commas to points
        text = text.replace(",",".")

        #self.writeToLog("Size-Textfield: read value "+text)

        #Is the entered Text a number?
        try:
            float(text)
        except ValueError:
            self.userMessage("Entered size invalid: " + text,"wrong")
            return
        self._size = float(text)

        #Check if positive
        if self._size <= 0:
            self.userMessage("Size value must be positive !","wrong")
            self._size = 20
            return

        self.writeToLog("Set calibrationshapes/size printFromHeight to : " + text)
        self._preferences.setValue("calibrationshapes/size", self._size)
        
        #clear the message Field
        self.userMessage("", "ok")
 
    #===== Text Output ===================================================================================================
    #writes the message to the log, includes timestamp, length is fixed
    def writeToLog(self, str):
        Logger.log("d", "Source calibration shapes = %s", str)

    #Sends an user message to the Info Textfield, color depends on status (prioritized feedback)
    # Red wrong for Errors and Warnings
    # Grey for details and messages that aren't interesting for advanced users
    def userMessage(self, message, status):
        if status is "wrong":
            #Red
            self.userText = "<font color='#a00000'>" + message + "</font>"
        else:
            # Grey
            if status is "ok":
                self.userText = "<font color='#9fa4b0'>" + message + "</font>"
            else:
                self.writeToLog("Error: Invalid status: "+status)
                return
        #self.writeToLog("User Message: "+message)
        self.userInfoTextChanged.emit()
 
    # Copy the scripts to the right directory ( Temporary solution)
    def copyScript(self) -> None:
        File_List = ['RetractTower.py', 'SpeedTower.py', 'TempFanTower.py']
        
        plugPath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "resources")
        # Logger.log("d", "plugPath= %s", plugPath)
        
        stringMatch = re.split("plugins", plugPath)
        destPath = stringMatch[0] + "scripts"
        nbfile=0
        # LCopy the script
        for fl in File_List:
            script_definition_path = os.path.join(plugPath, fl)
            dest_definition_path = os.path.join(destPath, fl)
            # self.writeToLog("Dest_definition_path= "+dest_definition_path)
            if os.path.isfile(dest_definition_path)==False:
                copyfile(script_definition_path,dest_definition_path)
                nbfile+=1
        
        txt_Message =  str(nbfile) + " scripts copied in "
        txt_Message = txt_Message + os.path.join(destPath, "scripts")
        if nbfile > 0 :
            txt_Message = txt_Message + "\nYou must now restart Cura to see the scripts in the postprocessing script list"
          
        self._message = Message(catalog.i18nc("@info:status", txt_Message), title = catalog.i18nc("@title", "Calibration Shapes"))
        self._message.show()
    
    def addCalibrationCube(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "CalibrationCube.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))

    def addJunctionDeviationTower(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "JunctionDeviationTower.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
        
    def addPLATempTower(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "TempTowerPLA.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))

    def addABSTempTower(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "TempTowerABS.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
        
    def addRetractTest(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "RetractTest.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
 
    def addRetractTower(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "RetractTower.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
        
    def addBridgeTest(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "BridgeTest.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))

    def addThinWall(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "ThinWall.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
 
    def addOverhangTest(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "Overhang.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
 
    def addFlowTest(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "FlowTest.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))

    def addTolerance(self) -> None:
        model_definition_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models", "Tolerance.stl")
        self._addShape(self._toMeshData(trimesh.load(model_definition_path)))
        
    def addCube(self) -> None:
        Tz = trimesh.transformations.translation_matrix([0, self._size*0.5, 0])
        self._addShape(self._toMeshData(trimesh.creation.box(extents = [self._size, self._size, self._size], transform = Tz )))
        
    def addCylinder(self) -> None:
        Rx = trimesh.transformations.rotation_matrix(math.radians(90), [1, 0, 0])
        mesh = trimesh.creation.cylinder(radius = self._size / 2, height = self._size, sections=90, transform = Rx )
        mesh.apply_transform(trimesh.transformations.translation_matrix([0, self._size*0.5, 0]))
        self._addShape(self._toMeshData(mesh))

    def addTube(self) -> None:
        #origin, xaxis, yaxis, zaxis = [0, 0, 0], [1, 0, 0], [0, 1, 0], [0, 0, 1]
        # S = trimesh.transformations.scale_matrix(20, origin)
        xaxis = [1, 0, 0]
        Rx = trimesh.transformations.rotation_matrix(math.radians(90), xaxis)
        mesh = trimesh.creation.annulus(r_min = self._size / 4, r_max = self._size / 2, height = self._size, sections = 90, transform = Rx )
        mesh.apply_transform(trimesh.transformations.translation_matrix([0, self._size*0.5, 0]))
        self._addShape(self._toMeshData(mesh))
        
    # Sphere are not very usefull but I leave the code for the moment    
    def addSphere(self) -> None:
        # subdivisions (int) – How many times to subdivide the mesh. Note that the number of faces will grow as function of 4 ** subdivisions, so you probably want to keep this under ~5
        mesh = trimesh.creation.icosphere(subdivisions=4,radius = self._size / 2,)
        mesh.apply_transform(trimesh.transformations.translation_matrix([0, self._size*0.5, 0]))
        self._addShape(self._toMeshData(mesh))
    
    # Initial Source code from  fieldOfView
    def _toMeshData(self, tri_node: trimesh.base.Trimesh) -> MeshData:
        tri_faces = tri_node.faces
        tri_vertices = tri_node.vertices

        indices = []
        vertices = []

        index_count = 0
        face_count = 0
        for tri_face in tri_faces:
            face = []
            for tri_index in tri_face:
                vertices.append(tri_vertices[tri_index])
                face.append(index_count)
                index_count += 1
            indices.append(face)
            face_count += 1

        vertices = numpy.asarray(vertices, dtype=numpy.float32)
        indices = numpy.asarray(indices, dtype=numpy.int32)
        normals = calculateNormalsFromIndexedVertices(vertices, indices, face_count)

        mesh_data = MeshData(vertices=vertices, indices=indices, normals=normals)

        return mesh_data
        
    # Initial Source code from  fieldOfView
    def _addShape(self, mesh_data: MeshData) -> None:
        application = CuraApplication.getInstance()
        global_stack = application.getGlobalContainerStack()
        if not global_stack:
            return

        node = CuraSceneNode()

        node.setMeshData(mesh_data)
        node.setSelectable(True)
        node.setName("TestPart" + str(id(mesh_data)))

        scene = self._controller.getScene()
        op = AddSceneNodeOperation(node, scene.getRoot())
        op.push()

        default_extruder_position = application.getMachineManager().defaultExtruderPosition
        default_extruder_id = global_stack.extruders[default_extruder_position].getId()
        node.callDecoration("setActiveExtruder", default_extruder_id)

        active_build_plate = application.getMultiBuildPlateModel().activeBuildPlate
        node.addDecorator(BuildPlateDecorator(active_build_plate))

        node.addDecorator(SliceableObjectDecorator())

        application.getController().getScene().sceneChanged.emit(node)

