#Postprocessing scripts

Several postprocessing scripts are included into the plugin to help the user to generate automaticaly the differents Towers.

- [RetractTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/resources/RetractTower.py)
- [SpeedTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/resources/SpeedTower.py)
- [TempFanTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/resources/TempFanTower.py)

These scripts can be copied into the scripts directory via the function **Copy Scripts**

After the next start the scripts must be visible in the Postprocessing scripts.

![Adding script](https://github.com/5axes/Calibration-Shapes/blob/master/images/plugins.jpg)


TempFanTower.py
-----

Description:  postprocessing-script to easily use an temptower and not use 10 changeAtZ-scripts

 The default values are for this temptower PLA model [PLA TempTower 220 - 180°C](https://github.com/5axes/Calibration-Shapes/blob/master/models/TempTowerPLA.stl)

- Possibility to define also a Fan Tower , Fan percentage speed indicate with semi-colon as seprator

![TempFanTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/images/tempfan.jpg)


SpeedTower.py
-----
Description:  postprocessing-script to easily define a Speed Tower.

Three options :

           - Jerk   :  Speed variation (M204 S) 

           - Acceleration :  Acceleration variation (M205 X Y) 

           - Junction Deviation :  Junction Deviation variation (M205 J) 

![SpeedTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/images/speedtower.jpg)


RetractTower.py
-----

Description:  postprocessing-script to easily create a Retract Tower

Two options :

    - Speed   :  Speed variation
	
    - Retract :  Distance retract variation

![RetractTower.py](https://github.com/5axes/Calibration-Shapes/blob/master/images/retract-tower.jpg)

