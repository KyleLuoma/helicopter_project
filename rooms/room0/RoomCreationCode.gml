
//build surface map array
var i;
global.surface_array = array_create(room_width + 100, room_height);
//surface_obj_array = array_create(instance_number(surface));

for (i = 0; i < instance_number(surface); i += 1) {
	surface_obj = instance_find(surface, i);

	var j;
	for (j = surface_obj.bbox_left; j <= surface_obj.bbox_right; j += 1) {
		if j >= 0 && surface_obj.bbox_top < global.surface_array[j] {
			global.surface_array[j] = surface_obj.bbox_top;
		}
	}
}