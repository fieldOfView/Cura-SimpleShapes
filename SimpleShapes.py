# Copyright (c) 2018 fieldOfView
# The SimpleShapes plugin is released under the terms of the AGPLv3 or higher.

from PyQt5.QtCore import QObject

import numpy
import math
import trimesh

from UM.Extension import Extension
from cura.CuraApplication import CuraApplication

from UM.Mesh.MeshData import MeshData, calculateNormalsFromIndexedVertices

from UM.Operations.AddSceneNodeOperation import AddSceneNodeOperation
from cura.Scene.CuraSceneNode import CuraSceneNode
from cura.Scene.SliceableObjectDecorator import SliceableObjectDecorator
from cura.Scene.BuildPlateDecorator import BuildPlateDecorator
from UM.Math.Vector import Vector

from UM.i18n import i18nCatalog
catalog = i18nCatalog("cura")

class SimpleShapes(Extension, QObject,):
    __size = 20
    

    def __init__(self, parent = None) -> None:
        QObject.__init__(self, parent)
        Extension.__init__(self)

        self._controller = CuraApplication.getInstance().getController()

        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cube"), self.addCube)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a cylinder"), self.addCylinder)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a sphere"), self.addSphere)
        self.addMenuItem(catalog.i18nc("@item:inmenu", "Add a Annulus"), self.addAnnulus)
       

    def addCube(self) -> None:
        self._addShape(self._toMeshData(trimesh.creation.box(extents = [self.__size, self.__size, self.__size])))

    def addCylinder(self) -> None:
        Rx = trimesh.transformations.rotation_matrix(math.radians(90), [1, 0, 0])
        self._addShape(self._toMeshData(trimesh.creation.cylinder(radius = self.__size / 2, height = self.__size, sections=90, transform = Rx )))
        
    def addCapsule(self) -> None:
        self._addShape(self._toMeshData(trimesh.creation.capsule(radius = self.__size / 2, height = self.__size, sections=90)))       

    def addAnnulus(self) -> None:
        #origin, xaxis, yaxis, zaxis = [0, 0, 0], [1, 0, 0], [0, 1, 0], [0, 0, 1]
        # S = trimesh.transformations.scale_matrix(20, origin)
        xaxis = [1, 0, 0]
        Rx = trimesh.transformations.rotation_matrix(math.radians(90), xaxis)
        self._addShape(self._toMeshData(trimesh.creation.annulus(r_min = self.__size / 4, r_max = self.__size / 2, height = self.__size, sections = 90, transform = Rx )))
        
    def addSphere(self) -> None:
        self._addShape(self._toMeshData(trimesh.creation.icosphere(radius = self.__size / 2)))
        
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

    def _addShape(self, mesh_data: MeshData) -> None:
        application = CuraApplication.getInstance()
        global_stack = application.getGlobalContainerStack()
        if not global_stack:
            return

        node = CuraSceneNode()

        node.setMeshData(mesh_data)
        node.setSelectable(True)
        node.setName("SimpleShape" + str(id(mesh_data)))

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