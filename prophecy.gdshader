shader_type canvas_item;

uniform sampler2D tex : filter_nearest;
uniform sampler2D foreground : filter_nearest;
//uniform vec2 offsets;
uniform float speed =0.1;
uniform float actualspeed = 2.0;
uniform float simspeed = 0.15;//this is amplitude
uniform float backAmplitudeModifier = 1.5;
uniform float scale = 0.5;
uniform float threshold = 0.5;
void vertex() {
	// Called for every vertex the material is visible on.
}

vec4 sfgx(vec4 fgx,vec2 uv, vec2 offsets){
	fgx *= step(0.0, uv.x+offsets.x) * step(0.0, uv.y+offsets.y) * step(uv.x+offsets.x, 1.0) * step(uv.y+offsets.y, 1.0);//crop edges
	fgx = mix(fgx,vec4(0.0,0.0,0.0,0.0),float(fgx.r<threshold));
	fgx = mix(fgx,texture(tex,vec2(fract(uv.x+(TIME*speed)),fract(uv.y-(TIME*speed)))),
	float(fgx.r>threshold));
	return fgx;
}
vec4 sfgx(vec4 fgx,vec2 uv){
	return sfgx(fgx,uv,vec2(0.0,0.0));
}

void fragment() {
	vec2 ofg0 = vec2(0.0,cos(TIME*actualspeed)*simspeed);
	vec2 ofg1 = vec2(sin(TIME*actualspeed)*simspeed*backAmplitudeModifier,sin(TIME*actualspeed)*simspeed*backAmplitudeModifier);
	vec2 uv = vec2((UV.x-0.5)/scale+0.5,1.0 - (UV.y-0.5)/scale-0.5);

	vec4 fg0 = texture(foreground,uv+ofg0);
	fg0 = sfgx(fg0,uv,ofg0);
	vec4 fg1 = texture(foreground,uv+ofg1);
	fg1 = sfgx(fg1,uv,ofg1);
	COLOR=mix(fg1,fg0,
	float(mix(0.5,1.0,fg0.a))
	);
	
	
	//vec4 fg1 = texture(foreground,uv);
	//
	//fg1 *= step(0.0, uv.x) * step(0.0, uv.y) * step(uv.x, 1.0) * step(uv.y, 1.0);//
	//fg1 = mix(fg1,vec4(0.0,0.0,0.0,0.0),float(fg1.r<threshold));
	//fg1 = mix(fg1,texture(tex,vec2(fract(UV.x+(TIME*speed)),fract(1.0-UV.y-(TIME*speed)))),float(fg1.r>threshold));
	//////note: fract fixes repeats
	//vec4 sampled2 = COLOR;
	//COLOR = mix(COLOR,fg1,float(mix(0.5,1.0,fg1.a)));
	//COLOR.a = 0.5;
	
//	experiment on movement w/o instances
//
//vec2 uv = vec2((UV.x - 0.5) / scale + 0.5,(1.0 - UV.y - 0.5) / scale + 0.5);
////uv.x = clamp(uv.x,0.0,1.0);
//vec2 offsets = vec2(sin(TIME),0);
//vec4 color = texture(foreground, vec2(uv.x+offsets.x,uv.y+offsets.y));
//color *= step(0.0, uv.x+offsets.x) * step(0.0, uv.y+offsets.y) * step(uv.x+offsets.x, 1.0) * step(uv.y+offsets.y, 1.0);//bullshit
//COLOR = color;
	
	
	//float(texture(foreground,vec2(UV.x,1.0 - UV.y)).r>0.1
	
	//fallback implementation
	
	//COLOR = mix(texture(foreground,vec2(UV.x,1.0 - UV.y)),texture(tex,vec2(UV.x,1.0 - UV.y)),
	//float(texture(foreground,vec2(UV.x,1.0 - UV.y)).r>0.1)//absolutely incomprehensible, darling.
	//);
	
	//COLOR = texture(foreground,vec2(UV.x,1.0 - UV.y));
}