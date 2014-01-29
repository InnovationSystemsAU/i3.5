use <hardware.scad>;

bearingsize = 13.3;	//outer diameter of bearings in mm
bearingwidth = 4.8;	//width of bearings in mm
bearingclampsize = 0.5;
bearingclamps = 3;
bearingclampangle = 60;
pulleythick = 1.2;
pulleyflangesize = 1.5;
beltwidth = 6.3;

$fn = 30;

module beltpulley() {
	difference() {
		union() {
			translate([0, 0, pulleythick / 2]) cylinder(h = pulleythick, r = bearingsize / 2 + pulleyflangesize + pulleythick, center = true);
			translate([0, 0, pulleythick + beltwidth + pulleyflangesize / 2]) cylinder(h = pulleyflangesize, r2 = bearingsize / 2 + pulleyflangesize + pulleythick, r1 = bearingsize / 2 + pulleythick, center = true);
			translate([0, 0, pulleythick + beltwidth / 2]) cylinder(h = pulleythick * 2 + beltwidth, r = bearingsize / 2 + pulleythick, center = true);
		}
		translate([0, 0, pulleythick * 1.5 + beltwidth / 2 + pulleyflangesize / 2]) cylinder(h = beltwidth + pulleythick + pulleyflangesize, r = bearingsize / 2, center = true);
		translate([0, 0, pulleythick + beltwidth + pulleyflangesize / 2 + 0.1]) cylinder(h = pulleyflangesize, r1 = bearingsize / 2 - pulleythick, r2 = bearingsize / 2 - pulleythick + pulleyflangesize, center = true);
		translate([0, 0, pulleythick / 2 + beltwidth / 2 + pulleyflangesize / 2]) cylinder(h = beltwidth + pulleythick * 2 + pulleyflangesize, r = bearingsize / 2 - bearingclampsize, center = true);
	}
	difference() {
		translate([0, 0, pulleythick + bearingclampsize + bearingwidth / 2]) cylinder(h = bearingclampsize * 2 + bearingwidth, r = bearingsize / 2 + pulleythick, center = true);
		translate([0, 0, pulleythick / 2 + bearingwidth / 2 + bearingclampsize]) cylinder(h = bearingwidth + pulleythick * 2 + bearingclampsize * 2, r = bearingsize / 2 - bearingclampsize, center = true);
		translate([0, 0, pulleythick + bearingwidth / 2]) cylinder(h = bearingwidth, r = bearingsize / 2, center = true);
		translate([0, 0, pulleythick + bearingwidth + bearingclampsize + bearingclampsize / 2 + 0.1]) cylinder(h = bearingclampsize, r1 = bearingsize / 2 - bearingclampsize, r2 = bearingsize / 2, center = true);
		translate([0, 0, pulleythick + bearingwidth + bearingclampsize / 2 - 0.1]) cylinder(h = bearingclampsize, r1 = bearingsize / 2, r2 = bearingsize / 2 - bearingclampsize, center = true);
		for (angle = [1:bearingclamps]) rotate([0, 0, 360 / bearingclamps * angle]) intersection() {
			translate([0, -bearingsize / 4 - pulleythick / 2, pulleythick + bearingclampsize + bearingwidth / 2]) cube([bearingsize + pulleythick * 2, bearingsize / 2 + pulleythick, bearingclampsize * 2 + bearingwidth + 0.1], center = true);
			rotate([0, 0, 360 / bearingclamps - bearingclampangle]) translate([0, bearingsize / 4 + pulleythick / 2, pulleythick + bearingclampsize + bearingwidth / 2]) cube([bearingsize + pulleythick * 2, bearingsize / 2 + pulleythick, bearingclampsize * 2 + bearingwidth + 0.1], center = true);
		}
	}
}

difference() {
	beltpulley();
	//cube([10, 10, 30]);
}
*%translate([0, 0, pulleythick + bearingwidth / 2]) bearing();