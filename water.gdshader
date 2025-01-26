shader_type canvas_item;

uniform vec2 size = vec2(32.0, 28.0);
// If you intend to read from mipmaps with `textureLod()` LOD values greater than `0.0`,
// use `filter_nearest_mipmap` instead. This shader doesn't require it.
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
        vec2 mod_uv = SCREEN_UV+(sin(SCREEN_UV.y*10.0+TIME/3.0))/60.0;

        COLOR = textureLod(screen_texture, mod_uv, 0.0);
}