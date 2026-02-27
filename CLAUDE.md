# CRITICAL: aOa Search Override

**ALWAYS use `aoa grep` instead of Grep/Glob tools.**

`aoa grep` and `aoa egrep` work like Unix grep/egrep but use O(1) indexed search (10-100x faster). Results include `file:func[range]:line` — use [range] to read only relevant code.

See `.aoa/USAGE.md` for commands, `.aoa/VALUE.md` for result anatomy.

---
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

"Cyber-Thor's Honey Heist" — a 2D arcade browser game designed during a game jam with teenagers. The game is a single `index.html` file using vanilla JavaScript and HTML5 Canvas. No frameworks, no external libraries, no build steps, no server required. Runs by opening the file directly in Chrome.

## Tech Constraints

- **Single file:** All HTML, CSS, and JavaScript must be inline in `index.html`
- **No dependencies:** No React, Phaser, or any external library
- **Graphics:** HTML5 Canvas with geometric primitives (`fillRect`, `arc`) — no external image files unless Base64-encoded inline
- **Canvas:** Fixed 800x600 resolution, dark `#111` background, centered on screen
- **Game loop:** Must use `requestAnimationFrame`

## Running the Game

Open `index.html` in Google Chrome. No build or serve step needed.

## Game Design (from short_prd.md)

- **Player:** Blue square ("Blocky Thor"), moves with WASD/Arrow keys, bounded by canvas edges
- **Collectibles:** Pollen (yellow circles, fill a bar — 10 pollen = 1 honey = +100 points), Tokens (gold squares, rare, +10% speed permanently), Blue Token (rare, triggers Optimus Rage mode)
- **Enemies:** Queen Bee (red rectangles, fast/small), Loki/Doom (purple rectangles, slow/large, slightly tracks player). Spawn at edges, move across screen
- **Collision:** Player touching enemy = -1 life (3 lives total). 0 lives = Game Over screen with Restart button
- **Wildcard events:** Lightning Zap (every 15-20s, screen flash + 1.5s stun), God Cloud (every 30s, floating text "YOU ARE THE BEE! GET OUT OF MY BUSINESS!" for 3s), Optimus Rage (blue token pickup → red, 2x size, invincible, destroy enemies for +50 points, lasts 5s)

## Development Rules

- **Single `state` object** holds all mutable data — player, enemies, items, score, lives, timers, flags
- **Delta-time normalization** — all movement/timers multiply by `dt`, clamp `dt` to max 1/30s
- **AABB collision** for everything — simple rectangle overlap checks
- **`resetState()` function** returns a fresh state object for restart (no mutation)
- **Section banners** in the code: `// === PLAYER ===`, `// === ENEMIES ===`, etc.
- **Named constants** for all magic numbers at the top of the script
- **Primitives first** — colored rectangles and circles, no sprites unless added later

## Repository Files

- `short_prd.md` — Full PRD with the exact AI prompt specification, image generation prompts (for Gemini), and sound effect sourcing notes (Freesound.org CC0, ZapSplat CC0)
- `setup.md` — The 6 scope-controlling questions methodology and AI prompt template
- `answers.md` — Transcript of the Q&A session with the kids that produced the game design
