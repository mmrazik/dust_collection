
difference() {
import("C:\\Users\\martinmrazik\\Downloads\\Bosch_GCM_to_DN_40_Adapter.stl");
    translate([-50,0,25.9]) cube(100,100,100);

}
$fn=64;


translate([-16,35,25]) difference() {
    hull() {
        cylinder(r=45/2, h=0.1);
        translate([0,0,20]) cylinder(r=25, h=0.1);
    }
    hull() {
        cylinder(r=45/2-1.5, h=0.1);
        translate([0,0,20]) cylinder(r=25-1.5, h=0.1);
    }
}


translate([-16,35,45]) difference() {    
        #cylinder(r=50/2, h=10);
        cylinder(r=50/2-1.5, h=10);
}



    

