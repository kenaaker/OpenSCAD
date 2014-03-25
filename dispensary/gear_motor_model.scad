/* This is a model of the DC brush motor with gear box */

include <rounded_cube.scad>

$fn=40;
gear_box_size = [12,10,9.2];
motor_size = [12,10,15];
combined_motor_size = [12,10,9.2+15+6+11.9];

module gear_motor(model="181D41") {
	translate([0,0,gear_box_size.z/2+6/2]) {
		rounded_cube_x2(gear_box_size, radius=1, center=true);
		translate([0,0, gear_box_size.z/2-0.1])
			difference() {
				translate([0,0, 9.9/2])
					cylinder(r=3/2, h=9.9, center=true);
					translate([0,10/2+1,10/2+0.1]) cube([10,10,10], center=true);
			} /* difference */
		translate([0,0, -(motor_size.z/2+gear_box_size.z/2-0.1)])
			intersection() {
				cylinder(r=motor_size.x/2, h=motor_size.z, center=true);
				rounded_cube_x2(motor_size, radius=3, center=true);
			} /* intersection */
		translate([0,0, -(motor_size.z+gear_box_size.z/2+8/2-1)])
			cylinder(r=12/2, h=8, center=true);
	} /* translate */
}

//gear_motor();
