/* Cylinder based aligner orienter. */

include <rounded_cube.scad>
use <bevel_gears.scad>
use <parametric_involute_gear_v5.1.scad>
include <dispenser_parms.scad>

$fn=50;

pi=3.1415926535897932384626433832795;

module hollow_cylinder(r=10, h=1, w_thickness=.8) {
	difference() {
		union() {
			cylinder(r=r-0.2, h=h);
		} /* union */
		translate([0,0,-0.1])cylinder(r=r-w_thickness, h=h+0.2);
	} /* difference */
} /* hollow_cylinder */

module aligner_limb(center_size=[10,10,4], 
						limb_length=(((platform_size.x-10)-20)/2-1),
						limb_width=3,
						limb_height=4) {
	
	limb_size=[limb_length, limb_width, limb_height];
	difference() {
		/* Full object shapes */
		union() {
			translate([0,0,limb_height/2])
				rounded_cube_x2(center_size, radius=2, center=true);
			rotate([0,0,10]) {
				translate([limb_size.x/2+center_size.x/2-2,0,limb_size.z/2])
					rounded_cube_x2(limb_size, radius=1, center=true);
				translate([limb_size.x/2+center_size.x/2+5,0,limb_size.z-0.1])
					scale([0.5,1.0,1.0])
					cylinder(r=limb_size.y/2, h=limb_size.z*.80);
			} /* rotate */
			rotate([0,0,-10]) {
				translate([limb_size.x/2+center_size.x/2-2,0,limb_size.z/2])
					rounded_cube_x2(limb_size, radius=1, center=true);
				translate([limb_size.x/2+center_size.x/2+5,0,limb_size.z])
					scale([0.5,1.0,1.0])
					cylinder(r=limb_size.y/2, h=limb_size.z*.80);
			}
		} /* union */
		/* Spaces in object */
//		union() {
			/* Drive shaft hole for aligner motion */
			translate([0,0,0]) {
				difference() {
					translate([0,0,-0.1]) difference() {
						cylinder(r=3.3/2, h=25, $fn=40, center=true);
						translate([-3.3/2, 3.3/2-0.7, -25/2])
							cube([20, 20, 25]);
					} /* difference */
				}
//				cube([5.3,2,20], center=true);
//				cube([2,5.3,20], center=true);
			} /* translate */
//		} /* union */
	} /* difference */
} /* aligner_limb */

module aligner_arena(arena_size = 80) {
	gear_diam = platform_size.x-11;
	gear_circle = gear_diam*pi;
	tooth_pitch = 3;
	num_teeth = floor(gear_circle/tooth_pitch);
	difference() {
		union() translate([0,0,platform_size.z/2]) {
			/* Cylinder for Arena ring */
			cylinder(r=(platform_size.x-20)/2, h=wall_height);
			rotate([0,0,200])	render() intersection() {
				/* Arena clamping ring */
				cylinder(r=(platform_size.x-10)/2, h=wall_thickness);
				pie_slice(gear_diam/2+3, 0, 260, 5);
			}
			/* Stop to halt arena rotation */
			rotate([0,0,293]) translate([platform_size.x/2-18,platform_size.y/2-18,0])
				cylinder(r=4, h=wall_thickness);
			/* Stop to halt arena rotation */
			rotate([0,0,173]) translate([platform_size.x/2-18,platform_size.y/2-18,0])
				cylinder(r=4, h=wall_thickness);
			/* Stop to halt arena rotation */
			rotate([0,0,53]) translate([platform_size.x/2-18,platform_size.y/2-18,0])
				cylinder(r=4, h=wall_thickness);
			rotate([0,0,210]) translate([platform_size.x/2-18,platform_size.y/2-18,0])
				cylinder(r=4, h=wall_thickness);
			/* Stop to halt arena rotation */
			rotate([0,0,330]) translate([platform_size.x/2-18,platform_size.y/2-18,0])
				cylinder(r=4, h=wall_thickness);
*			translate([(platform_size.x/2-12)*cos(pill_exit_angle),
						(platform_size.x/2-12)*sin(pill_exit_angle),0])
				cylinder(r1=(pill_size+2)/2+wall_thickness, r2=(pill_size+4)/2+wall_thickness,
							h=wall_height);

			translate([0, 0, 0]) {
				render() intersection() {
					pie_slice(gear_diam/2+3, 100, 200, 5);
					gear(circular_pitch=3, number_of_teeth=num_teeth, gear_thickness=wall_thickness,
						hub_thickness=0, rim_thickness=wall_thickness);
				} /* intersection */
			}
		} /* union */
		/* empty out aligner cylinder */
		translate([0,0,platform_size.z+0.1]) cylinder(r=(platform_size.x-20)/2-wall_thickness,
					 h=wall_height);
		/* Drive shaft hole */
		translate([0,0,-platform_size.z]) cylinder(r=m3_clearance/2, h=wall_height);
		/* Pill exit hole */
		rotate([0,0,pill_exit_angle])
			translate([(platform_size.x/2-18), 0, platform_size.z/2-0.1])
				cylinder(r1=(pill_size+2)/2, r2=(pill_size+10)/2, h=platform_size.z-0.49);
	} /* difference */
} /* aligner_arena */

module 	aligner_arena_bracket(arena_size = 80) {
	mirror() difference() {
		union() translate([0,0,platform_size.z/2]) {
			/* Arena clamping ring */
			cylinder(r=(arena_size+11)/2-0.1, h=wall_thickness*4);
			/* Mounting boss with screw hole to clamp down arena. */
			rotate([0,0,0]) translate([((arena_size+14)/2),0,0])
				cylinder(r=4*2, h=wall_thickness*4);
			/* Mounting boss with screw hole to clamp down arena. */
			rotate([0,0,120]) translate([((arena_size+14)/2),0,0])
				cylinder(r=4*2, h=wall_thickness*4);
			/* Mounting boss with screw hole to clamp down arena. */
			rotate([0,0,240]) translate([((arena_size+14)/2),0,0])
				cylinder(r=4*2, h=wall_thickness*4);
			/* Gear cover. */
			rotate([0,0,270]) translate([((arena_size+16)/2),0,-wall_thickness*1.2])
				cylinder(r=5*2, h=wall_thickness*5.2);
		} /* union */
		cylinder(r=40.5,h=10);
		/* Arena clamping ring */
		translate([0,0,-wall_thickness*3.6]) cylinder(r=(arena_size+11)/2-0.1, h=wall_thickness*4);
		/* Mounting boss with screw hole to clamp down arena. */
		rotate([0,0,0]) translate([((arena_size+22)/2),0,0])
			cylinder(r=2.4, h=wall_thickness*6);
		/* Mounting boss with screw hole to clamp down arena. */
		rotate([0,0,120]) translate([((arena_size+22)/2),0,0])
			cylinder(r=2.4, h=wall_thickness*6);
		/* Mounting boss with screw hole to clamp down arena. */
		rotate([0,0,240]) translate([((arena_size+22)/2),0,0])
			cylinder(r=2.4, h=wall_thickness*6);
		/* Gear cover space for gear. */
		rotate([0,0,270]) translate([((arena_size+18.5)/2),0,-wall_thickness*1.3])
			cylinder(r=2.8*2, h=wall_thickness*5);
		rotate([0,0,282]) translate([((arena_size+8)/2),0,-wall_thickness*1.3])
			cylinder(r=2.8*2, h=wall_thickness*1.8);
	} /* difference */
} /* aligner_arena_bracket */

/* Aligner limbs 2 at once for plastic cooling and use. */
*		aligner_limb();
*translate([-30,0,0]) rotate([0,0,180]) aligner_limb();

*rotate([0,0,270]) translate([0,0,al_base_height+base_size.z+wall_thickness])
	aligner_arena_bracket();

translate([0,95,wall_thickness*4+0.7]) rotate([0,180,90])
	aligner_arena_bracket();

*translate([0,0, al_base_height+platform_size.z/2+base_size.z/2]) // rotate([0,0,90-45/2])
	render() aligner_arena();
*translate([0,0, al_base_height+platform_size.z/2+base_size.z/2]) rotate([0,0,90-45/2])
	render() aligner_arena();
translate([0,0,-0.7]) rotate([0,0,0])
	aligner_arena();
