diam=3.6;
height=4;
$fn=128;
bigger_diam=6.4;

difference() {
    cylinder(r=diam/2+1.6,h=height);
    hull() {
        translate([0,0,2]) cylinder(r=diam/2,h=0.2);   
        translate([0,0,height-0.2]) cylinder(r=bigger_diam/2,h=0.2);
    }
    cylinder(r=diam/2,h=height);
}
