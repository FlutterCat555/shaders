shader_type canvas_item;
//uniform means export maybe?
uniform float limit = 0.75;
uniform float height = 3.0;
uniform float amplitude = 3.0;
void vertex() {
	VERTEX.x = UV.x*limit;
	VERTEX.y = (VERTEX.y + sin(UV.x*amplitude+TIME)*UV.x/2.0)*height;
	///2.0*(UV.x*2.0);
	//VERTEX.x = VERTEX.x*-1.0;
}

void fragment() {
	//COLOR = vec4(UV.y/2.0+0.25,
	//0,
	//(UV.y/2.0+0.25)/2.5,
	//1.0
	//);
	COLOR = texture(TEXTURE,vec2(UV.x,1.0 - UV.y));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
