# Calibration Shapes

This plugin adds a menu to create some simple shapes to the scene (cube, cylinder, sphere, tube) used most of the time to create some fast test parts. The default size for all these shapes is 20 mm.

![menu Extensions Calibration Shapes](https://github.com/5axes/Calibration-Shapes/blob/master/images/menu.jpg)

Calibration part
--

You can also load standard test  / calibration  part :
- [Calibration Cube XYZ](https://github.com/5axes/Calibration-Shapes/blob/master/models/CalibrationCube.stl)
- [PLA TempTower 220 - 180°C](https://github.com/5axes/Calibration-Shapes/blob/master/models/TempTowerPLA.stl)
- [ABS TempTower 250 - 210°C](https://github.com/5axes/Calibration-Shapes/blob/master/models/TempTowerABS.stl)
- [Retract Test part](https://github.com/5axes/Calibration-Shapes/blob/master/models/RetractTest.stl)
- [Retract Tower](https://github.com/5axes/Calibration-Shapes/blob/master/models/RetractTower.stl)
- [Junction Deviation Tower](https://github.com/5axes/Calibration-Shapes/blob/master/models/JunctionDeviationTower.stl)
- [Bridge Spiral test](https://github.com/5axes/Calibration-Shapes/blob/master/models/BridgeTest.stl)
- [Thin Wall Test](https://github.com/5axes/Calibration-Shapes/blob/master/models/ThinWall.stl)
- [Overhang Test](https://github.com/5axes/Calibration-Shapes/blob/master/models/Overhang.stl)
- [Flow Test](https://github.com/5axes/Calibration-Shapes/blob/master/models/FlowTest.stl)
- [Tolerance Test](https://github.com/5axes/Calibration-Shapes/blob/master/models/Tolerance.stl)

All the parts have been designed via OpenSCAD. OpenSCAD can be downloaded [here](http://www.openscad.org/downloads.html)

Postprocessing Scripts
--

Several postprocessing Scripts are included into the plugin to help the user to generate automaticaly the differents Towers.

- [RetractTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/resources/RetractTower.py)
- [SpeedTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/resources/SpeedTower.py)
- [TempFanTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/resources/TempFanTower.py)

These scripts can be copied into the scripts directory via the function **Copy Scripts**

Standard test part
--

- A cube
- A cylinder
- A sphere
- A tube


Define default size
--

The function **Define default size** gives you the possibility to change the default size for the standard primitives (cube/cylinder/sphere/tube).

![define default size](https://github.com/5axes/Calibration-Shapes/blob/master/images/size.jpg)

Using [Trimesh](https://github.com/mikedh/trimesh) function for simple shapes [creation](https://github.com/mikedh/trimesh/blob/master/trimesh/creation.py).
