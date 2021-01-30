# Calibration Shapes

This plugin adds a menu to create some simple shapes to the scene (cube, cylinder, sphere, tube) used most of the time to create some fast test parts. The default size for all these shapes is 20 mm.

![menu Extensions Calibration Shapes](./images/menu.jpg)

Calibration part
--

You can also load standard test  / calibration  part :
- [Calibration Cube XYZ](./models/CalibrationCube.stl)
- [PLA TempTower 220 - 180°C](./models/TempTowerPLA.stl)
- [ABS TempTower 250 - 210°C](./models/TempTowerABS.stl)
- [Retract Tower](./models/RetractTower.stl)
- [Junction Deviation Tower](./models/JunctionDeviationTower.stl)
- [Retract Test part](./models/RetractTest.stl)
- [Bridge Spiral test](./models/BridgeTest.stl)
- [Thin Wall Test](./models/ThinWall.stl)
- [Overhang Test](./models/Overhang.stl)
- [Flow Test](./models/FlowTest.stl)

All the parts have been designed via OpenSCAD. OpenSCAD can be downloaded [here](http://www.openscad.org/downloads.html)

Define default size
--

The function **Define default size** gives you the possibility to change the default size for the standard primitives (cube/cylinder/sphere/tube).

![define default size](./images/size.jpg)

Using [Trimesh](https://github.com/mikedh/trimesh) function for simple shapes [creation](https://github.com/mikedh/trimesh/blob/master/trimesh/creation.py).


Cura-Postprocessing-Scripts
--
Several postprocessing Scripts are included into the plugin to help the user to generate automaticaly the differents Towers.

- [RetractTower.py](./resources/RetractTower.py)
- [SpeedTower.py](./resources/SpeedTower.py)
- [TempFanTower.py](./resources/TempFanTower.py)

These scripts can be copied into the scripts directory via the function **Copy Scripts**

After the next start the scripts must be visible in the Postprocessing scripts.

![Adding script](./images/plugins.jpg)


SpeedTower.py
-----
Description:  postprocessing-script to easily define a Speed Tower.

Three options :

    - Jerk   :  Speed variation (M204 S) 
	
    - Acceleration :  Acceleration variation (M205 X Y) 
    
    - Junction Deviation :  Junction Deviation variation (M205 J) 

![SpeedTower.py](./images/speedtower.jpg)


TempFanTower.py
-----

Description:  postprocessing-script to easily use an temptower and not use 10 changeAtZ-scripts

 The default values are for this temptower PLA model [PLA TempTower 220 - 180°C](./models/TempTowerPLA.stl)
- Temp Tower PLA de 220 à 180
- Possibility to define also a Fan Tower , Fan percentage speed indicate with semi-colon as seprator

![TempFanTower.py](./images/tempfan.jpg)


RetractTower.py
-----

Description:  postprocessing-script to easily create a Retract Tower

Two options :

    - Speed   :  Speed variation
	
    - Retract :  Distance retract variation

![RetractTower.py](./images/retract-tower.jpg)


