/* Mount / enclosure for an 18MP Raspberry Pi camera
 * 
 * Designed for 3D printing, long term use in growth chambers,
 * and to protect the camera from jostling and cable issues.
 * 
 * Contact:  zac.hatfield.dodds@gmail.com
 */
 
 // Currently maintained by Ming-Dao Chia 
 // (Ming-Dao.Chia@anu.edu.au)

$fn=128; // circles as n-sided shapes

/* Constants for parametric adjustment */
// XY size, z height
camXY = 31;
height = 45;
// height of enclosing walls
wallH = 20;
// width of surfaces (for strength and inset nut compatibility)
width = 4;
// dimensions of USB plug and cable to hold
usbW = 16.5;
usbD = 8.9;
cablediam = 5;
// width of bottom cutout and diam of lens hole (inc. spacing)
cutout = 6;
lens = 17;

// tripod mount size (slightly smaller to allow inset)
tripod=9-0.5;

// camera securing bar
screw=3+0.1;
depth=7;

// clip settings
display_thickness = 8; 
clip_thickness = 2; 

/* The actual design code */
//rotate([90,0,0]) // lay on back to print
translate([0,0,width])
difference() {
// Main brick to subtract from
translate([-width,-width,-width]) union(){
	cube([camXY+2*width,camXY+2*width,height]);
	}

//Cut off most of the top, except a post for the cable
difference(){
    // main cutting cube
	translate([-2*width,-2*width,wallH]) cube([camXY*2,camXY*2,height]);
	
    // don't cut off back wall
    translate([-width,-width,0]) cube([camXY*2,width,height]);

	}

// cut out spaces for the silicon, lens, wires, etc
// keeping a lip at the front...
difference(){
    cube([camXY,camXY+width+1,wallH+1]);
    translate([0, camXY, 0]) cube([2*camXY, width+1, display_thickness-2]);
};
translate([(camXY-cutout)/2,0,-1-width]) cube([cutout,camXY,width+2]);

// lens has to go in at an angle
translate([camXY/2,camXY/2,-1-width]) hull(){
    cylinder(d=lens,h=width+2);
    translate([0, 6, 0])cylinder(d=lens,h=width+2);
};

// hole for tripod mount
translate([width,0.01,wallH+tripod])
    rotate([90,0,0])
    cylinder(d=tripod,h=width+1);

// hole for securing bar
translate([-(width+1),camXY,(wallH-depth+screw)])
    rotate([0,90,0])
    cylinder(d=screw,h=camXY*2);

};

// clip (round bit)
translate([camXY/2, camXY+width/2+tripod*3,display_thickness+0.7])

intersection(){
    translate([0,0,-5])
    cylinder(d=tripod,h=camXY*2);
    difference(){
    translate([-5,0,0])
    rotate([0,90,0])
    cylinder(d=tripod,h=camXY*2);
    translate([-5,0,0])
    rotate([0,90,0])
    cylinder(d=tripod-5,h=camXY*2);
    translate([-tripod,-tripod,-2])
    cube([tripod*2,tripod*2,tripod*2]);
    }
}

// clip (back)
translate([camXY/2-tripod/2,camXY+width/2,display_thickness])
rotate([-8,0,0])
cube([tripod, tripod*3, 2]);

// clip (front)
translate([camXY-tripod/1.9,camXY+width/2,0])
rotate([0,0,0])
cube([tripod, tripod, 2]);
translate([camXY-tripod/1.9,camXY+tripod+width/2,1])
    rotate([0,90,0])
    cylinder(d=2,h=tripod);

translate([-tripod/2.1,camXY+width/2,0])
rotate([0,0,0])
cube([tripod, tripod, 2]);

translate([-tripod/2.1,camXY+tripod+width/2,1])
    rotate([0,90,0])
    cylinder(d=2,h=tripod);
