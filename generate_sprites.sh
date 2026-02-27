#!/usr/bin/env bash
# generate_sprites.sh — Generate game sprites using Gemini image generation API
# Reads GEMINI_API_KEY from .env, saves base64 + decoded PNG to sprites/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.env"

if [ -z "${GEMINI_API_KEY:-}" ]; then
  echo "ERROR: GEMINI_API_KEY not set in .env"
  exit 1
fi

SPRITES_DIR="$SCRIPT_DIR/sprites"
mkdir -p "$SPRITES_DIR"

MODEL="gemini-2.0-flash-exp-image-generation"
API_URL="https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent"

# Check for jq
if ! command -v jq &>/dev/null; then
  echo "ERROR: jq is required. Install with: sudo apt install jq"
  exit 1
fi

generate_image() {
  local name="$1"
  local prompt="$2"
  local extra_config="${3:-}"

  echo "--- Generating: $name ---"
  echo "Prompt: $prompt"

  local body
  body=$(jq -n \
    --arg prompt "$prompt" \
    '{
      contents: [{ parts: [{ text: $prompt }] }],
      generationConfig: {
        responseModalities: ["TEXT", "IMAGE"]
      }
    }')

  local response
  response=$(curl -s -X POST "$API_URL" \
    -H "x-goog-api-key: $GEMINI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$body")

  # Check for errors
  local error
  error=$(echo "$response" | jq -r '.error.message // empty')
  if [ -n "$error" ]; then
    echo "ERROR generating $name: $error"
    echo "$response" > "$SPRITES_DIR/${name}_error.json"
    return 1
  fi

  # Extract base64 image data from response
  local b64_data
  b64_data=$(echo "$response" | jq -r '
    .candidates[0].content.parts[]
    | select(.inlineData != null)
    | .inlineData.data' | head -1)

  if [ -z "$b64_data" ] || [ "$b64_data" = "null" ]; then
    echo "WARNING: No image data in response for $name"
    echo "$response" | jq '.' > "$SPRITES_DIR/${name}_response.json"
    return 1
  fi

  # Save base64 data
  echo "$b64_data" > "$SPRITES_DIR/${name}.b64"

  # Decode to PNG
  echo "$b64_data" | base64 -d > "$SPRITES_DIR/${name}.png"

  local size
  size=$(wc -c < "$SPRITES_DIR/${name}.png")
  echo "OK: $name.png ($size bytes), $name.b64 saved"
  echo ""
}

echo "=== Cyber-Thor's Honey Heist — Sprite Generator ==="
echo "Using model: $MODEL"
echo ""

# 1. Player (Blocky Thor)
generate_image "player" \
  "A 2D 16-bit pixel art sprite of a blocky, Minecraft-style character dressed as Thor, holding a small glowing hammer. Blue armor, red cape, chibi proportions. Transparent background, flat lighting, facing right. 64x64 pixels, clean edges, game-ready sprite."

# 2. Queen Bee enemy
generate_image "queen_bee" \
  "A 2D 16-bit pixel art sprite of a small mechanical cyber Queen Bee enemy. Red and metallic colors, glowing red eyes, tiny buzzing wings, aggressive look. Transparent background, flat lighting, side view. 32x24 pixels, clean edges, arcade game style."

# 3. Loki/Doom enemy
generate_image "loki_doom" \
  "A 2D 16-bit pixel art sprite of a blocky comic-book villain in a purple hooded cloak, menacing pose. Purple and dark green colors, glowing eyes. Transparent background, flat lighting, facing left. 48x40 pixels, clean edges, retro arcade game style."

# 4. Pollen orb collectible
generate_image "pollen" \
  "A 2D 16-bit pixel art sprite of a small glowing yellow pollen orb. Bright yellow with golden sparkle highlights, perfectly round, slight glow effect. Transparent background. 24x24 pixels, clean edges, collectible game item style."

# 5. Gold Token collectible
generate_image "gold_token" \
  "A 2D 16-bit pixel art sprite of a shiny gold tech-token coin. Hexagonal shape, metallic gold with circuit pattern engraved, slight gleam. Transparent background. 24x24 pixels, clean edges, collectible game item style."

# 6. Blue Token collectible
generate_image "blue_token" \
  "A 2D 16-bit pixel art sprite of a glowing blue power crystal token. Electric blue with cyan lightning arcs, diamond shape, radiating energy. Transparent background. 24x24 pixels, clean edges, power-up game item style."

# 7. Background (800x600)
generate_image "background" \
  "A seamless 2D background for a retro video game, 800x600 resolution. Cybernetic cloudscape: dark indigo sky with fluffy purple-blue clouds mixed with glowing neon blue circuitry lines and small metallic structures. Cyberpunk aesthetic, 16-bit pixel art style. Stars and distant lightning in the background. No text, no characters."

echo "=== Done! Check sprites/ directory ==="
ls -la "$SPRITES_DIR"/*.png 2>/dev/null || echo "No PNG files generated."
