// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-2D-L-system

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

#include "L-system_2D.inc"

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

// Bush by Paul Bourke
// http://paulbourke.net/fractals/lsys/

// Variable
#declare Rules[asc("F")] = "FF+[+F-F-F]-[-F+F+F]";

#declare Axiom = "F";
#declare Iterations = 4;
#declare StackSize = 1*Iterations;

#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare pStart = <-85, -20,  0>;
#declare StartLength = 3.0;
#declare StartHeading = radians(0.0);
#declare StartTurnAngle = radians(-22.5);
#declare StartRadiusSpheres = 0.30;
#declare StartRadiusCylinders = 0.15;

union {
    L_DrawSpheres(
        Functions,
        L_string,
        StackSize,
        pStart,
        StartLength,
        StartRadiusSpheres,
        StartHeading,
        StartTurnAngle
    )
    pigment { color rgb <1.00, 0.30, 0.10> }
}

union {
    L_DrawCylinders(
        Functions,
        L_string,
        StackSize,
        pStart,
        StartLength,
        StartRadiusCylinders,
        StartHeading,
        StartTurnAngle
    )
    pigment { color rgb <0.20, 0.60, 1.00> }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color rgb <0.00, 0.05, 0.10> }

#declare Scale = 50;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
