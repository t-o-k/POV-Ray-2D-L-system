// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-2D-L-system

Copyright (c) 2023 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare MaxNoOfSymbols = 128; // No of characters in the ASCII table

#declare Rules = array[MaxNoOfSymbols];
#for (I, 0, MaxNoOfSymbols - 1)
    #declare Rules[I] = "";
#end // for

// Constants
#declare Rules[asc("[")] = "[";
#declare Rules[asc("]")] = "]";
#declare Rules[asc("|")] = "|";
#declare Rules[asc("-")] = "-";
#declare Rules[asc("+")] = "+";
#declare Rules[asc("#")] = "#";
#declare Rules[asc("!")] = "!";
#declare Rules[asc("<")] = "<";
#declare Rules[asc(">")] = ">";
#declare Rules[asc("(")] = "(";
#declare Rules[asc(")")] = ")";
#declare Rules[asc("&")] = "&";

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare I_X = 0; // Position coordinate X
#declare I_Y = 1; // Position coordinate y
#declare I_Z = 2; // Position coordinate Z
#declare I_L = 3; // Length
#declare I_R = 4; // Radius
#declare I_H = 5; // Heading
#declare I_A = 6; // Turn Angle
#declare I_S = 7; // Swap turn directions

#declare NoChangeFunctions = array[8];
#declare NoChangeFunctions[I_X] = function(x, y, z, l, r, h, a, s) { x };
#declare NoChangeFunctions[I_Y] = function(x, y, z, l, r, h, a, s) { y };
#declare NoChangeFunctions[I_Z] = function(x, y, z, l, r, h, a, s) { z };
#declare NoChangeFunctions[I_L] = function(x, y, z, l, r, h, a, s) { l };
#declare NoChangeFunctions[I_R] = function(x, y, z, l, r, h, a, s) { r };
#declare NoChangeFunctions[I_H] = function(x, y, z, l, r, h, a, s) { h };
#declare NoChangeFunctions[I_A] = function(x, y, z, l, r, h, a, s) { a };
#declare NoChangeFunctions[I_S] = function(x, y, z, l, r, h, a, s) { s };


#macro InsertBasicFunctions(Fns)

    #local S = asc("F"); // Move forward while "drawing"
    #declare Fns[S][I_X] = function(x, y, z, l, r, h, a, s) { x + l*cos(h) };
    #declare Fns[S][I_Y] = function(x, y, z, l, r, h, a, s) { y + l*sin(h) };
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("f"); // Move forward while not "drawing"
    #declare Fns[S][I_X] = function(x, y, z, l, r, h, a, s) { x + l*cos(h) };
    #declare Fns[S][I_Y] = function(x, y, z, l, r, h, a, s) { y + l*sin(h) };
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("|"); // Turn around
    #local Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = function(x, y, z, l, r, h, a, s) { h + pi };
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("-"); // Turn Anticlockwise
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = function(x, y, z, l, r, h, a, s) { h + select(s, -a, +a, -a) };
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("+"); // Turn Clockwise
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = function(x, y, z, l, r, h, a, s) { h + select(s, +a, -a, +a) };
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("&"); // Swap Turn Directions
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = function(x, y, z, l, r, h, a, s) { select(s, 0, 1, 0) };

#end // macro InsertBasicFunctions


#macro InsertLengthFunctions(Fns, LengthScale, LengthIncrement)

    #local S = asc(">");
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = function(x, y, z, l, r, h, a, s) { l*LengthScale + LengthIncrement };
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("<");
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = function(x, y, z, l, r, h, a, s) { (l - LengthIncrement)/LengthScale };
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];

#end // macro InsertLengthFunctions


#macro InsertAngleFunctions(Fns, AngleScale, AngleIncrement)

    #local S = asc("(");
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = function(x, y, z, l, r, h, a, s) { (a - AngleIncrement)/AngleScale };
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc(")");
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = NoChangeFunctions[I_R];
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = function(x, y, z, l, r, h, a, s) { a*AngleScale + AngleIncrement };
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];

#end // macro InsertAngleFunctions


#macro InsertRadiusFunctions(Fns, RadiusScale, RadiusIncrement)

    #local S = asc("!");
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = function(x, y, z, l, r, h, a, s) { (r - RadiusIncrement)/RadiusScale };
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #local S = asc("#");
    #declare Fns[S][I_X] = NoChangeFunctions[I_X];
    #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
    #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
    #declare Fns[S][I_L] = NoChangeFunctions[I_L];
    #declare Fns[S][I_R] = function(x, y, z, l, r, h, a, s) { r*RadiusScale + RadiusIncrement };
    #declare Fns[S][I_H] = NoChangeFunctions[I_H];
    #declare Fns[S][I_A] = NoChangeFunctions[I_A];
    #declare Fns[S][I_S] = NoChangeFunctions[I_S];

#end // macro InsertRadiusFunctions


#macro InsertNoChangeFunctions(Fns, Symbols)

    #for (I, 1, strlen(Symbols))
        #local Sym = substr(Symbols, I, 1);
        #local S = asc(Sym);
        #declare Fns[S][I_X] = NoChangeFunctions[I_X];
        #declare Fns[S][I_Y] = NoChangeFunctions[I_Y];
        #declare Fns[S][I_Z] = NoChangeFunctions[I_Z];
        #declare Fns[S][I_L] = NoChangeFunctions[I_L];
        #declare Fns[S][I_R] = NoChangeFunctions[I_R];
        #declare Fns[S][I_H] = NoChangeFunctions[I_H];
        #declare Fns[S][I_A] = NoChangeFunctions[I_A];
        #declare Fns[S][I_S] = NoChangeFunctions[I_S];
    #end // for

#end // macro InsertNoChangeFunctions

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro L_Transform(AxiomSymbols, L_Rules, NoOfIterations)

    #local AllSymbols = AxiomSymbols;
    #for (I, 1, NoOfIterations)
        #local IterSymbols = "";
        #for (J, 1, strlen(AllSymbols))
            #local Sym = substr(AllSymbols, J, 1);
            #local ProdSymbols = L_Rules[asc(Sym)];
            #if (strlen(ProdSymbols) > 0)
                #local IterSymbols = concat(IterSymbols, ProdSymbols);
            #end // if
        #end // for
        #local AllSymbols = IterSymbols;
    #end // for

    AllSymbols

#end // macro L_Transform


#macro L_Draw(Fns, SymbolString, StackSize, pStart, Length, Radius, Heading, Angle, Spheres, Cylinders)

    #if (StackSize > 0)
        #local SS = StackSize;
    #else
        #local SS = 100;
    #end // if
    #local PointsStack = array[SS];
    #local LengthsStack = array[SS];
    #local RadiiStack = array[SS];
    #local HeadingsStack = array[SS];
    #local AnglesStack = array[SS];
    #local SwapsStack = array[SS];
    #local p0 = pStart;
    #local Length0 = Length;
    #local Radius0 = Radius;
    #local Heading0 = Heading;
    #local Angle0 = Angle;
    #local Swap0 = 0;
    #local SP = -1;
    #if (Spheres)
        sphere { p0, Radius0 }
    #end // if
    #for (I, 1, strlen(SymbolString))
        #local Sym = substr(SymbolString, I, 1);
        #local S = asc(Sym);
        #switch (S)
            #case (asc("[")) // Push
                #local SP = SP + 1;
                #local PointsStack[SP] = p0;
                #local LengthsStack[SP] = Length0;
                #local RadiiStack[SP] = Radius0;
                #local HeadingsStack[SP] = Heading0;
                #local AnglesStack[SP] = Angle0;
                #local SwapsStack[SP] = Swap0;
                #break
            #case (asc("]")) // Pop
                #local p0 = PointsStack[SP];
                #local Length0 = LengthsStack[SP];
                #local Radius0 = RadiiStack[SP];
                #local Heading0 = HeadingsStack[SP];
                #local Angle0 = AnglesStack[SP];
                #local Swap0 = SwapsStack[SP];
                #local SP = SP - 1;
                #break
            #case (asc("@"))
                sphere { p0, Radius0 }
                #break
            #else
                #local p1 =
                    <
                        Fns[S][I_X](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0),
                        Fns[S][I_Y](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0),
                        Fns[S][I_Z](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0)
                    >
                ;
                #local Length1 =
                    Fns[S][I_L](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0);
                #local Radius1 =
                    Fns[S][I_R](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0);
                #local Heading1 =
                    Fns[S][I_H](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0);
                #local Angle1 =
                    Fns[S][I_A](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0);
                #local Swap1 =
                    Fns[S][I_S](p0.x, p0.y, p0.z, Length0, Radius0, Heading0, Angle0, Swap0);
                #if ((S != asc("f")) & (vlength(p1 - p0) > 1e-6))
                    #if (Cylinders)
                        cylinder { p0, p1, Radius0 }
                    #end // if
                    #if (Spheres)
                        sphere { p1, Radius1 }
                    #end // if
                #end // if
                #local p0 = p1;
                #local Length0 = Length1;
                #local Radius0 = Radius1;
                #local Heading0 = Heading1;
                #local Angle0 = Angle1;
                #local Swap0 = Swap1;
        #end // switch
    #end // for

#end // macro L_Draw


#macro L_DrawSpheres(Fns, SymbolString, StackSize, pStart, Length, Radius, Heading, Angle)

    L_Draw(Fns, SymbolString, StackSize, pStart, Length, Radius, Heading, Angle, true, false)

#end // macro L_DrawSpheres


#macro L_DrawCylinders(Fns, SymbolString, StackSize, pStart, Length, Radius, Heading, Angle)

    L_Draw(Fns, SymbolString, StackSize, pStart, Length, Radius, Heading, Angle, false, true)

#end // macro L_DrawCylinders

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare Functions = array[MaxNoOfSymbols][8];

InsertBasicFunctions(Functions)

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
