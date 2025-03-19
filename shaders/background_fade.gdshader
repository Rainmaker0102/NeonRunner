shader_type canvas_item;

uniform float speed : hint_range(0.1, 5.0) = 0.5;
uniform float darkness : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float fade = (sin(TIME * speed) + 1.0) * 0.5; // Oscillates between 0 and 1
    float factor = mix(1.0, 1.0 - darkness, fade);
    
    COLOR = vec4(tex_color.rgb * factor, tex_color.a);
}
