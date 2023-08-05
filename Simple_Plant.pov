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

// Przemyslaw Prusinkiewicz & Aristid Lindenmayer
// "The Algorithmic Beauty of Plants"
// Figure 1.24f on page 25

// Variables
#declare Rules[asc("F")] = "FF";
#declare Rules[asc("X")] = "F-[[X]+X]+F[+FX]-X";

InsertNoChangeFunctions(Functions, "X")

#declare Axiom = "X";

#declare Iterations = 5;
#declare StackSize = 2*Iterations;
#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare pStart = < 0, -40,  0>;
#declare InitialLength = 1.0;
#declare InitialRadius = 0.1;
#declare InitialHeading = radians(+90.0);
#declare InitialTurnAngle = radians(+22.5);

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

#declare Scale = 32;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
