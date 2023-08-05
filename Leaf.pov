// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-2D-L-system

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

#include "L-system.inc"

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

// Leaf by Paul Bourke
// http://paulbourke.net/fractals/lsys/

// Variables
#declare Rules[asc("F")] = ">F<";
#declare Rules[asc("a")] = "F[+x]Fb";
#declare Rules[asc("b")] = "F[-y]Fa";
#declare Rules[asc("x")] = "a";
#declare Rules[asc("y")] = "b";

#declare Axiom = "a";

InsertNoChangeFunctions(Functions, "abxy")
InsertLengthFunctions(Functions, 1.36, 0.00)

#declare Iterations = 14;
#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare StackSize = 1*Iterations;
#declare pStart = < 0, -200,  0>;
#declare InitialLength = 1.0;
#declare InitialRadius = 0.5;
#declare InitialHeading = radians(+90);
#declare InitialTurnAngle = radians(+45);

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

union {
    L_DrawCylinders(
        Functions,
        L_string,
        StackSize,
        pStart,
        InitialLength,
        InitialRadius,
        InitialHeading,
        InitialTurnAngle
    )
    pigment { color srgb <0.99, 0.75, 0.29> }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.00, 0.19, 0.29> }

#declare Scale = 160;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
