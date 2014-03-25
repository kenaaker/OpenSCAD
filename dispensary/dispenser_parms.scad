/* Prescription dispensor constants. */

wall_thickness=2;
wall_height=10;
drive_shaft_diameter=7;
pill_size=9;
m2_for_thread = 2.1;
m3_for_thread = 3;
m3_clearance = 3.7;
m3_head = 6;

base_size = [100, 100, 2];
pillar_height = 25;
al_base_height = 33;
dispenser_height = 25;
dispenser_body_size = [80, 80, dispenser_height - 3];
dispenser_void_size = [80-2.5-wall_thickness*2, 80-wall_thickness*2, dispenser_height-1-wall_thickness];
dispenser_drawer_size = [dispenser_void_size.x-2, dispenser_void_size.y+5, dispenser_height - 5];
dispenser_drawer_void = [dispenser_void_size.x-2-wall_thickness*2,
		 dispenser_void_size.y+5-wall_thickness*2, dispenser_height - 4];
electronics_height = 50;


platform_radius=15;
pill_exit_angle=0;

arena_drive_gear_diameter = 25;
base_gear_diameter = 20;

mount_angle=-19;

base_radius=15;

sensor_module_base_size = [20,8,3.75];
sensor_module_led_size = [5, 5, 8.4];
sensor_led_offset = sensor_module_base_size.y/2;

pi=3.1415926535897932384626433832795;

platform_size = [100, 100, 1.4];

e_shell_size = [156,71,42];
e_shell_hollow = [152,67,38];
display_shell_size = [40,40,8];
