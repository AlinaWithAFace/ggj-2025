shader_type canvas_item;

uniform sampler2D tex;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.a = COLOR.a*sin(.2+distance(UV, vec2(.5,.5)));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
