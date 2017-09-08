vec4 boxBlurX( Image texture, int x, int radius ){
    int min = x - radius;
    int max = x + radius;

    for(int i=min;i<max;i++){

	}

    vec4 sum = vec4(0.0);
    return sum; 
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec4 sum = vec4(0.0);
  vec4 pixel = Texel(texture, texture_coords );
  return pixel;
}