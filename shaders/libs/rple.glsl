// Varyings for passing the coords from vertex to fragment stage.
varying vec2 lmcoordRed;
varying vec2 lmcoordGreen;
varying vec2 lmcoordBlue;

#ifdef VSH

// These constants are defined in RPLE.
#define TEXTURE_MATRIX gl_TextureMatrix[1]
#define RED_LIGHTMAP_UV gl_MultiTexCoord1
#define GREEN_LIGHTMAP_UV gl_MultiTexCoord6
#define BLUE_LIGHTMAP_UV gl_MultiTexCoord7

// Internally sets the light map coordinates into `lmcoordRed`, `lmcoordGreen` and `lmcoordBlue`.
void setLightMapCoordinates() {
    lmcoordRed = (TEXTURE_MATRIX * RED_LIGHTMAP_UV).st;
    lmcoordGreen = (TEXTURE_MATRIX * GREEN_LIGHTMAP_UV).st;
    lmcoordBlue = (TEXTURE_MATRIX * BLUE_LIGHTMAP_UV).st;
}

#endif

#ifdef FSH

// Set in RPLE any time a shader would have a `lightmap` uniform.
uniform sampler2D lightmap_red;
uniform sampler2D lightmap_green;
uniform sampler2D lightmap_blue;

// Returns the coloured light value of the current block light.
vec4 blockLight() {
    vec4 redLight = texture2D(lightmap_red, lmcoordRed);
    vec4 greenLight = texture2D(lightmap_green, lmcoordGreen);
    vec4 blueLight = texture2D(lightmap_blue, lmcoordBlue);

    return redLight * greenLight * blueLight;
}

#endif