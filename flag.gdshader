shader_type spatial;

render_mode cull_disabled, blend_mix;

uniform sampler2D tex : filter_nearest;
uniform sampler2D texEnd : filter_nearest;
uniform float leny = 1;
uniform float amplitude = 4.0;
uniform float speed = 1;
uniform float intensityX = 0.1;
uniform float intensityZ = 0.1;



void vertex() {
	VERTEX.x += sin((TIME*speed)+UV.y*amplitude)*UV.y*(intensityX);
	VERTEX.y = VERTEX.y*leny-leny/2.0+0.5;
	VERTEX.z += cos((TIME*speed)+UV.y*amplitude)*UV.y*(intensityZ);
}



void fragment() {
	//ALBEDO = texture(tex,vec2(UV.x,UV.y*leny)).rgb;
	if(UV.y*leny>leny-1.0){//THIS IF STATEMENT'S LOGIC IS IMPORTANT, IT CONVERTS TO generic UNITS WHERE UV.y*leny = u. 
		ALBEDO = vec3(1,1,1);
		if(UV.y*leny>leny-0.001){ALPHA = 0.0;}else{//fixes 1px tall border.  not a very clean way to do this but if it works it works
		ALBEDO = texture(texEnd,vec2(UV.x,UV.y*leny-leny)).rgb;
		ALPHA = texture(texEnd,vec2(UV.x,UV.y*leny-leny)).a;
	}}else{
		ALBEDO = texture(tex,vec2(UV.x,UV.y*leny)).rgb;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
