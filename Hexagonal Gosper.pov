// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-L-system

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

// L-system
// https://en.wikipedia.org/wiki/L-system

// Dragon_curve
// https://en.wikipedia.org/wiki/Dragon_curve

// Heighway Dragon Tiling
// https://larryriddle.agnesscott.org/ifs/heighway/heighwayTiling.htm

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

#include "L-system_03.inc"

global_settings { assumed_gamma 1.0 }

default {
    texture {
        pigment { color rgb <1, 1, 1> }
        finish {
            diffuse 0
            emission color rgb <1, 1, 1>
        }
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

// Hexagonal Gosper by Paul Bourke
// http://paulbourke.net/fractals/lsys/

// Constant
#declare Rules[asc("F")] = "F";

// Variables
#declare Rules[asc("X")] = "X+YF++YF-FX--FXFX-YF+";
#declare Rules[asc("Y")] = "-FX+YFYF++YF+FX--FX-Y";

#declare Axiom = "XF";

InsertNoChangeFunctions(Functions, "XY")

#declare Iterations = 4;
#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare StackSize = 1;
#declare pStart = <+18, -54,  0>;
#declare StartLength = 2.0;
#declare StartRadius = 0.4;
#declare StartHeading = radians(0);
#declare StartTurnAngle = radians(-60);

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

union {
    L_Draw(
        Functions,                                 
        L_string,
        StackSize,
        pStart,
        StartLength,
        StartRadius,
        StartHeading,
        StartTurnAngle,
        true,
        true
    )
    pigment { color srgb <0.98, 0.67, 0.19> }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.00, 0.19, 0.29> }

#declare Scale = 48;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
