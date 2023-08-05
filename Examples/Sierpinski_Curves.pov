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

// Wikipedia article
// "Sierpinski curve"
// https://en.wikipedia.org/wiki/Sierpi%C5%84ski_curve

// Sierpinski Curve by Chris Wallace
// "Does there exist an L-system for the sierpinski curve"
// https://math.stackexchange.com/a/3419942

// Constant
#declare Rules[asc("F")] = "F";

// Variable
#declare Rules[asc("X")] = "XF+F+XF--F--XF+F+X";

InsertNoChangeFunctions(Functions, "X")

#declare Axiom = "F--XF--F--XF";

#declare StackSize = 0;

#declare StartLength = 1.0;
#declare StartHeading = radians(0*90);
#declare StartTurnAngle = radians(+45);

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare Colors =
    array[4] {
        color srgb <0.72, 0.89, 0.92>  // 3
        color srgb <0.29, 0.75, 0.99>, // 2
        color srgb <0.00, 0.50, 0.97>, // 1
        color srgb <0.16, 0.16, 0.84>, // 0
    }
;

#for (I, 0, 3)
    #declare Iterations = I + 1;
    #declare L_string = L_Transform(Axiom, Rules, Iterations);
    #declare pStart = < 0, -26, 3 - I>;
    #declare StartRadius = (4 - I)*0.1;
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
        pigment { color Colors[I] }
    }
#end // for

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.29, 0.00, 0.19> }

#declare Scale = 20;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
