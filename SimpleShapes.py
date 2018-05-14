# Copyright (c) 2015 Ultimaker B.V.
# Cura is released under the terms of the LGPLv3 or higher.

from PyQt5.QtCore import QObject

from UM.Extension import Extension
from UM.Application import Application

from UM.Mesh.MeshBuilder import MeshBuilder
from UM.Operations.AddSceneNodeOperation import AddSceneNodeOperation
from cura.Scene.CuraSceneNode import CuraSceneNode
from cura.Scene.SliceableObjectDecorator import SliceableObjectDecorator
from cura.Scene.BuildPlateDecorator import BuildPlateDecorator

from UM.i18n import i18nCatalog
catalog = i18nCatalog("cura")

class SimpleShapes(Extension, QObject,):
    def __init__(self, parent = None):
        QObject.__init__(self, parent)
        Extension.__init__(self)

        self._controller = Application.getInstance().getController()

        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cube"), self.addCube)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cylinder"), self.addCylinder)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a sphere"), self.addSphere)

    def addCube(self):
        mesh = MeshBuilder()
        mesh.addCube(50,50,50)
        self._addShape(mesh.build())

    def addCylinder(self):
        mesh = MeshBuilder()
        mesh.addCube(50,50,50)
        self._addShape(mesh.build())

    def addSphere(self):
        mesh = MeshBuilder()
        mesh.addCube(50,50,50)
        self._addShape(mesh.build())

    def _addShape(self, meshData):
        node = CuraSceneNode()

        node.setMeshData(meshData)
        node.setSelectable(True)
        node.setName("SimpleShape" + str(id(meshData)))

        scene = self._controller.getScene()
        op = AddSceneNodeOperation(node, scene.getRoot())
        op.push()

        default_extruder_position = Application.getInstance().getMachineManager().defaultExtruderPosition
        default_extruder_id = Application.getInstance().getGlobalContainerStack().extruders[default_extruder_position].getId()
        node.callDecoration("setActiveExtruder", default_extruder_id)

        active_build_plate = Application.getInstance().getMultiBuildPlateModel().activeBuildPlate
        node.addDecorator(BuildPlateDecorator(active_build_plate))

        node.addDecorator(SliceableObjectDecorator())

        Application.getInstance().getController().getScene().sceneChanged.emit(node)