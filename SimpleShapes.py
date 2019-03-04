# Copyright (c) 2018 fieldOfView
# The SimpleShapes plugin is released under the terms of the AGPLv3 or higher.

from PyQt5.QtCore import QObject

import numpy
import math
import trimesh

from UM.Extension import Extension
from UM.Application import Application

from UM.Mesh.MeshData import MeshData, calculateNormalsFromIndexedVertices

from UM.Operations.AddSceneNodeOperation import AddSceneNodeOperation
from cura.Scene.CuraSceneNode import CuraSceneNode
from cura.Scene.SliceableObjectDecorator import SliceableObjectDecorator
from cura.Scene.BuildPlateDecorator import BuildPlateDecorator

from UM.i18n import i18nCatalog
catalog = i18nCatalog("cura")

class SimpleShapes(Extension, QObject,):
    __size = 20

    def __init__(self, parent = None):
        QObject.__init__(self, parent)
        Extension.__init__(self)

        self._controller = Application.getInstance().getController()

        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cube"), self.addCube)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cylinder"), self.addCylinder)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a sphere"), self.addSphere)

    def addCube(self):
        self._addShape(self._toMeshData(trimesh.primitives.Box(extents = [self.__size, self.__size, self.__size])))

    def addCylinder(self):
        self._addShape(self._toMeshData(trimesh.primitives.Cylinder(radius = self.__size / 2, height = self.__size)))

    def addSphere(self):
        self._addShape(self._toMeshData(trimesh.primitives.Sphere(radius = self.__size / 2)))

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