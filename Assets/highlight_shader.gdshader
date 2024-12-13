shader_type canvas_item;

uniform vec4 highlight_color : source_color = vec4(1.0, 1.0, 0.5, 1.0);
uniform float glow_strength : hint_range(0.0, 1.0, 0.01) = 0.2;
uniform float pulse_range : hint_range(0.0, 1.0, 0.01) = 0.2;
uniform float pulse_speed : hint_range(0.1, 10.0, 0.1) = 4.0;

uniform float time : hint_range(0.0, 10.0) = 0.0;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	float pulse = glow_strength + sin(time * pulse_speed) * pulse_range;
    
	vec4 final_color = texture_color;

	if (texture_color.a > 0.0) { // Check for non-transparent pixels
		final_color.rgb += highlight_color.rgb * pulse;
	}

	COLOR = final_color;
}
