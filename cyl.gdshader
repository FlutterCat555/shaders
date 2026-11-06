shader_type canvas_item;

uniform sampler2D tex : filter_nearest;
uniform float scale = 0.3;
uniform float ascale = 10.0;
uniform float rotation = 0.0;

uniform float colorbands = 5.0;

void vertex() {

	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = vec2(UV.x -0.5,1.0 - UV.y);
	float mask = cos(asin(uv.x/scale));
	mask=floor(mask*colorbands)/colorbands;
	float hmask = 1.0 - step(0.5,-mask);//hard mask
	vec4 vmask = vec4(vec3(//vector mask
		mask
		),1.0);
	//distort
	COLOR = mix(vec4(0.0),texture(tex,fract(vec2(
		asin(uv.x/scale)*scale*ascale-rotation,uv.y*ascale//this was hell
		))),hmask);
	COLOR*=vmask;//shading pass

	
	//COLOR = vec4(vec3(hmask),1.0);

}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
