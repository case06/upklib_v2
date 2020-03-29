$fn=100;

A=42;
R=4.8;
H=55;
X=13;
B=28;
D=15;
F=5;
C=29;
K=9.5;
P=22-3;

DIA608=22.2;
ESP608=7.5;
corte=2;



module cuerpo()

difference()
{
    union()
    {
        translate([H/2,D,0]) cylinder(d=B,h=X);
        cube([H,F,X]);
        translate([H/2-B/2,0,0]) cube([B,D,X]);
        translate([H/2-B/2-corte,F,0]) linear_extrude(height=X) polygon(points=[[0,0],[corte,0],[corte,corte]]);
        translate([H/2+B/2,F,0]) linear_extrude(height=X) polygon(points=[[0,0],[0,corte],[corte,0]]);

    }
    translate([H/2,D,X/2]) cylinder(d=DIA608,h=ESP608,center=true);
    translate([H/2,D,X/2]) cylinder(d=DIA608,h=ESP608);
    translate([H/2,D,0]) cylinder(d=P,h=X);
    translate([(H-A)/2,0,X/2]) rotate([-90,0,0]) cylinder(d=R,h=F);
    translate([(H-A)/2+A,0,X/2]) rotate([-90,0,0]) cylinder(d=R,h=F);
    rotate([0,90,0]) linear_extrude(height=H) polygon(points=[[0,0],[0,C],[-(X-K)/2,C]]);
    translate([0,0,X]) rotate([0,90,0]) linear_extrude(height=H) polygon(points=[[0,0],[0,C],[(X-K)/2,C]]);
    translate([0,0,corte]) rotate([-90,0,0]) linear_extrude(height=F) polygon(points=[[0,0],[0,corte],[corte,corte]]);
    translate([corte,0,X]) rotate([-90,90,0]) linear_extrude(height=F) polygon(points=[[0,0],[0,corte],[corte,corte]]);
    translate([H-corte,0,0]) rotate([-90,-90,0]) linear_extrude(height=F) polygon(points=[[0,0],[0,corte],[corte,corte]]);
    translate([H,0,X-corte]) rotate([-90,180,0]) linear_extrude(height=F) polygon(points=[[0,0],[0,corte],[corte,corte]]);

    translate([H/2,D,X/2+ESP608/2]) cylinder(d1=DIA608,d2=DIA608+corte*2,h=corte);
    translate([H/2,D,X/2+ESP608/2+corte]) cylinder(d=DIA608+corte*2,h=corte);

    translate([H/2,D,0]) hull()
    {
        translate([DIA608/2-corte/2,0,0]) cylinder(d=corte*2,h=X);
        translate([-DIA608/2+corte/2,0,0]) cylinder(d=corte*2,h=X);
    }
        
}


cuerpo();
