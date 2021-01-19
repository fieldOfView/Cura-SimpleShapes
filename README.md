# Calibration Shapes

This plugin adds a menu to create some simple shapes to the scene (cube, cylinder, sphere, tube) used most of the time to create some fast test parts. The default size for all these shapes is 20 mm.

![menu Extensions Calibration Shapes](./images/menu.jpg)

Calibration part
--

You can also add standard test part / calibration :
- [Calibration Cube XYZ](./models/CalibrationCube.stl)
- [PLA TempTower 220 - 180°C](./models/TempTower.stl)
- [Retract Test part](./models/RetractTest.stl)
- [Retract Tower](./models/RetractTower.stl)
- [Bridge Spiral test](./models/BridgeTest.stl)
- [Thin Wall Test](./models/ThinWall.stl)
- [Overhang Test](./models/Overhang.stl)

All the parts have been designed via OpenSCAD. OpenSCAD can be downloaded [here](http://www.openscad.org/downloads.html)

Postprocessing Scripts
--

Several postprocessing Scripts are included into the plugin to help the user to generate automaticaly the differents Towers.

- [RetractTower.py](./resources/RetractTower.py)
- [SpeedTower.py](./resources/SpeedTower.py)
- [TempFanTower.py](./resources/TempFanTower.py)

These scripts can be copied into the scripts directory via the function **Copy Scripts**


Using [Trimesh](https://github.com/mikedh/trimesh) function for simple shapes [creation](https://github.com/mikedh/trimesh/blob/master/trimesh/creation.py).

Define default size
--

Withe the function **Define default size** gives you the possibility to change the default size for the standard primitives (cube/cylinder/sphere/tube).

![define default size](./images/size.jpg)
