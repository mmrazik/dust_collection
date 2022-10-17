// Definition size of housing
// **************************

       // Those settings have to be identical to the box !!!
width_x      = 140;          // Width of the cover (outer dimension) 
debth_y      = 65;           // Debth of the cover (outer dimension)
wall         = 1.8;          // Side wall thickness of the cover
cornerradius = 4.0;          // Radius of the corners
                             //   This value also defines the posts for stability and
                             //   for the screw holes!

       // Those settings are more or less independent from the cover
height_z     = 4.5;          // Heigth of the cover. Total height is this value plus
                             //   the height of the box
plate        = 1.4;          // Thickness of top plate. Consider this value for the
                             //   elements which need to be mounted as well as for 
                             //   mechanical stability

       //Definition size of screws (Example value for M3 inner hex screw)
screwholediameter  = 3.2;    // Size of screw hole
screwheaddiameter  = 5.7;    // Size for screw head (diameter)
screwheadheigth    = 3.2;    // Heigth of the screw head
                             //   Screw head sits on top of cover if this value is set to zero
                             //   Consider material under screw head for mechanical strength 
                             //   when plunging screw 

//Definition of circle angular resolution
resol        = 36;           // Identical to housing !!!



difference () {

   // Construction Main Cover
   union () {
      difference () {
         // Construction of cover plate
         union () {
            cube ( [width_x, debth_y - (2* cornerradius), height_z], center = true );
            cube ( [width_x - (2* cornerradius), debth_y, height_z], center = true );
         };
         // Remove inner material
         translate ( [0,0, plate / 2] ){
            cube ( [width_x - (2* wall), debth_y- (2* wall), height_z - plate], center = true );
         };
         // Remove Screw hole in the 1st quadrant (required if screw head is thinner than plate!)
         translate ( [(width_x / 2) - cornerradius, (debth_y / 2) - cornerradius, 0 ] ) {
            cylinder ( h = height_z, r = screwheaddiameter / 2, center = true, $fn = resol );
         };
         // Remove Screw hole in the 2nd quadrant (required if screw head is thinner than plate!)
         translate ( [-(width_x / 2) + cornerradius, (debth_y / 2) - cornerradius, 0 ] ) {
            cylinder ( h = height_z, r = screwheaddiameter / 2, center = true, $fn = resol );
         };
         // Remove Screw hole in the 4th quadrant (required if screw head is thinner than plate!)
         translate ( [(width_x / 2) - cornerradius, -(debth_y / 2) + cornerradius, 0 ] ) {
            cylinder ( h = height_z, r = screwheaddiameter / 2, center = true, $fn = resol );
         };
         // Remove Screw hole in the 3rd quadrant (required if screw head is thinner than plate!)
         translate ( [-(width_x / 2) + cornerradius, -(debth_y / 2) + cornerradius, 0 ] ) {
            cylinder ( h = height_z, r = screwheaddiameter / 2, center = true, $fn = resol );
         };
      };

      // Construction of corner posts, screw holes and screw head holes
      //   in 1st quadrant
      translate ( [(width_x / 2) - cornerradius, (debth_y / 2) - cornerradius, 0 ] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = true, $fn = resol);
            cylinder (h = height_z, r = screwholediameter / 2, center = true, $fn = resol);
            translate ( [ 0, 0, - ( height_z / 2 ) + ( screwheadheigth / 2 ) ] ) {
               cylinder ( h = screwheadheigth, r = screwheaddiameter / 2, center = true, $fn = resol );
            };
         };
      };
      //   in 2nd quadrant
      translate ( [-(width_x / 2) + cornerradius, (debth_y / 2) - cornerradius, 0] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = true, $fn = resol);
            cylinder (h = height_z, r = screwholediameter / 2, center = true, $fn = resol);
            translate ( [ 0, 0, - ( height_z / 2 ) + ( screwheadheigth / 2 ) ] ) {
               cylinder ( h = screwheadheigth, r = screwheaddiameter / 2, center = true, $fn = resol );
            };
         };
      };
      //   in 4th quadrant
      translate ( [(width_x / 2) - cornerradius, -(debth_y / 2) + cornerradius, 0] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = true, $fn = resol);
            cylinder (h = height_z, r = screwholediameter / 2, center = true, $fn = resol);
            translate ( [ 0, 0, - ( height_z / 2 ) + ( screwheadheigth / 2 ) ] ) {
               cylinder ( h = screwheadheigth, r = screwheaddiameter / 2, center = true, $fn = resol );
            };
         };
      };
      //   in 3rd quadrant
      translate ( [-(width_x / 2) + cornerradius, -(debth_y / 2) + cornerradius, 0] ) {
         difference () {
            cylinder (h=height_z, r=cornerradius, center = true, $fn = resol);
            cylinder (h = height_z, r = screwholediameter / 2, center = true, $fn = resol);
            translate ( [ 0, 0, - ( height_z / 2 ) + ( screwheadheigth / 2 ) ] ) {
               cylinder ( h = screwheadheigth, r = screwheaddiameter / 2, center = true, $fn = resol );
            };
         };
      };
   };

   // Space for Breakouts, holes, ...


};
