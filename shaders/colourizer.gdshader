shader_type canvas_item;

uniform vec3 color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = color[0];
	COLOR.g = color[1];
	COLOR.b = color[2];
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
