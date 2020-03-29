echo(version=version());

// The parameters can be found on internet, but cannot fully describe the complete sizing of the blocks.
// Therefore, assumptions are made to resemble a bearing housing block (e.g. angle of the base, bottom height).
// Parameters for SCxUU linear bearing housing (shaft size x, dimensions in [mm])
//Designation  
//     | Liner Bearing  
//     |      | Dynamic C [N]  
//     |      |    | Static Co [N]  
//     |      |    |     | Weight [gr]  
//     |      |    |     |    | Shaft Diameter  
//     |      |    |     |    |  |   h
//     |      |    |     |    |  |   |   D
//     |      |    |     |    |  |   |   |   W
//     |      |    |     |    |  |   |   |   |   H
//     |      |    |     |    |  |   |   |   |   |    G
//     |      |    |     |    |  |   |   |   |   |    |    A
//     |      |    |     |    |  |   |   |   |   |    |    |   J
//     |      |    |     |    |  |   |   |   |   |    |    |   |    E
//     |      |    |     |    |  |   |   |   |   |    |    |   |    |         S1×I
//     |      |    |     |    |  |   |   |   |   |    |    |   |    |         |   S2
//     |      |    |     |    |  |   |   |   |   |    |    |   |    |         |   |  K     > Long bearing 
//     |      |    |     |    |  |   |   |   |   |    |    |   |    |         |   |  |   L > block dimensions 
//     |      |    |     |    |  |   |   |   |   |    |    |   |    |         |   |  |   | > KL
//     |      |    |     |    |  |   |   |   |   |    |    |   |    |         |   |  |   | > |   LL
//---------------------------------------------------------------------------------------------------------------
// SC6UU  LM6UU  206   263   34  6   9  15  30  18   15    6  20    5      M4×8 3.4 18  25  36  48
// SC8UU  LM8UU  274   392   56  8  11  17  34  22   18    6  24    5      M4×8 3.4 18  30  42  58
//SC10UU LM10UU  372   549   90 10  13  20  40  26   21    8  28    6     M5×12 4.3 21  35  46  68
//SC12UU LM12UU  510   784  112 12  15  21  42  28   24    8  30.5  5.75  M5×12 4.3 26  36  50  70
//SC13UU LM13UU  510   784  123 13  15  22  44  30   24.5  8  33    5.5   M5×12 4.3 26  39  50  75
//SC16UU LM16UU  774  1180  189 16  19  25  50  38.5 32.5  9  36    7     M5×12 4.3 34  44  60  85
//SC20UU LM20UU  882  1370  237 20  21  27  54  41   35   11  40    7     M6×12 5.2 40  50  70  96
//SC25UU LM25UU  980  1570  555 25  26  38  76  51.5 42   12  54   11     M8×18 7.0 50  67 100 130 
//SC30UU LM30UU 1570  2740  685 30  30  39  78  59.5 49   15  58   10     M8×18 7.0 58  72 110 140
//SC35UU LM35UU 1670  3140 1100 35  34  45  90  68   54   18  70   10     M8×18 7.0 60  80 120 155
//SC40UU LM40UU 2160  4020 1600 40  40  51 102  78   62   20  80   11    M10×25 8.7 60  90 140 175
//SC50UU LM50UU 3820  7940 3350 50  52  61 122 102   80   25 100   11    M10×25 8.7 80 110 160 215

ID = 8;     // Shaft diameter
h  = 11;    // Shaft center position (height)
D  = 17;    // Shaft center position (width)
W  = 34;    // Width of the bearing block
H  = 22;    // Height of the bearing block
G  = 18;    // Height of the bearing block at the fastener holes
A  = 6;     // Base height
J  = 24;    // Fastener hole distance (width)
E  = 5;     // Distance of fastener hole center to outer width
S1 = 4;     // Metric screw value
S2 = 3.4;   // Fastener bore diameter
K  = 18;    // Fastener hole distance (depth)
L  = 30;    // Lenght of the bearing block
I  = 8;     // Screw tap depth
angle = 45; // Flange fairing angle
i1 = 2;     // Flange depth
diam = 16;  // Linear bearing diameter
tol = 0.2;  // Tolerance value

// Additional paramters
EL = 0;     // Additional length
centerHoles = false; // Insert holes in the center of the housing
B1 = 17.5 + EL;   // Distance between outer ring flanges
s  = 1.1;    // Ring width
sd = 0.3;   // Ring thickness


// Create sketch of bearing block
union(){
    difference() {
        // Bearing block housing polygon
        linear_extrude(height = L+EL) {
            polygon( points=[[0,0],[A,0],[A+i1,i1],[G,i1],[G,((W-J)/2+S1/2+1)],[H,((W-J)/2+S1/2+1)+(H-G)],[H,W-((W-J)/2+S1/2+1)-(H-G)],[G,W-((W-J)/2+S1/2+1)],[G,W-i1],[A+i1,W-i1],[A,W],[0,W],[0, W-(2*E)],[1,W-(2*E)-1],[1,(2*E)+1],[0,(2*E)]]);
        }
        // Substraction of the bearing cavity
        translate ([h,D,-tol]) {
            cylinder(h=L+EL+2*tol,d=diam,$fn=360);
        }
        // Cut out the bearing housing fastener holes (4 holes)
        rotate([0,90,0]){
            for (w=[0:1]) {
                for (h=[0:1]) {
                    translate([(K-(L))/2-h*(K+EL),E+w*J,-tol])
                    {
                        cylinder(d=S2,h=J+2*tol+30,$fn=360);
                    }
                }
            }
            // Additional center holes
            if (EL>0 && centerHoles) {
                for (w=[0:1]) {
                    for (h=[0:1]) {
                        translate([(K-(L+EL))/2-h*(K),E+w*J,-tol])
                        {
                            cylinder(d=S2,h=J+2*tol+30,$fn=360);
                        }
                    }
                }
            }
        }
    }
    // Create the chamfer rings for the bearings to snap in.
    for (i=[-1,1]) {
        translate ([h,D,i*((B1-s)/2)+(L+EL)/2]) {
            chamferRing(diam+tol,diam-2*sd,s);
        }
    }
}

module chamferRing(OD, ID, height){
    difference() {
        cylinder(h=height,d=OD,$fn=360,center=true);
        cylinder(h=height+1,d=ID,$fn=360,center=true);
        for (i=[-1,1]) {
            translate([0,0,i*(height/2)]) {
                ar1=ID/2;
                ar2=OD/2;
                cylinder(h=height/4,r1=(i*((ar1-ar2)/2)+(ar1+ar2)/2),r2=(i*((ar2-ar1)/2)+(ar1+ar2)/2),$fn=360,center=true);
            }
        }
    }
}

