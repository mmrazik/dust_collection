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
wall         = 2;          // Wall thickness of the box
cornerradius = 4.0;          // Radius of the corners
                             //   This value also defines the posts for stability and
                             //   for the press-in nuts!

       // Those settings are more or less independent from the cover
height_z     = 65;           // Heigth of the lower part. Total height is this value plus
                             //   the height of the cover
plate        = 2;          // Thickness of the bottom plain

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
    socket_height=27;
    difference() {
        union() {
            cube([dimensions,dimensions,height], center=true);
            translate([dimensions/2+12.5/2,0,0]) cube([12.5,25,height], center=true);
            translate([0,0,-socket_height-height/2]) cylinder(h=socket_height, r=44/2+2, center=false);
        }
        cylinder(h=height, r=44/2, center=true);
        
        translate([38.2/2,38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
        translate([-38.2/2,38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
        translate([38.2/2,-38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
        translate([-38.2/2,-38.2/2,0]) cylinder(h=height, r=4.1/2, center=true);
    }
}

module socket_holes() {
         
        cylinder(h=10, r=44/2, center=true);
        
        translate([38.2/2,38.2/2,0]) cylinder(h=10, r=4.1/2, center=true);
        translate([-38.2/2,38.2/2,0]) cylinder(h=10, r=4.1/2, center=true);
        translate([38.2/2,-38.2/2,0]) cylinder(h=10, r=4.1/2, center=true);
        translate([-38.2/2,-38.2/2,0]) cylinder(h=10, r=4.1/2, center=true);
}

module power_supply() {
    color("black") cube([35, 20.5, 15.5]);
}


insert_height=6;
insert_diameter = 4.3;

module insert_cone() {
    //insert_height = 6;  
      difference() {
        hull() {
            cylinder(r=insert_diameter/2+3,h=0.1, center=true);
            translate([0,0,insert_height-0.1]) cylinder(r=insert_diameter/2+1,h=0.1, center=true);
        }
        cylinder(r=insert_diameter/2, h=insert_height*2, center=true);
    }  
}

module insert_bar() {
    //insert_height=6;
    additional_width=20;
    difference() {
        cube([insert_height+2, 46+additional_width, insert_height]);
        translate([(insert_height+2)/2,(46+additional_width)/2,0]) cylinder(r=insert_diameter/2,h=insert_height);
        #translate([(insert_height+2)/2,5,0]) cylinder(r=1.8,h=insert_height);
        #translate([(insert_height+2)/2,(46+additional_width)-5,0]) cylinder(r=1.8,h=insert_height);
    }
}


module custom_pcb() {
    mounting_holes_width = 65.8;
    mounting_holes_depth = 45.8;
    
    //insert_cone();
    i_width = 2*(insert_diameter/2+3);
    difference() 
    translate([63,-3,-4]) rotate([0,0,90]) difference () {           
           cube([i_width,76,4]);
           translate([i_width/2,5,0]) #cylinder(r=1.8,h=4);        
            translate([i_width/2,76-5,0]) #cylinder(r=1.8,h=4);        
    }    
    
    translate([0.65+1.5,0.65+1.5,0]) insert_cone();
    translate([50-0.65-1.5,0.65+1.5,0]) insert_cone();    
    //translate([50-0.65-1.5,70-(0.65+1.5),0]) insert_cone();    
    //translate([0.65+1.5,70-(0.65+1.5),0]) insert_cone();
    //translate([0.65+1.5+mounting_holes_depth,0.65+1.5+mounting_holes_width+3,0]) insert_cone();

    /*
    %color("green") cube([50, 70, 1.2]);
    %translate([15,25,10]) rotate([0,0,90]) pcb(ArduinoNano);
    %translate([47,-10,0]) rotate([0,0,90]) power_supply();
    */
    //translate([0,65,5]) color("black") rotate([0,90,0]) cylinder(r=4.5, h=45); 

}

wago_ssr_offset = 15;
/*
translate([68+20-0.5, -26, 5]) rotate([0,90,0]) {
    %socket();
    %translate([0,51,0]) socket();
}*/
/*
difference() {
    union() {
        box();
        additional_wall = 6;
        translate([width_x/2-additional_wall,-debth_y/2+6, -height_z/2]) #cube([additional_wall,debth_y-12, height_z ]);
    }
    #translate([68+20-0.5, -26, 5]) rotate([0,90,0]) {
    socket_holes();
    #translate([0,51,0]) socket_holes();
    
    
    #translate([0,-10,-width_x])cylinder(r=8,h=10);
}
}
*/    
/*
rotate([0,0,0]) translate([wago_ssr_offset,25,-height_z+38.5+plate]) {
    %ssr_assembly(SSR25DA, M3_cap_screw, 10);
    translate([46/2-3.5,-23,-insert_height]) insert_bar();
    translate([-46/2-4.5,-23,-insert_height]) insert_bar();
}
*/


//rotate([0,0,0]) translate([wago_ssr_offset-44,-30, -height_z/2+22.5+plate]) wago_mount();


//translate([-50,35,-20]) rotate([0,0,90]) pcb(ArduinoNano);
//translate([-100+wago_ssr_offset+5,-30,-30]) custom_pcb(); 
//%rotate([0,90,0]) led(LED5mm, "green");
//%rotate([0,0,90]) led(LED5mm, "red");

insert_bar();
