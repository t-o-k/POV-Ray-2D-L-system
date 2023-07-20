# POV-Ray-L-system
[POV-Ray](http://www.povray.org) v3.7 include file with a library for a simple Lindenmayer system

https://en.wikipedia.org/wiki/L-system

Note that this library is work in progress, so everything has not been tested and anything may suddenly change.

#### Meaning of symbols/characters in rules arrays:
```
F    Move forward by length drawing a cylinder
f    Move forward by length without drawing
|    Reverse direction (ie: turn by pi radians)
+    Turn clockwise by turning angle (in radians)
-    Turn counterclockwise by turning angle (in radians)
&    Swap the meaning of + and -
[    Push current drawing state onto stack
]    Pop current drawing state from the stack
>    Increase the cylinder length by multiplying by a scale factor and/or adding an increment
<    Decrease the cylinder length by subtracting an increment and/or dividing by a scale factor
#    Increase the cylinder radius by multiplying by a scale factor and/or adding an increment
!    Decrease the cylinder radius by subtracting an increment and/or dividing by a scale factor
(    Increase the turning angle by multiplying by a scale factor and/or adding an increment
)    Decrease the turning angle by subtracting an increment and/or dividing by a scale factor
@    Draw a sphere with cylinder radius
```

The following macros must be called before the L_Transform() macro in order to enable use of the symbols listed before them:

```
# !    InsertRadiusFunctions()
> <    InsertLengthFunctions()
( )    InsertAngleFunctions()
```

Also see Paul Bourke "L-System User Notes" here:

http://paulbourke.net/fractals/lsys
