// Varyings for passing the coords from vertex to fragment stage.
varying vec2 lmcoordRed;
varying vec2 lmcoordGreen;
varying vec2 lmcoordBlue;

#ifdef VSH

// Internally sets the light map coordinates into `lmcoordRed`, `lmcoordGreen` and `lmcoordBlue`.
void setLightMapCoordinates() {
    lmcoordRed = (gl_TextureMatrix[1] * gl_MultiTexCoord1).st;
    lmcoordGreen = (gl_TextureMatrix[6] * gl_MultiTexCoord6).st;
    lmcoordBlue = (gl_TextureMatrix[7] * gl_MultiTexCoord7).st;
}

#endif

#ifdef FSH

// Set in RPLE any time a shader would have a `lightmap` uniform.
uniform sampler2D redLightMap;
uniform sampler2D greenLightMap;
uniform sampler2D blueLightMap;

// Returns the coloured light value of the current block light.
vec4 blockLight() {
    vec4 redLight = texture2D(redLightMap, lmcoordRed);
    vec4 greenLight = texture2D(greenLightMap, lmcoordGreen);
    vec4 blueLight = texture2D(blueLightMap, lmcoordBlue);

    return redLight * greenLight * blueLight;
}

#endif