include <./NopSCADlib/vitamins/ssrs.scad>
include <./NopSCADlib/vitamins/ssr.scad>
include <./NopSCADlib/vitamins/screws.scad>
include <./NopSCADlib/vitamins/pcbs.scad>
include <./NopSCADlib/vitamins/leds.scad>
include <WAGO_221_mount.scad>

//include <templatebox.scad>

// Definition size of housing
// **************************

       // Those settings have to be identical to the cover !!!
width_x      = 180;          // Width of the housing (outer dimension)
debth_y      = 120;           // Debth of the housing (outer dimension)
wall         = 1.8;          // Wall thickness of the box
cornerradius = 4.0;          // Radius of the corners
                             //   This value also defines the posts for stability and
                             //   for the press-in nuts!

       // Those settings are more or less independent from the cover
height_z     = 65;           // Heigth of the lower part. Total height is this value plus
                             //   the height of the cover
plate        = 1.4;          // Thickness of the bottom plain

       //Definition size of press-in nuts
nutdiameter  = 4.0;          // Hole diameter for thermal press-in nut
nutlength    = 5.8;          // Depth of the nut hole


//Definition of circle angular resolution
resol        = 36;



module box() {
    center = true;
    difference () {

// Construction of housing
   union () {
   // Definition of main body
      difference () {
         union () {
            cube ( [width_x, debth_y - (2* cornerradius), height_z], center = center );
            cube ( [width_x - (2* cornerradius), debth_y, height_z], center = center );
         };
         translate ( [0,0, plate / 2] ){
            cube ( [width_x - (2* wall), debth_y- (2* wall), height_z - plate], center = center );
         };
      };

      // Construction of four corner cylinders including nut holes
      // 1st quadrant
      translate ( [(width_x / 2) - cornerradius, (debth_y / 2) - cornerradius, 0 ] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = center, $fn = resol);
            translate ( [ 0,0,(height_z / 2)-(nutlength / 2) ] ) {
               cylinder (h = nutlength, r = nutdiameter / 2, center = center, $fn = resol);
            };
         };
      };

      // 2nd quadrant
      translate ( [-(width_x / 2) + cornerradius, (debth_y / 2) - cornerradius, 0] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = center, $fn = resol);
            translate ( [ 0,0,(height_z / 2)-(nutlength / 2) ] ) {
               cylinder (h = nutlength, r = nutdiameter / 2, center = center, $fn = resol);
            };
         };
      };

      // 4th quadrant
      translate ( [(width_x / 2) - cornerradius, -(debth_y / 2) + cornerradius, 0] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = center, $fn = resol);
            translate ( [ 0,0,(height_z / 2)-(nutlength / 2) ] ) {
               cylinder (h = nutlength, r = nutdiameter / 2, center = center, $fn = resol);
            };
         };
      };

      // 3rd quadrant
      translate ( [-(width_x / 2) + cornerradius, -(debth_y / 2) + cornerradius, 0] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = center, $fn = resol);
            translate ( [ 0,0,(height_z / 2)-(nutlength / 2) ] ) {
               cylinder (h = nutlength, r = nutdiameter / 2, center = center, $fn = resol);
            };
         };
      };
   };

// Space for the construction of holes, breakouts, ...

};
}

module socket() {
    height=5;
    dimensions=50;
    difference() {
        union() {
            cube([dimensions,dimensions,height], center=true);
            translate([dimensions/2+12.5/2,0,0]) cube([12.5,25,height], center=true);
            translate([0,0,-socket_height+height/2]) cylinder(h=socket_height, r=44/2+2, center=false);
        }
        cylinder(h=height, r=44/2, center=true);
        
        translate([38.2/2,38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
        translate([-38.2/2,38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
        translate([38.2/2,-38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
        translate([-38.2/2,-38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
    }
    socket_height=44;
    
    
}


translate([68+20, -26, 5]) rotate([0,90,0]) {
    socket();
    translate([0,51,0]) socket();
}

box();
rotate([0,0,90]) translate([0,-10,-height_z+35]) ssr_assembly(SSR25DA, M3_cap_screw, 10);


translate([-45,35,0]) rotate([0,0,0]) pcb(ArduinoNano);
rotate([0,90,0]) led(LED5mm, "green");
rotate([0,0,90]) led(LED5mm, "red");



translate([-50,-60,0]) rotate([0,0,90]) #wago_mount();