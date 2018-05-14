# Copyright (c) 2015 Ultimaker B.V.
# Cura is released under the terms of the LGPLv3 or higher.

from PyQt5.QtCore import QObject

import numpy

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

        # Can't use MeshBuilder.addCube() because that does not get per-vertex normals
        size = 50
        minSize = -size / 2
        maxSize = size / 2

        verts = [ #4 corners in 6 faces.
            [minSize, minSize, maxSize],
            [minSize, maxSize, maxSize],
            [maxSize, maxSize, maxSize],
            [maxSize, minSize, maxSize],

            [minSize, maxSize, minSize],
            [minSize, minSize, minSize],
            [maxSize, minSize, minSize],
            [maxSize, maxSize, minSize],

            [maxSize, minSize, minSize],
            [minSize, minSize, minSize],
            [minSize, minSize, maxSize],
            [maxSize, minSize, maxSize],

            [minSize, maxSize, minSize],
            [maxSize, maxSize, minSize],
            [maxSize, maxSize, maxSize],
            [minSize, maxSize, maxSize],

            [minSize, minSize, maxSize],
            [minSize, minSize, minSize],
            [minSize, maxSize, minSize],
            [minSize, maxSize, maxSize],

            [maxSize, minSize, minSize],
            [maxSize, minSize, maxSize],
            [maxSize, maxSize, maxSize],
            [maxSize, maxSize, minSize],
        ]
        mesh.setVertices(numpy.asarray(verts, dtype=numpy.float32))

        indices = [ #All 6 quads (12 triangles).
            [0, 2, 1],
            [0, 3, 2],

            [4, 6, 5],
            [4, 7, 6],

            [8, 10, 9],
            [8, 11, 10],

            [12, 14, 13],
            [12, 15, 14],

            [16, 18, 17],
            [16, 19, 18],

            [20, 22, 21],
            [20, 23, 22]
        ]
        mesh.setIndices(numpy.asarray(indices, dtype=numpy.int32))

        mesh.calculateNormals()
        self._addShape(mesh.build())

    def addCylinder(self):
        mesh = MeshBuilder()
        # TODO: construct cylinder
        self._addShape(mesh.build())

    def addSphere(self):
        mesh = MeshBuilder()
        # TODO: construct sphere
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