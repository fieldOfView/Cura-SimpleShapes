# Calibration Cube XYZ

[Calibration Cube XYZ](https://github.com/5axes/Calibration-Shapes/blob/master/models/CalibrationCube.stl)

This model allow you to print a calibration cube (The name can be a source of error. More than a calibration, it is a calibration control which is made with this model.)  It's useful to see if your printer is accurate and calibrate some settings. 

![CalibrationCube](https://github.com/5axes/Calibration-Shapes/blob/master/images/CalibrationCube.jpg)

Default size of the standard cube is 20mm.

Licence for the standard calibration cube: [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/legalcode), iDig3Dprinting [https://www.thingiverse.com/thing:1278865](https://www.thingiverse.com/thing:1278865)


## Printing Conditions
     - Nozzle Size : 0.4
     - Layer Height : 0.2
     - Initial Layer Height : 0.2
     - Line Width : 0.4
     - Wall Line Count : 3
     - Top/Bottom Thickness : 0.8 mm
     - Infill Density : 8%


**Printing Time = 30mn**

### Dimensional accuracy
You have to print two cubes, with different sizes. If the dimensional inaccuracy scale with the size of the cubes, then it's the steps/mm of your steppers that needs some adjustments (note: if it's the case, you should also adjust the flow, and maybe redo some calibrations if the change is important). If it doesn't scale, you can correct it by adjusting your *Horizontal Expansion*.

### Infill/perimeter overlap
This test is perform to see if the pattern of the infill can be seen on the perimeters. Try to reduce it as low as you can but check the *Top surface skin*, as it can create artifacts if it's too low (Also knows as Pillowing). 

## Material Flow
This test is about to see if a distance can be seen between Wall line count. If you don't have a good overlap of the lines , it's certainly a problem with your *Flow*. 

## Ringing 
Ringing (sometimes called "ghosting") is an effect where ripples appear on otherwise flat surfaces near small details on that surface. The ripples start occurring just after printing the small details. As the vibrations are caused by accelerating the print head, the improvements can be achived by reducing those accelerations.

- Reducing the maximum printing speed reduces the duration of the accelerations.
- Reducing the acceleration rate directly reduces the acceleration and will reduce the strength of the vibrations.


