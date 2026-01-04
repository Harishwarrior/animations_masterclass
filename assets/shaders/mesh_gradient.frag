#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;  // The size of the canvas
uniform float uTime; // The current time (for animation)

out vec4 fragColor;  // The output color of the pixel

void main() {
    vec2 pos = FlutterFragCoord().xy / uSize; // Normalize coordinates to 0.0 - 1.0

    // Create moving color blobs using sin/cos and time
    float r = 0.5 + 0.5 * sin(uTime + pos.x * 3.0);
    float g = 0.5 + 0.5 * sin(uTime * 0.5 + pos.y * 3.0);
    float b = 0.5 + 0.5 * cos(uTime * 0.8 + (pos.x + pos.y) * 2.0);

    fragColor = vec4(r, g, b, 1.0);
}