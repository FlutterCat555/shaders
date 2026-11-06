shader_type canvas_item;

uniform float bands = 5.0;

void fragment() {
	COLOR = vec4(vec3(floor(UV.x*bands)/bands),1.0);
}
