// ===  6mm to 8mm shaft adaptor
// ===  J.Beale July 18 2014

D1 = 8.1;	// OD: fit inside 8mm bearing (7.9: measure 7.7)
D2 = 6.2;	// ID:  allow 5.8 mm OD threaded rod in (5.6 => 5.15)
D3 = 13;    // OD: flange on one end
L1 = 11;    // overall length
L2 = 4;     // height of flange portion
// DSS = 2.6;  // diameter for M3 setscrew with some thread bite
HSS = 4;    // z-height from center of hole for M3 setscrew

// ==========================================================
fn = 100;	// number of facets on cylinder
eps = 0.05; // a small number

module adapt1() {
 translate([0,0,L1/2])
  difference() {
		cylinder(r=D1/2,h=L1,center=true,$fn=fn); // outer shell
		// translate([0,0,-eps]) 
         cylinder(r=D2/2,h=L1+eps,center=true,$fn=fn); // inner bore
	   // translate([0,0,HSS]) rotate([0,90,0])cylinder(r=DSS/2,h=D1*2,$fn=20,center=true); // setscrew #1
	   // translate([0,0,-HSS]) rotate([0,-90,0]) cylinder(r=DSS/2,h=D1*2,$fn=20); // setscrew #2
  }
} // end module


module flange() {
 translate([0,0,L2/2])
  difference() {
    cylinder(r=D3/2,h=L2,center=true,$fn=6); // hex flange
    cylinder(r=D2/2,h=L1+eps,center=true,$fn=fn); // inner bore

 }
}

adapt1();
flange();