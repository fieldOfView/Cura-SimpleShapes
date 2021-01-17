# SimpleShapes

This plugin adds a menu to create some simple shapes to the scene (cube, cylinder, sphere, tube). The default size for all these shapes is 20 mm.

![menu Extensions Simple Shapes](./images/option.jpg)

Calibration part
--

You can also add standard test part / calibration :
- Calibration Cube
- PLA TempTower 220 - 180°C
- Retract Test part
- Retract Tower

Script part
--
A bunch of postprocessing Script are included into the plugin
- RetractTower.py
- SpeedTower.py
- TempFanTower.py

This script can be copied into the script directory via the function Copy Scripts


Using [Trimesh](https://github.com/mikedh/trimesh) function for simple shapes [creation](https://github.com/mikedh/trimesh/blob/master/trimesh/creation.py).
