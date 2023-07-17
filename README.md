# POV-Ray-L-system
[POV-Ray](http://www.povray.org) v3.7 include file with a library for a simple Lindenmayer system

https://en.wikipedia.org/wiki/L-system

Note that this library is work in progress, so everything has not been tested and anything may suddenly change.

#### Meaning of symbols/characters in rules arrays:
```
F    Move forward by length drawing a cylinder
f    Move forward by length without drawing
+    Turn clockwise by turning angle (in radians)
-    Turn counterclockwise by turning angle (in radians)
|    Reverse direction (ie: turn by pi radians)
[    Push current drawing state onto stack
]    Pop current drawing state from the stack
#    Increment the cylinder radius by radius increment
!    Decrement the cylinder radius by radius increment
@    Draw a sphere with cylinder radius
>    Multiply the cylinder length by the length scale factor
<    Divide the cylinder length by the length scale factor
&    Swap the meaning of + and -
(    Decrement turning angle by turning angle increment
)    Increment turning angle by turning angle increment
```

Also see Paul Bourke "L-System User Notes" here:

http://paulbourke.net/fractals/lsys
