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

// Dragon_curve
// https://en.wikipedia.org/wiki/Dragon_curve

// Heighway Dragon Tiling
// https://larryriddle.agnesscott.org/ifs/heighway/heighwayTiling.htm

// Constant
#declare Rules[asc("F")] = "F";

// Variables
#declare Rules[asc("X")] = "X+YF";
#declare Rules[asc("Y")] = "FX-Y";

InsertNoChangeFunctions(Functions, "XY")

#declare Axiom = "FX";
#declare Iterations = 10;
#declare StackSize = 0*Iterations;

#declare L_string = L_Transform(Axiom, Rules, Iterations);

#declare pStart = <0, 0, 0>;
#declare StartLength = 2.0;
#declare StartTurnAngle = radians(+90);
#declare StartRadius = 0.2;

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare Colors =
    array[4] {
        color srgb <0.84, 0.16, 0.16>,
        color srgb <0.99, 0.75, 0.29>,
        color srgb <0.97, 0.50, 0.00>,
        color srgb <0.92, 0.89, 0.72>
    }
;

union {
    #for (I, 0, 3)
        #declare StartHeading = radians(I*90);
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
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

background { color srgb <0.00, 0.19, 0.29> }

#declare Scale = 56;

camera {
    orthographic
    location -100*z
    direction z
    right Scale*4*x
    up Scale*3*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
