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

// Sort of Pythagoras tree by Paul Bourke
// http://paulbourke.net/fractals/lsys/

#declare GoldenRatio = (1 + sqrt(5))/2;

// Constant
#declare Rules[asc("F")] = "F";

// Variable
#declare Rules[asc("X")] = ">[-FX]+FX";

#declare Axiom = "FX";

InsertNoChangeFunctions(Functions, "X")
InsertLengthFunctions(Functions, 1/GoldenRatio, 0)

#declare Iterations = 9;
#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare StackSize = 1*Iterations;
#declare pStart = < 0, -12,  0>;
#declare InitialLength = 10.0;
#declare InitialRadius = 0.04;
#declare InitialHeading = radians(+90);
#declare InitialTurnAngle = radians(+40);

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

union {
    L_Draw(
        Functions,
        L_string,
        StackSize,
        pStart,
        InitialLength,
        InitialRadius,
        InitialHeading,
        InitialTurnAngle,
        true,
        true
    )
    pigment { color srgb <0.99, 0.75, 0.29> }

}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.00, 0.19, 0.29> }

#declare Scale = 10;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
