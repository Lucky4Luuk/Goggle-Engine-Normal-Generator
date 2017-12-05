vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
  vec2 uv = texture_coords;
  uv.y = 1 - uv.y;
  return Texel(texture, uv);
}
