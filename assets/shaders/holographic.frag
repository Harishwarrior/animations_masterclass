#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;

out vec4 fragColor;

void main() {
    // 1. Normalize coordinates (0.0 to 1.0)
    vec2 uv = FlutterFragCoord().xy / uSize;

    // 2. Create a diagonal coordinate system
    // We sum X and Y so the effect moves diagonally (top-left to bottom-right)
    float diagonalPos = uv.x + uv.y;

    // 3. The "Rainbow" Base (Cosine Palette)
    // We use a cosine function to cycle through RGB independently.
    // The offsets (0.0, 0.33, 0.67) ensure the colors are spaced out (Red, Green, Blue).
    // 't' slows down the color shift relative to the shimmer.
    float t = uTime * 0.2;
    vec3 rainbow = 0.5 + 0.5 * cos(6.28 * (diagonalPos * 1.5 + t + vec3(0.0, 0.33, 0.67)));

    // 4. The "Shimmer" Glare (Specular Highlight)
    // This creates those bright, sharp white lines that look like foil reflection.
    // We use a higher frequency (diagonalPos * 10.0) so the bands are thin.
    float shimmer = sin(diagonalPos * 10.0 - uTime * 2.0);
    
    // Sharpen the sine wave: pow() makes the peaks sharper and the valleys flatter.
    shimmer = pow(abs(shimmer), 8.0); 

    // 5. Combine
    // Mix the rainbow with the white shimmer. 
    // We add shimmer to the rainbow to "blow out" the highlights to white.
    vec3 finalColor = rainbow + vec3(shimmer * 0.5);

    fragColor = vec4(finalColor, 1.0);
}