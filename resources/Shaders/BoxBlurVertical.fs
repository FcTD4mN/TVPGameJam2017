extern vec2 size;
extern float radius;

vec4 effect(vec4 color, Image texture, vec2 tc, vec2 sc) {
	vec4 sum = vec4(0.0);
	float normalFactor = 1 / size.y;
	float normalizedRadius = radius * normalFactor;
	float stepAverage = 1 / ( radius * 2 );

	for( float i = tc.y - normalizedRadius; i < tc.y + normalizedRadius; i+= normalFactor )
	{
		sum += Texel(texture, vec2(tc.x, i)) * stepAverage; 
	}

	return sum;
}