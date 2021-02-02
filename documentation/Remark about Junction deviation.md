# Remark about Junction deviation

Source of this remark : [here_is_why_you_should_disable_junction_deviation](https://www.reddit.com/r/3Dprinting/comments/dx8bdb/here_is_why_you_should_disable_junction_deviation/)   Author [ThePetroleum](https://www.reddit.com/user/ThePetroleum/)

In Marlin 2.0 Junction Deviation is enabled by default. Junction Deviation is an algorithm that calculates the cornering speed dependent on acceleration setting, corner angle and the Junction Deviation factor. It replaces classic a.k.a. archaic jerk which was only dependent on corner angle. The benefit of J.D. is that you set the factor only once and it calculates the corresponding corner speeds (jerk) based on your acceleration settings for each situation in a related ratio so you don't have to deal with all those jerk settings anymore. But that's also the huge disadvantage.

For optimal printing you want to use:

**low** acceleration and jerk (~ 500 mm/s2 ; 5 mm/s) on outer walls to minimize artifacts like ghosting

**medium** acceleration and jerk (~ 1000-2000 mm/s2 ; 10-15 mm/s) on inner walls and infill to optimize printing time

**high** acceleration and jerk (~ 3000+ mm/s2 ; 30+ mm/s) on travel moves to reduce stringing

Cura is the only slicer that supports acceleration and jerk settings based on this situation and that's why I highly recommend using Cura.

However, if you use common J.D. factors (0.01 - 0.03) to achieve decent surface quality and recalculate the jerk for travel moves using common values and the converted J.D. formula, you will get values like 10-15 mm/s cornering speed which is not enough and produces stringing. To prove that, I printed stringing test files using the same G-Code but with and without Junction Deviation enabled. The results speak for themselves.

![Issue with Junction Deviation in Marlin](https://preview.redd.it/4wgm69ffi2z31.jpg?width=4032&format=pjpg&auto=webp&s=fc2182bea9a37fd28e7ccabd8365aa44727ffa92)

To deactivate J.D. you need to comment out #define CLASSIC_JERK in Configuration.h