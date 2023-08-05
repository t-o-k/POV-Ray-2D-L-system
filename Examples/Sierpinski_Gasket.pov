// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-2D-L-system

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

#include "../L-system_2D.inc"

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
// Figure 1.10b on page 11


// F I R S T   T R A N S F O R M

// Variables
#declare Rules[asc("L")] = "R+L+R";
#declare Rules[asc("R")] = "L-R-L";

#declare Axiom = "R";

#declare Iterations = 7;
#declare L_string = L_Transform(Axiom, Rules, Iterations);


// S E C O N D   T R A N S F O R M

// Variables
#declare Rules[asc("L")] = "F";
#declare Rules[asc("R")] = "F";

#declare Axiom = L_string;

#declare Iterations = 1;
#declare L_string = L_Transform(Axiom, Rules, Iterations);


#declare StackSize = 1;
#declare pStart = <-64, -56,  0>;
#declare InitialLength = 1.0;
#declare InitialRadius = 0.2;
#declare InitialHeading = radians(+60);
#declare InitialTurnAngle = radians(-60);

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
    pigment { color srgb <0.39, 0.58, 0.93> }

}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.20, 0.20, 0.20> }

#declare Scale = 42;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
