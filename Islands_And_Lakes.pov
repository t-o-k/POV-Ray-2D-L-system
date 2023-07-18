// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-L-system

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

// Przemyslaw Prusinkiewicz & Aristid Lindenmayer
// "The Algorithmic Beauty of Plants"
// Figure 1.8 on page 9

// Variables
#declare Rules[asc("F")] = "F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF";
#declare Rules[asc("f")] = "ffffff";

#declare Axiom = "F+F+F+F";

#declare Iterations = 2;
#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare StackSize = 1;
#declare InitialLength = 1.0;
#declare InitialHeading = radians(0);
#declare InitialTurnAngle = radians(+90);

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare pStart = <-18, +18,  0>;
#declare InitialRadius = 0.1;

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
    pigment { color srgb <0.78, 0.00, 0.00> }
}

#declare pStart = <-18, +18, +1>;
#declare InitialRadius = 0.2;

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
    pigment { color srgb <1.00, 1.00, 1.00> }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.30, 0.30, 0.30> }

#declare Scale = 24;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
